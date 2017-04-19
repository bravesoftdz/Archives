<?php
// входные параметры
$function = $_SESSION['function'];
$department = $_SESSION['department'];
$searchstring = PrvFill('search',$_POST['search']);
if (empty($searchstring)) $category = PrvFill('category',$_POST['category']);
if (isset($_GET['sort'])) {$sort = ' ORDER BY '.$_GET['sort'];} else {$sort = ' ORDER BY -create_date, -formulars.id';}

$sql = "SELECT id FROM users WHERE department='ОЧПиОС' AND (function='согласование')";  // список id согласующ.
$query2 = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query2); $i++ ) {
  $row = mysql_fetch_array($query2);
  $dep2_accept_ids[] = $row[0];
}

// основной запрос
///////////////////////// КАТЕГОРИИ ФИЛЬТРОВ//////////////////////////////////////////////////////
if ($category == 'мои формуляры') {
  $where = " WHERE projector_user_id=$user_id AND TO_DAYS(NOW())-TO_DAYS(create_date) <= 365";
}

if ($category == 'выпущенные мной как ФУД') {
  $where = " WHERE fud_user_id=$user_id AND TO_DAYS(NOW())-TO_DAYS(create_date) <= 365";
}

if ($category == 'к присвоению номера') {
  $where = " WHERE ((dep1.action='sign' AND dep2_$dep2_accept_ids[0].action='sign' AND dep3.action='sign') OR (dep1.action='skip' AND dep2_$dep2_accept_ids[0].action='skip' AND dep3.action='skip')) AND bts_number IS NULL";
}

if ($category == 'к выпуску в lotus') {
  $where = " WHERE dep4.action='sign' AND to_lotus_date is NULL AND (bts_number IS NOT NULL OR repeater_id IS NOT NULL)";
}

if ($category == 'неподписанные больше 30 дней') {
  $where = " WHERE TO_DAYS(NOW())-TO_DAYS(create_date) <= 365 AND TO_DAYS(NOW())-TO_DAYS(to_lotus_date) > 30 AND signed_date IS NULL";
}

if ($category == 'все за последний год') {
  $where = " WHERE TO_DAYS(NOW())-TO_DAYS(create_date) <= 365";
}

if ($category == 'на подпись подразделения') {
  if ($_SESSION['department'] == "ОСПСД") $where = " WHERE dep1.action is NULL AND create_date>'2014-02-14'";
  if ($_SESSION['department'] == "ОЧПиОС") {
    $where = " WHERE (";
    for ($i=0; $i<count($dep2_accept_ids); $i++ ) {
      if ($i>0) $where.= " AND";
      $where.= " dep2_$dep2_accept_ids[$i].action='accept'";
    }
    $where.= ") OR (repeater_id IS NOT NULL AND dep2_30.action='accept')";
    $no_fixed_cond = "AND action<>'fixed'";
  }
  if ($_SESSION['department'] == "ОРТР") $where = " WHERE dep3.action='accept'";
  if ($_SESSION['department'] == "ОРРП") $where = " WHERE dep4.action='accept'";
}

if ($category == 'на согласование подразделения') {
  if ($_SESSION['department'] == "ОЧПиОС") {
    $where = " WHERE (dep1.action='sign' OR dep1.action='skip') AND (dep2_$user_id.action is NULL OR dep2_$user_id.action='fixed') AND accept_by_me.action IS NULL";
    if ($user_id==31) $where.= " AND (repeater_id IS NULL)";
    if ($function == 'чтение согласования') $where = " WHERE dep1.action='sign' AND dep2_$dep2_accept_ids[0].action<>'sign'";
  }  
  if ($_SESSION['department'] == "ОРТР") $where = " WHERE dep1.action='sign' AND (dep3.action is NULL OR dep3.action='fixed')";
  if ($_SESSION['department'] == "ОРРП") $where = " WHERE ((dep1.action='sign' AND dep2_$dep2_accept_ids[0].action='sign' AND dep3.action='sign') OR (dep1.action='skip' AND dep2_$dep2_accept_ids[0].action='skip' AND dep3.action='skip') OR ((dep1.action='skip' OR dep1.action='sign') AND dep2_$dep2_accept_ids[0].action='sign' AND dep3.action='skip')) AND (dep4.action is NULL OR dep4.action='fixed') AND (bts_number IS NOT NULL OR repeater_id IS NOT NULL)";
}
/////////////////////////////////////////////////////////////////////////////////////////////

