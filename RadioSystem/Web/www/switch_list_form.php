<?php                  

// входные параметры
$function = $_SESSION['function'];
$is_all = true;
if ($function == 'отметка разрешения БелГИЭ') {
    $is_belgie = true;
    $is_all = false;
}
if ($function == 'отметка Актов ввода в эксплуатацию') {
    $is_act = true;
    $is_all = false;
}    

$searchstring = PrvFill('search', $_POST['search']);
if (isset($_GET['sort'])) {
    $sort = ' ORDER BY ' . $_GET['sort'];
    if ($_GET['sort'] != 'bts_number')
        $sort.= ' desc';
} else {
    $sort = ' ORDER BY bts_number';
}
if (isset($_GET['offset'])) {
    $limit = ' limit ' . $_GET['offset'] . ',500';
} else {
    $limit = ' limit 500';
}
$category = PrvFill('category',$_POST['category']);
$tech = PrvFill('tech',$_POST['tech']);

for ($i = 0; $i < 11; $i++) {
  switch($i) {
    case 0: $field = 'belgei_2g'; break; 
    case 1: $field = 'act_2g'; break;
    case 2: $field = 'gsm'; break;
    case 3: $field = 'dcs'; break;
    case 4: $field = 'belgei_3g'; break;
    case 5: $field = 'act_3g'; break;
    case 6: $field = 'umts2100'; break;
    case 7: $field = 'belgei_3g9'; break;
    case 8: $field = 'act_3g9'; break;
    case 9: $field = 'umts900'; break;
    case 10: $field = 'lte'; break;
    case 11: $field = 'stat'; break;
    case 12: $field = 'uninstall'; break;
  }
  if (isset($_GET["flt$i"])) {
    if ($_GET["flt$i"]==2) $search_where.=" AND $field is not NULL";
    if ($_GET["flt$i"]==3) $search_where.=" AND $field is NULL";
  } 
}

// формируем элементы
$adsearchinfo = array(
    'el_type' => 'text'
    , 'value' => $searchstring
    , 'id' => 'select_field'
    , 'name' => 'search'
    , 'start_line' => true
    , 'end_line' => true
);

// основной запрос
$search_words = explode(' ', $searchstring);
if (strlen($search_words[0]) > 0) {
    for ($i = 0; $i < count($search_words); $i++) {
        $w = $search_words[$i];
        $search_where.=" AND";
        $search_where.=" (bts_number='$w' or settlement like '%$w%' or street_name like '%$w%' or house_number='$w'";
        $search_where.=" or area='$w' or region='$w')";
    }
}

$_SESSION['transfer_description'] = 'Параметры фильтров:';
if ($category == 'включенные') {
  $search_where.= " and is_on=1";
}
if ($category == 'планируемые к включению') {
  $search_where.= " and is_on is null and ((belgei_2g is not null and act_2g is not null) or (belgei_3g is not null and act_3g is not null) or (lte is not null)) and stat is not null and uninstall is null";
}
if ($category == 'демонтированные') {
  $search_where.= " and uninstall is not null and is_on is null";
}
if ($category == 'планируемые к выключению') {
  $search_where.= " and uninstall is not null and is_on=1";
}
$_SESSION['transfer_description'].=' ['.$category.']';

if ($tech == '2G only') {
  $search_where.= " and is2g=1 and is3g=0 and is3g9=0 and is4g=0";
}
if ($tech == '2G/3G') {
  $search_where.= " and is2g=1 and (is3g=1 or is3g9=1)";
}
if ($tech == '3G only') {
  $search_where.= " and (is3g=1 or is3g9=1) and is2g=0 and is4g=0";
}
if ($tech == '3G 900') {
  $search_where.= " and is3g9=1";
}
if ($tech == '4G') {
  $search_where.= " and is4g=1";
}
$_SESSION['transfer_description'].=' ['.$tech.']';
$_SESSION['transfer_description'].=' ['.$searchstring.']';

$sql = "select * from ";
$sql.= "(select";
$sql.= " bts.id as Id";
$sql.= ",bts_number";
$sql.= ",belgei_2g";
$sql.= ",act_2g";
$sql.= ",gsm";
$sql.= ",dcs";
$sql.= ",belgei_3g";
$sql.= ",act_3g";
$sql.= ",umts2100";
$sql.= ",belgei_3g9";
$sql.= ",act_3g9";
$sql.= ",umts900";
$sql.= ",lte";
$sql.= ",stat";
$sql.= ",uninstall";
$sql.= ",settlements.type as set_type";
$sql.= ",settlements.settlement";
$sql.= ",areas.area";
$sql.= ",regions.region";
$sql.= ",bts.street_type";
$sql.= ",bts.street_name";
$sql.= ",bts.house_type";
$sql.= ",bts.house_number";
$sql.= ",case when plan_gsm_config_id>0 or plan_dcs_config_id>0 then 1 else 0 end as is2g";
$sql.= ",case when plan_umts_config_id>0 then 1 else 0 end as is3g";
$sql.= ",case when plan_umts9_config_id>0 then 1 else 0 end as is3g9";
$sql.= ",case when plan_lte_config_id>0 then 1 else 0 end as is4g";
$sql.= ",is_on";
$sql.= " from bts";
$sql.= " left join switchings sw on sw.bts_id=bts.id";
$sql.= " LEFT JOIN settlements";
$sql.= " ON bts.settlement_id=settlements.id";
$sql.= " LEFT JOIN areas";
$sql.= " ON settlements.area_id=areas.id";
$sql.= " LEFT JOIN regions";     
$sql.= " ON areas.region_id=regions.id) t";
$sql.= " where t.bts_number is not null";

