<?php 
// входные параметры
$search = $_POST['search'];

// основной запрос
if ($_GET['object']=='budget') {
  
  $search_words=explode(' ',$search);
  if (strlen($search_words[0])>0) {
    $search_where="";
    for ($i=0; $i<count($search_words); $i++) {
      $w=$search_words[$i];
      if ($i>0) {$search_where.=" AND ";}
      $search_where.="(CONCAT(IFNULL(budget_type_2g,'_'),'_',IFNULL(budget_number_2g,'_')) LIKE '%$w%' OR CONCAT(IFNULL(budget_type_3g,'_'),'_',IFNULL(budget_number_3g,'_')) LIKE '%$w%' OR budget_year='".intval($w)."' OR bts_number='$w' OR settlements.settlement LIKE '%$w%' OR last_address.street_name LIKE '%$w%' OR last_address.house_number LIKE '%$w%' OR areas.area LIKE '%$w%' OR regions.region LIKE '%$w%' OR outside_id='".intval($w)."')";
    }  
    $sql="SELECT budget.Id"; 
    $sql=$sql.",technology_generation ";
    $sql=$sql.",CASE WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g) "; 
    $sql=$sql."      WHEN CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL AND CONCAT(budget_type_2g,'_',budget_number_2g) is NULL THEN CONCAT(budget_type_3g,'_',budget_number_3g) ";
    $sql=$sql."      WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g,'<br>',budget_type_3g,'_',budget_number_3g) "; 
    $sql=$sql." END as budget_number "; 
    $sql=$sql.",budget_year ";
    $sql=$sql.",bts.bts_number ";
    $sql=$sql.",outside_id  ";
    $sql=$sql.",last_address.street_type ";
    $sql=$sql.",last_address.street_name ";
    $sql=$sql.",last_address.house_type ";
    $sql=$sql.",last_address.house_number ";
    $sql=$sql.",settlements.`type` ";
    $sql=$sql.",settlements.settlement ";
    $sql=$sql.",areas.area ";
    $sql=$sql.",regions.region ";
    $sql=$sql.",CONCAT(ifnull(settlements.`type`,''),ifnull(settlements.settlement,''),ifnull(last_address.street_name,'')) as adress  ";
    $sql=$sql.",CASE WHEN budget_source_2g is not NULL AND budget_source_3g is NULL THEN budget_source_2g "; 
    $sql=$sql."      WHEN budget_source_3g is not NULL AND budget_source_2g is NULL THEN budget_source_3g ";
    $sql=$sql."      WHEN budget_source_2g is not NULL AND budget_source_3g is not NULL THEN CONCAT(budget_source_2g,'<br>',budget_source_3g) "; 
    $sql=$sql." END as budget_source "; 
    $sql=$sql." FROM budget";
    $sql=$sql." LEFT JOIN bts"; 
    $sql=$sql." ON budget.bts_id=bts.id"; 
    $sql=$sql." LEFT JOIN budget_addresses last_address"; 
    $sql=$sql." ON last_address.id=(SELECT id FROM budget_addresses WHERE budget_id=budget.id ORDER BY -id LIMIT 1)";
    $sql=$sql." LEFT JOIN settlements";
    $sql=$sql." ON last_address.settlement_id=settlements.id"; 
    $sql=$sql." LEFT JOIN areas";
    $sql=$sql." ON settlements.area_id=areas.id";
    $sql=$sql." LEFT JOIN regions";
    $sql=$sql." ON areas.region_id=regions.id";
    $sql.= " LEFT JOIN formulars";
    $sql.= " ON formulars.budget_id=budget.id";
    $sql=$sql." WHERE $search_where";
    $sql.= " AND budget_year>=".date('Y');
    $sql.= " AND formulars.budget_id is NULL";

    $query=mysql_query($sql) or die(mysql_error());
  }
}

// формируем элементы

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<form action='index.php?f=25&ff=".$_GET['ff']."&object=".$_GET['object']."' method='post' id='adsearch'>";
echo "<img src='pics/search_pic.png' width='18' height='18'>&nbsp;<input type='text' size='35' name='search' value='$search'>&nbsp;&nbsp;&nbsp;<button type='submit'>поиск</button>";
echo "</form>";

if (strlen($search_words[0])>0) {
  echo "<div id='budget_table_block'><table id='result_table'>";
  echo "<tr align='center'><td id='rs_td'></td>";
  echo "<td id='rs_td'>тип</td>";
  echo "<td id='rs_td'>год</td>";
  echo "<td id='rs_td'>номер бюджета</td>";
  echo "<td id='rs_td'>источник</td>";
  echo "<td id='rs_td'>номер БС</td>";
  echo "<td id='rs_td'>внеш. id</td>";
  echo "<td id='rs_td'>адрес</td>";
  echo "</tr>";
      
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr><td id='rs_td'><a href='#' title='выбрать' onclick='ad_edit(&#039;adsearch.php?ff=".$_GET['ff']."&id=".$row['Id']."&#039;,&#039;adsearch&#039;);'><img src='pics/select_pic.jpg' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>".$row['technology_generation']."</td><td id='rs_td'>".$row['budget_year']."</td>";
    echo "<td id='rs_td' style='width: 130px;'>".$row['budget_number']."</td>";
    echo "<td id='rs_td' style='width: 90px;'>".$row['budget_source']."</td>";
    echo "<td id='rs_td'>".$row['bts_number']."&nbsp;&nbsp;".(empty($row['formular_id'])? "" : "<img src='pics/fud_pic.png' width='25' height='16'>" )."</td>";
    echo "<td id='rs_td'>".$row['outside_id']."</td>";
    echo "<td id='rs_td' style='width: 355px;'>".FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])."</td>";
  }
  echo "</table></div>";
}
?>