////////////////    ЗАПРОС ПРИ ПОИСКЕ   //////////////////////////////////////////////////////////
$search_words=explode(' ',$searchstring);
if (strlen($search_words[0])>0)   {
  $search_where = " WHERE";
  for ($i=0; $i<count($search_words); $i++) {
    $w=$search_words[$i];
    if ($i>0) {$search_where.=" AND";}
      $search_where.=" (bts_number='$w' OR repeater_number='$w' OR regions.region LIKE '%$w%' OR areas.area LIKE '%$w%' OR settlements.settlement LIKE '%$w%' OR bts.street_name LIKE '%$w%' OR bts.house_number LIKE '%$w%'";
      $search_where.=" OR rregions.region LIKE '%$w%' OR rareas.area LIKE '%$w%' OR rset.settlement LIKE '%$w%' OR repeaters.street_name LIKE '%$w%' OR repeaters.house_number LIKE '%$w%')";      
  }
}  
///////////////////////////////////////////////////////////////////////////////////////////////////
if (!empty($where) || !empty($search_where)) {
  $sql = "SELECT";
  $sql.= " formulars.Id";
  $sql.= ",create_date";
  $sql.= ",name";
  $sql.= ",surname";
  $sql.= ",middle_name";
  $sql.= ",formulars.type as formular_type";
  $sql.= ",settlements.type";
  $sql.= ",settlements.settlement";
  $sql.= ",areas.area";
  $sql.= ",regions.region";
  $sql.= ",bts.street_type";
  $sql.= ",bts.street_name";
  $sql.= ",bts.house_type";
  $sql.= ",bts.house_number";
  $sql.= ",CONCAT(ifnull(settlements.`type`,''),ifnull(settlements.settlement,''),ifnull(bts.street_name,'')) as adress";
  
  $sql.= ",rset.type as rtype";
  $sql.= ",rset.settlement as rsettlement";
  $sql.= ",rareas.area as rarea";
  $sql.= ",rregions.region as rregion";
  $sql.= ",repeaters.street_type as rstreet_type";
  $sql.= ",repeaters.street_name as rstreet_name";
  $sql.= ",repeaters.house_type as rhouse_type";
  $sql.= ",repeaters.house_number as rhouse_number";
  $sql.= ",CONCAT(ifnull(rset.`type`,''),ifnull(rset.settlement,''),ifnull(repeaters.street_name,'')) as radress";
    
  $sql.= ",dep1.action as dep1_action";
  $sql.= ",dep1.action_date as dep1_date";
  
  for ($i=0; $i<count($dep2_accept_ids); $i++ ) {
    $sql.= ",dep2_$dep2_accept_ids[$i].action as dep2_$dep2_accept_ids[$i]_action";
    $sql.= ",dep2_$dep2_accept_ids[$i].action_date as dep2_$dep2_accept_ids[$i]_date";
  }
  
  $sql.= ",dep3.action as dep3_action";
  $sql.= ",dep3.action_date as dep3_date";
  $sql.= ",dep4.action as dep4_action";
  $sql.= ",dep4.action_date as dep4_date";
  $sql.= ",to_lotus_date";
  $sql.= ",signed_date";
  $sql.= ",bts_id";
  $sql.= ",bts_number";
  $sql.= ",repeater_id";
  $sql.= ",repeater_number";
  $sql.= ",accept_by_me.action";
  $sql.= " FROM formulars";
  $sql.= " LEFT JOIN users";
  $sql.= " ON formulars.projector_user_id=users.id";
  
  $sql.= " LEFT JOIN bts";
  $sql.= " ON formulars.bts_id=bts.id";
  $sql.= " LEFT JOIN settlements";
  $sql.= " ON bts.settlement_id=settlements.id";
  $sql.= " LEFT JOIN areas";
  $sql.= " ON settlements.area_id=areas.id";
  $sql.= " LEFT JOIN regions";     
  $sql.= " ON areas.region_id=regions.id";
  
  $sql.= " LEFT JOIN repeaters";
  $sql.= " ON formulars.repeater_id=repeaters.id";
  $sql.= " LEFT JOIN settlements rset";
  $sql.= " ON repeaters.settlement_id=rset.id";
  $sql.= " LEFT JOIN areas rareas";
  $sql.= " ON rset.area_id=rareas.id";
  $sql.= " LEFT JOIN regions rregions";     
  $sql.= " ON rareas.region_id=rregions.id";
  
  $sql.= " LEFT JOIN formular_actions dep1";     
  $sql.= " ON dep1.id = (SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department='ОСПСД' ORDER BY -id LIMIT 1)";
  
  for ($i=0; $i<count($dep2_accept_ids); $i++ ) {
    $temp = $dep2_accept_ids;
    $key = array_search($dep2_accept_ids[$i],$temp);
    if ($key !== false) unset($temp[$key]);    
    $sql.= " LEFT JOIN formular_actions dep2_$dep2_accept_ids[$i]";     
    $sql.= " ON dep2_$dep2_accept_ids[$i].id = (SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department='ОЧПиОС' AND user_id NOT IN (".implode(',',$temp).") $no_fixed_cond ORDER BY -id LIMIT 1)";   
  }
  $sql.= " LEFT JOIN formular_actions accept_by_me";     
  $sql.= " ON accept_by_me.id = (SELECT id FROM formular_actions WHERE formular_id=formulars.id AND user_id=$user_id AND action='accept' LIMIT 1)";
  
  
  $sql.= " LEFT JOIN formular_actions dep3";     
  $sql.= " ON dep3.id = (SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department='ОРТР' ORDER BY -id LIMIT 1)";
  $sql.= " LEFT JOIN formular_actions dep4";     
  $sql.= " ON dep4.id = (SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department='ОРРП' AND action<>'lotus' ORDER BY -id LIMIT 1)";   

  $sql.= $where;
  $sql.= $search_where;
  $sql.= " GROUP BY formulars.id";                  
  $sql.= $sort;
  $query=mysql_query($sql) or die(mysql_error());
}