// подключаем динамические условия
$sql.= $search_where;

// для передачи в сводную таблицу
$_SESSION['transfer_sql'] = $sql;

// подключаем сортировку
$sql.= $sort;

// лимит выдачи
$sql.= $limit;

$query = mysql_query($sql) or die(mysql_error());

// вывод элементов интерфейса
// блок интерфейса выбора и поиска
if (isset($sw) && $is_all) {
    $info["Выгрузить в Excel"]="switch_to_excel.php";
    ActionBlock($info);

    $info=array (
       'Сводная Таблица' => "index.php?f=37"
    ); 
    AdInfoBlock($info);
}


echo "<div>";
echo "<form action='redirect.php?f=34' method='post' id='switch_list'>";

echo "выберите список:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field' name='category' onchange='ad_edit(&#039;redirect.php?f=34&#039;,&#039;switch_list&#039;);'>";
if ($category=='все БС') {$selected='selected';} else {$selected='';}
echo "<option value='все БС' $selected>все БС</option>";
if ($category=='включенные') {$selected='selected';} else {$selected='';}
echo "<option value='включенные' $selected>включенные</option>";
if ($category=='планируемые к включению') {$selected='selected';} else {$selected='';}
echo "<option value='планируемые к включению' $selected>планируемые к включению</option>";
if ($category=='демонтированные') {$selected='selected';} else {$selected='';}
echo "<option value='демонтированные' $selected>демонтированные</option>";
if ($category=='планируемые к выключению') {$selected='selected';} else {$selected='';}
echo "<option value='планируемые к выключению' $selected>планируемые к выключению</option>";
echo "</select>";

echo "&nbsp;&nbsp;&nbsp;&nbsp;<select name='tech' onchange='ad_edit(&#039;redirect.php?f=34&#039;,&#039;switch_list&#039;);'>";
if ($tech=='all') {$selected='selected';} else {$selected='';}
echo "<option value='all' $selected>всё</option>";
if ($tech=='2G only') {$selected='selected';} else {$selected='';}
echo "<option value='2G only' $selected>2G only</option>";
if ($tech=='2G/3G') {$selected='selected';} else {$selected='';}
echo "<option value='2G/3G' $selected>2G/3G</option>";
if ($tech=='3G only') {$selected='selected';} else {$selected='';}
echo "<option value='3G only' $selected>3G only</option>";
if ($tech=='3G 900') {$selected='selected';} else {$selected='';}
echo "<option value='3G 900' $selected>3G 900</option>";
if ($tech=='4G') {$selected='selected';} else {$selected='';}
echo "<option value='4G' $selected>4G</option>";
echo "</select>";

echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='pics/search_pic.png' width='18' height='18'>&nbsp;";
FieldEdit($adsearchinfo);
echo "&nbsp;&nbsp;&nbsp;<button type='submit'>поиск</button>";
echo "</form>";
echo "</div>";

