<?php
// входные параметры
$searchstring = PrvFill('repeater_search',$_POST['repeater_search']);
if (isset($_GET['sort'])) {$sort = ' ORDER BY '.$_GET['sort'];}

// формируем элементы
$adsearchinfo = array (
 'el_type' => 'text'
,'value' => $searchstring 
,'id' => 'select_field'
,'name' => 'repeater_search'
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
      $search_where.=" (repeater_number='$w' OR region LIKE '%$w%' OR area LIKE '%$w%' OR settlement LIKE '%$w%' OR street_name LIKE '%$w%' OR house_number LIKE '%$w%' OR place_owner LIKE '%$w%')";      
  }
  $sql = "SELECT";
  $sql.= " repeaters.Id as Id";
  $sql.= ",repeater_number";
  $sql.= ",region";
  $sql.= ",area";
  $sql.= ",CONCAT(type,' ',settlement) as settlement";
  $sql.= ",street_type";
  $sql.= ",street_name";
  $sql.= ",house_type";
  $sql.= ",house_number";
  $sql.= ",place_owner";
  $sql.= ",CONCAT(IFNULL(street_type,''),IFNULL(street_name,''),IFNULL(house_type,''),IFNULL(house_number,'')) as address";
  $sql.= " FROM repeaters";
  $sql.= " LEFT JOIN settlements";
  $sql.= " ON repeaters.settlement_id=settlements.id";
  $sql.= " LEFT JOIN areas";
  $sql.= " ON settlements.area_id=areas.id";
  $sql.= " LEFT JOIN regions";
  $sql.= " ON areas.region_id=regions.id";
  $sql.= $search_where;
  $sql.= $sort;
  $query=mysql_query($sql) or die(mysql_error());
}
// вывод элементов интерфейса
if ($rm == 'w') {
  $info=array (
     'Новый Репитер' => "index.php?f=31&id=0"
  );
  ActionBlock($info);
}

// блок интерфейса выбора и поиска
//echo "<div id='inline'>";
echo "<div>";
echo "<form action='redirect.php?f=28' method='post' id='repeaters_list'>";
echo "&nbsp;&nbsp;&nbsp;<img src='pics/search_pic.png' width='18' height='18'>&nbsp;";
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
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=repeater_number&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;номер репитора</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=region&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;область</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=area&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;район</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=settlement&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;нас.пункт</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=address&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;адрес</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=28&sort=place_owner&#039;,&#039;repeaters_list&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;размещение</td>";
  echo "</tr>";
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr>";
    echo "<td id='rs_td'><a href='#' title='подробное инфо' onclick='ad_edit(&#039;redirect.php?f=30&id=".$row['Id']."&#039;,&#039;repeaters_list&#039;);'><img src='pics/info_pic.png' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>".$row['repeater_number']."</td>";
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