// формируем элементы

// блок списка кнопок действий
if ($fm == 'w' && $function == 'выпуск ФПД') {
  $info=array (
     'Новый ФПД' => "index.php?f=19&id=0"
  );
  ActionBlock($info);
}

if ($fm == 'w' && $function == 'выпуск ФУД') {
  $info=array (
     'Новый ФУД' => "index.php?f=19&id=0&fud"
    ,'Новый ФУД Репитера' => "index.php?f=19&id=0&rfud"
  );
  ActionBlock($info);
}

if ($fm == 'w' && $function == 'выпуск репитеров') {
  $info=array (
     'Новый ФПД Репитера' => "index.php?f=19&id=0&rep"
  );
  ActionBlock($info);
}

// вывод элементов интерфейса
echo "<form action='redirect.php?f=1' method='post' id='formular_list'>";

echo "выберите список формуляров:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field' name='category' onchange='ad_edit(&#039;redirect.php?f=1&#039;,&#039;formular_list&#039;);'>";
echo "<option></option>";

if ($function == 'выпуск ФПД' || $function == 'выпуск репитеров') {
  if ($category=='мои формуляры') {$selected='selected';} else {$selected='';}
  echo "<option value='мои формуляры' $selected>мои формуляры</option>";  
}

if ($function == 'подпись') {
  if ($category=='на подпись подразделения') {$selected='selected';} else {$selected='';}
  echo "<option value='на подпись подразделения' $selected>на подпись подразделения</option>";  
  
  if ($department != 'ОЧПиОС') {
    if ($category=='на согласование подразделения') {$selected='selected';} else {$selected='';}
    echo "<option value='на согласование подразделения' $selected>на согласование подразделения</option>"; 
  }
  
  if ($category=='все за последний год') {$selected='selected';} else {$selected='';}
  echo "<option value='все за последний год' $selected>все за последний год</option>"; 
}

if ($function == 'согласование' || $function == 'чтение согласования') {
  if ($category=='на согласование подразделения') {$selected='selected';} else {$selected='';}
  echo "<option value='на согласование подразделения' $selected>на согласование подразделения</option>"; 
  if ($category=='все за последний год') {$selected='selected';} else {$selected='';}
  echo "<option value='все за последний год' $selected>все за последний год</option>"; 
}

if ($function == 'выпуск ФУД') {
  if ($category=='к присвоению номера') {$selected='selected';} else {$selected='';}
  echo "<option value='к присвоению номера' $selected>к присвоению номера</option>";
  if ($category=='к выпуску в lotus') {$selected='selected';} else {$selected='';}
  echo "<option value='к выпуску в lotus' $selected>к выпуску в lotus</option>";
  if ($category=='неподписанные больше 30 дней') {$selected='selected';} else {$selected='';}
  echo "<option value='неподписанные больше 30 дней' $selected>неподписанные больше 30 дней</option>";
  if ($category=='выпущенные мной как ФУД') {$selected='selected';} else {$selected='';}
  echo "<option value='выпущенные мной как ФУД' $selected>выпущенные мной как ФУД</option>";
  if ($category=='все за последний год') {$selected='selected';} else {$selected='';}
  echo "<option value='все за последний год' $selected>все за последний год</option>"; 
}

if (empty($function) ) {
  if ($category=='все за последний год') {$selected='selected';} else {$selected='';}
  echo "<option value='все за последний год' $selected>все за последний год</option>"; 
}

echo "</select>";

echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='pics/search_pic.png' width='18' height='18'>&nbsp;<input type='text' size='35' name='search' value='$searchstring'>&nbsp;&nbsp;&nbsp;<button type='submit' onclick='ad_edit(&#039;redirect.php?f=1&#039;,&#039;formular_list&#039;);'>поиск</button>";

