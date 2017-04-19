<?php
// входные параметры
$searchstring = PrvFill('adsearch',$_POST['adsearch']);
if (isset($_GET['sort'])) {$sort = ' ORDER BY '.$_GET['sort'];}

// формируем элементы
$searchinfo = array (
 'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'bts_number'
,'start_line' => true
,'end_line' => true
);

$adsearchinfo = array (
 'el_type' => 'text'
,'value' => $searchstring 
,'id' => 'select_field'
,'name' => 'adsearch'
,'start_line' => true
,'end_line' => true
);

// основной запрос
$search_words=explode(' ',$searchstring);
if (strlen($search_words[0])>0)   {
  $search_where = " WHERE";
  for ($i=0; $i<count($search_words); $i++) {
    $w=$search_words[$i];
    if ($i>0) {$search_where.=" AND";}
      $search_where.=" (bts_number='$w' OR region LIKE '%$w%' OR area LIKE '%$w%' OR settlement LIKE '%$w%' OR street_name LIKE '%$w%' OR house_number LIKE '%$w%' OR place_owner LIKE '%$w%')";      
  }
  $sql = "SELECT";
  $sql.= " bts.Id as Id";
  $sql.= ",bts_number";
  $sql.= ",site_type";
  $sql.= ",region";
  $sql.= ",area";
  $sql.= ",CONCAT(type,' ',settlement) as settlement";
  $sql.= ",street_type";
  $sql.= ",street_name";
  $sql.= ",house_type";
  $sql.= ",house_number";
  $sql.= ",place_owner";
  $sql.= ",CONCAT(IFNULL(street_type,''),IFNULL(street_name,''),IFNULL(house_type,''),IFNULL(house_number,'')) as address";
  $sql.= " FROM bts";
  $sql.= " LEFT JOIN settlements";
  $sql.= " ON bts.settlement_id=settlements.id";
  $sql.= " LEFT JOIN areas";
  $sql.= " ON settlements.area_id=areas.id";
  $sql.= " LEFT JOIN regions";
  $sql.= " ON areas.region_id=regions.id";
  $sql.= $search_where;
  $sql.= $sort;
  $query=mysql_query($sql) or die(mysql_error());
}
// вывод элементов интерфейса

// блок интерфейса выбора и поиска
echo "<div id='inline'>";
echo "<form action='redirect.php?f=17' method='post'>введите номер БС:&nbsp;&nbsp;&nbsp;";
FieldEdit($searchinfo);
echo "&nbsp;&nbsp;&nbsp;<button type='submit'>выбрать</button>";
echo "</form>";
echo "</div>";

echo "<div id='inline'>";
echo "<form action='redirect.php?f=2' method='post' id='bts_list'>";
echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='pics/search_pic.png' width='18' height='18'>&nbsp;";
FieldEdit($adsearchinfo);
echo "&nbsp;&nbsp;&nbsp;<button type='submit'>поиск</button>";
echo "</form>";
echo "</div>";

// таблица результатов поиска
if (strlen($search_words[0])>0)   {
  echo "<div>";
  echo "<table id='result_table'>";
  echo "<tr align='center'>";  // заголовки
  echo "<td id='rs_td'></td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=bts_number&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;номер БС</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=site_type&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;тип сайта</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=region&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;область</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=area&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;район</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=settlement&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;нас.пункт</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=address&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;адрес</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=2&sort=place_owner&#039;,&#039;bts_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;размещение</td>";
  echo "</tr>";
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr>";
    echo "<td id='rs_td'><a href='#' title='подробное инфо' onclick='ad_edit(&#039;redirect.php?f=17&id=".$row['Id']."&#039;,&#039;bts_list&#039;);'><img src='pics/info_pic.png' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>".$row['bts_number']."</td>";
    echo "<td id='rs_td'>".$row['site_type']."</td>";
    echo "<td id='rs_td'>".$row['region']."</td>";
    echo "<td id='rs_td'>".$row['area']."</td>";
    echo "<td id='rs_td'>".$row['settlement']."</td>";
    echo "<td id='rs_td'>".FormatAddress('','',$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],'','')."</td>";
    echo "<td id='rs_td'>".$row['place_owner']."</td>";
    echo "</tr>";
  } 
  echo "</table>";
  echo "</div>";   
}
?> 