// таблица результатов поиска
echo "<div>";
echo "<table id='result_table'>";
echo "<tr align='center'>";  // заголовки
echo "<td id='rs_td'></td>";
if ($sw == 'w') {
    echo "<td id='rs_td'></td>";
}  // иконки редактирования
echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=bts_number&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;номер БС</td>";
echo "<td id='rs_td'>адрес</td>";
if ($is_all || $is_belgie) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=belgei_2g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;БелГИЭ 2G</td>";
}
if ($is_all || $is_act) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=act_2g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;акт экспл. 2G</td>";
}
if ($is_all) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=gsm&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;GSM</td>";
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=dcs&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;DCS</td>";
}
if ($is_all || $is_belgie) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=belgei_3g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;БелГИЭ 3G</td>";
}
if ($is_all || $is_act) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=act_3g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;акт экспл. 3G</td>";
}
if ($is_all) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=umts2100&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;UMTS 2100</td>";
}
if ($is_all || $is_belgie) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=belgei_3g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;БелГИЭ umts900</td>";
}
if ($is_all || $is_act) {
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=act_3g&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;акт экспл. umts900</td>";
} 
if ($is_all) { 
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=umts900&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;UMTS 900</td>";
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=lte&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;LTE (bCloud)</td>";
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=stat&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;статистика</td>";
    echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=34&sort=uninstall&#039;,&#039;switch_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;демонтаж</td>";
}
echo "</tr>";
echo "<tr>"; // фильтры
echo "<td id='rs_td'></td><td id='rs_td'></td><td id='rs_td'></td><td id='rs_td'></td>";
for ($i = 0; $i < 13; $i++) {
    if ($is_belgie && !in_array($i, array(0,4))) continue;
    if ($is_act && !in_array($i, array(1,5))) continue;

    $link = get_updated_http("flt$i",'fltval');
    $select_name = "flt$i"; 
    echo "<td id='rs_td'>";
    echo "<select id='select_field_small' name='$select_name' onchange='reloadBySelect(&#039;$select_name&#039;,&#039;$link&#039;)'>";
    if ($_GET["flt$i"]==1) $selected='selected'; else $selected=''; 
    echo "<option value='1' $selected>всё</option>";
    if ($_GET["flt$i"]==2) $selected='selected'; else $selected=''; 
    echo "<option value='2' $selected>не пустые</option>";
    if ($_GET["flt$i"]==3) $selected='selected'; else $selected=''; 
    echo "<option value='3' $selected>пустые</option>";
    echo "</select>";
    echo "</td>";
}
echo "</tr>";

function date_or_label($value) {
    if (strtotime($value) > 0) return $value;
    else if ($value=='on') return "вкл";    
    else if (!empty($value)) return "да";
    else return null;
}

for ($i = 0; $i < mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr>";
    echo "<td id='rs_td'><a href='#' title='подробное инфо' onclick='ad_edit(&#039;redirect.php?f=35&id=" . $row['Id'] . "&#039;,&#039;switch_list&#039;);'><img src='pics/info_pic.png' width='16' height='16'></a></td>";
    // иконки редактирования
    if ($sw == 'w')
        echo "<td id='rs_td'><a href='#' title='редактировать' onclick='ad_edit(&#039;redirect.php?f=36&id=" . $row['Id'] . "&#039;,&#039;switch_list&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>" . $row['bts_number'] . "</td>";
    echo "<td id='rs_td'>" . FormatAddress($row['set_type'], $row['settlement'], $row['street_type'], $row['street_name'], $row['house_type'], $row['house_number'], $row['area'], $row['region']) . "</td>";
    if ($is_all || $is_belgie) {
        echo "<td id='rs_td'>" . date_or_label($row['belgei_2g']) . "</td>";
    }
    if ($is_all || $is_act) {
        echo "<td id='rs_td'>" . date_or_label($row['act_2g']) . "</td>";
    }
    if ($is_all) {
        echo "<td id='rs_td'>" . date_or_label($row['gsm']) . "</td>";
        echo "<td id='rs_td'>" . date_or_label($row['dcs']) . "</td>";
    }
    if ($is_all || $is_belgie) {
        echo "<td id='rs_td'>" . date_or_label($row['belgei_3g']) . "</td>";
    }
    if ($is_all || $is_act) {
        echo "<td id='rs_td'>" . date_or_label($row['act_3g']) . "</td>";
    }
    if ($is_all) {
        echo "<td id='rs_td'>" . date_or_label($row['umts2100']) . "</td>";
    }   
    if ($is_all || $is_belgie) {
        echo "<td id='rs_td'>" . date_or_label($row['belgei_3g9']) . "</td>";
    }
    if ($is_all || $is_act) {
        echo "<td id='rs_td'>" . date_or_label($row['act_3g9']) . "</td>";
    }
    if ($is_all) { 
        echo "<td id='rs_td'>" . date_or_label($row['umts900']) . "</td>";
        echo "<td id='rs_td'>" . date_or_label($row['lte']) . "</td>";
        echo "<td id='rs_td'>" . date_or_label($row['stat']) . "</td>";
        echo "<td id='rs_td'>" . date_or_label($row['uninstall']) . "</td>";
    }
    echo "</tr>";
}
echo "</table>";
echo "</div>";

echo "<p>";
if (isset($_GET['sort']))
    $sort = "&sort=" . $_GET['sort'];
else $sort = "";    

// предыдущее
if ($_GET['offset'] > 0) {
    $offset = "&offset=" . ($_GET['offset'] - 500);
    echo "<a href='#' title='предыдущее 500' onclick='ad_edit(&#039;index.php?f=34$sort$offset&#039;,&#039;switch_list&#039;);'><< предыдущее 500</a>";
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
}
// следующие
if ($i > 499) {
    $offset = "&offset=" . ($_GET['offset'] + 500);
    echo "<a href='#' title='следующие 500' onclick='ad_edit(&#039;index.php?f=34$sort$offset&#039;,&#039;switch_list&#039;);'>следующие 500 >></a>";
}
echo "</p>";
?> 