echo "</form>";

if ($query) {
  if (mysql_num_rows($query)>0) {
  echo "<table id='result_table'>";
  echo "<tr align='center'>";  // заголовки
  echo "<td id='rs_td'></td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=1&sort=create_date&#039;,&#039;formular_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;дата</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=1&sort=surname&#039;,&#039;formular_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;проектировщик</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=1&sort=type&#039;,&#039;formular_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;тип</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=1&sort=adress&#039;,&#039;formular_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;адрес</td>";
  echo "<td id='rs_td'>ОСПСД</td>";
  echo "<td id='rs_td'>ОЧПиОС</td>";
  echo "<td id='rs_td'>ОРТР</td>";
  echo "<td id='rs_td'>ОРРП</td>";
  echo "<td id='rs_td'>Lotus</td>";
  echo "<td id='rs_td'>подписан</td>";
  echo "</tr>";
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr>";
    echo "<td id='rs_td'><a href='#' title='подробное инфо' onclick='ad_edit(&#039;redirect.php?f=20&id=".$row['Id']."&#039;,&#039;formular_list&#039;);'><img src='pics/info_pic.png' width='16' height='16'></a></td>";
    echo "<td id='rs_td' style='font-size:10px'>".$row['create_date']."</td>";
    echo "<td id='rs_td' style='width:90px'>".NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])."</td>";
    echo "<td id='rs_td' style='width:120px'>".$row['formular_type']."</td>";
    
    // адрес
    if ($row['bts_id']>0) {
      if (!empty($row['bts_number']) )  {$btsnum = ' БС'.$row['bts_number'];} else {$btsnum = '';}
      echo "<td id='rs_td' style='width:310px'>".FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])."$btsnum</td>";
    }
    if ($row['repeater_id']>0) {
      if (!empty($row['repeater_number']) )  {$btsnum = ' Репитер '.$row['repeater_number'];} else {$btsnum = '';}
      echo "<td id='rs_td' style='width:310px'>".FormatAddress($row['rtype'],$row['rsettlement'],$row['rstreet_type'],$row['rstreet_name'],$row['rhouse_type'],$row['rhouse_number'],$row['rarea'],$row['rregion'])."$btsnum</td>";
    }
    
    switch ($row['dep1_action']) {
      case 'sign': $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
        break;
      case 'decline': $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
        break; 
      case 'skip': $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
        break;    
      default: $icon = "";  
    }
    echo "<td id='rs_td' style='font-size:10px'>$icon".($row['dep1_action']=='sign' || $row['dep1_action']=='decline'? $row['dep1_date'] : '')."</td>";

    
    //  подразделение 2
    $icon = "";
    $date_display = "";
    for ($j=0; $j<count($dep2_accept_ids); $j++ ) {
      switch ($row["dep2_$dep2_accept_ids[$j]_action"]) {
        case 'sign': $icon = "<img src='pics/signed_pic.png' width='16' height='16'>"; 
                     $date_display = $row["dep2_$dep2_accept_ids[$j]_date"];
          break;
        case 'decline': $icon = "<img src='pics/decline_pic.png' width='16' height='16'>"; 
                        $date_display = $row["dep2_$dep2_accept_ids[$j]_date"];
          break;  
        case 'skip': $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>"; 
          break;     
      } 
    }
    echo "<td id='rs_td' style='font-size:10px'>$icon $date_display</td>";
    
    
    
    switch ($row['dep3_action']) {
      case 'sign': $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
        break;
      case 'decline': $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
        break;  
      case 'skip': $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
        break;     
      default: $icon = "";  
    }
    echo "<td id='rs_td' style='font-size:10px'>$icon".($row['dep3_action']=='sign' || $row['dep3_action']=='decline'? $row['dep3_date'] : '')."</td>";
    
    switch ($row['dep4_action']) {
      case 'sign': $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
        break;
      case 'decline': $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
        break; 
      case 'skip': $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
        break;      
      default: $icon = "";  
    }
    echo "<td id='rs_td' style='font-size:10px'>$icon".($row['dep4_action']=='sign' || $row['dep4_action']=='decline'? $row['dep4_date'] : '')."</td>";
    
    $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
    echo "<td id='rs_td' style='font-size:10px'>".(!empty($row['to_lotus_date'])? $icon.$row['to_lotus_date'] : '')."</td>";
    echo "<td id='rs_td' style='font-size:10px'>".(!empty($row['signed_date'])? $icon.$row['signed_date'] : '')."</td>";
    
    echo "</tr>";
  } 
  echo "</table>";
  }
}
?>      