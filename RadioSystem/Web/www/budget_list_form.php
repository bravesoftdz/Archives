<?php
// входные параметры
$year=PrvFill('budget_year',$_POST['budget_year']);
$technology_generation=PrvFill('technology_generation',$_POST['technology_generation']);
$category=PrvFill('category',$_POST['category']);
$search=PrvFill('search',$_POST['search']);
if (isset($_GET['newsearch']) && strlen($search)>0) {$year=""; $technology_generation=""; $category="";}

// блок списка кнопок действий
if ($bg == 'w') {
  $info=array (
     'Новая Запись' => "redirect.php?f=13&id=0"
  );
  if (strlen($year)>0) $info["Выгрузить $year г.<br>в Excel"]="budget_to_excel.php?year=$year";
  
  ActionBlock($info);
}

// блок выбора типа бюджета
$sql="SELECT budget_year FROM budget GROUP BY budget_year ORDER BY budget_year DESC"; 
$query=mysql_query($sql) or die(mysql_error());
echo "<form action='index.php?f=11' method='post' id='budget_params'>выберите год бюджета:&nbsp;&nbsp;&nbsp;";

echo "<select size='1' id='select_field_small' name='budget_year' onchange='ad_edit(&#039;redirect.php?f=11&#039;,&#039;budget_params&#039;);'>";
echo "<option value=''></option>";
for ($i=0; $i<mysql_num_rows($query); $i++)
  {
  $row=mysql_fetch_array($query);
  if ($row[0]==$year) {$selected='selected';} else {$selected='';}
  echo "<option $selected value='$row[0]'>$row[0]</option>";
  }
echo "</select>";
echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;тип:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_small' name='technology_generation' onchange='ad_edit(&#039;redirect.php?f=11&#039;,&#039;budget_params&#039;);'>";
echo "<option value=''></option>";
if ($technology_generation=='2g') {$selected='selected';} else {$selected='';}
echo "<option $selected value='2g'>2G</option>";
if ($technology_generation=='3g') {$selected='selected';} else {$selected='';}
echo "<option $selected value='3g'>3G</option>";
if ($technology_generation=='2g/3g') {$selected='selected';} else {$selected='';}
echo "<option $selected value='2g/3g'>2G/3G</option>";
echo "</select>";
echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;категория:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_medium' name='category' onchange='ad_edit(&#039;redirect.php?f=11&#039;,&#039;budget_params&#039;);'>";
echo "<option value=''></option>";
if ($category=='new') {$selected='selected';} else {$selected='';}
echo "<option $selected value='new'>новое строительство</option>";
if ($category=='modern') {$selected='selected';} else {$selected='';}
echo "<option $selected value='modern'>модернизация</option>";
echo "</select>";
echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src='pics/search_pic.png' width='18' height='18'>&nbsp;<input type='text' size='25' name='search' value='$search'>&nbsp;&nbsp;&nbsp;<button type='submit' onclick='ad_edit(&#039;redirect.php?f=11&newsearch&#039;,&#039;budget_params&#039;);'>поиск</button>";
echo "</form>";

// таблица со списоком бюджета
$i=0;
if ($category=='new') {$cat="CONCAT(IFNULL(budget_type_2g,'_'),IFNULL(budget_type_3g,'_')) NOT LIKE '%модерн%'";$i=1;}
if ($category=='modern') {$cat="(budget_type_2g LIKE '%модерн%' OR budget_type_3g LIKE '%модерн%')";$i=1;}
if (strlen($year)>0) {if($i==1) $budget_year=" AND ";$budget_year.='budget_year='.NumOrNULL($year);$i=1;}
if (strlen($technology_generation)>0) {$technology_generation="technology_generation=".StrOrNull($technology_generation);if($i==1) $technology_generation=" AND ".$technology_generation;$i=1;}
$where="$cat $budget_year $technology_generation";
if (strlen($budget_year)>0) $where_2=" AND budget_year=$year";
if (isset($_GET['sort'])) {$order=$_GET['sort'];} else {$order='budget_number';}

// поиск
$search_words=explode(' ',$search);
if (strlen($search_words[0])>0)   {
  $search="&search=".$search;
  $search_where="";
  if (strlen(trim($where))>0) {$search_where.=" AND ";}
  for ($i=0; $i<count($search_words); $i++) {
  
    $w=$search_words[$i];
    if ($i>0) {$search_where.=" AND ";}
    switch (substr($w,0,3) ) {
      case "id=" : $search_where.="outside_id=".intval(substr($w,3,strlen($w) ) );
                   break;
      case "bs=" : $search_where.="bts_number='".(substr($w,3,strlen($w) ) )."'";
                   break;             
      default : $search_where.="(CONCAT(IFNULL(budget_type_2g,'_'),'_',IFNULL(budget_number_2g,'_')) LIKE '%$w%' OR CONCAT(IFNULL(budget_type_3g,'_'),'_',IFNULL(budget_number_3g,'_')) LIKE '%$w%' OR budget_year='".intval($w)."' OR bts_number='$w' OR settlements.settlement LIKE '%$w%' OR last_address.street_name LIKE '%$w%' OR last_address.house_number LIKE '%$w%' OR areas.area LIKE '%$w%' OR regions.region LIKE '%$w%' OR outside_id='".intval($w)."')";
    }  
  }
}     
if (strlen(trim($where))>0 || strlen(trim($search_where))>0) {
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
$sql=$sql.",formulars.id as formular_id ";
$sql=$sql."FROM budget ";
$sql=$sql."LEFT JOIN bts "; 
$sql=$sql."ON budget.bts_id=bts.id "; 
$sql=$sql."LEFT JOIN "; 
$sql=$sql."(SELECT * FROM (SELECT budget_id, street_type, street_name, house_type, house_number, settlement_id FROM budget_addresses,budget WHERE budget_addresses.budget_id=budget.id $where_2 ORDER BY budget_addresses.id DESC) p31 GROUP BY budget_id) last_address ";
$sql=$sql."ON budget.id=last_address.budget_id ";
$sql=$sql."LEFT JOIN settlements ";
$sql=$sql."ON last_address.settlement_id=settlements.id "; 
$sql=$sql."LEFT JOIN areas ";
$sql=$sql."ON settlements.area_id=areas.id ";
$sql=$sql."LEFT JOIN regions ";
$sql=$sql."ON areas.region_id=regions.id ";
$sql=$sql."LEFT JOIN formulars ";
$sql=$sql."ON formulars.budget_id=budget.id ";
$sql=$sql."WHERE $where $search_where ORDER BY $order ";
$query=mysql_query($sql) or die(mysql_error());

if (mysql_num_rows($query)>0)
  {
  echo "<div id='budget_table_block'><table id='result_table'>";
  echo "<tr align='center'><td id='rs_td'></td>";
  if ($bg=='w') {echo "<td id='rs_td'></td>";}  // иконки редактирования
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=technology_generation&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;тип</td><td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=budget_year&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;год</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=budget_number&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;номер бюджета</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=budget_source&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;источник</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=bts_number&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;номер БС</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=outside_id&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;внеш. id</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=11&sort=adress&#039;,&#039;budget_params&#039;);'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;адрес</td>";
  if ($bg=='w') {echo "<td id='rs_td'></td>";}  // иконки удаления
  echo "</tr>";
      
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row = mysql_fetch_array($query);
    echo "<tr><td id='rs_td'><a href='#' title='подробное инфо' onclick='ad_edit(&#039;redirect.php?f=12&id=".$row['Id']."&#039;,&#039;budget_params&#039;);'><img src='pics/info_pic.png' width='16' height='16'></a></td>";
    // иконки редактирования
    if ($bg=='w') echo "<td id='rs_td'><a href='#' title='редактировать' onclick='ad_edit(&#039;redirect.php?f=13&id=".$row['Id']."&#039;,&#039;budget_params&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>".$row['technology_generation']."</td><td id='rs_td'>".$row['budget_year']."</td>";
    echo "<td id='rs_td' style='width: 130px;'>".$row['budget_number']."</td>";
    echo "<td id='rs_td' style='width: 90px;'>".$row['budget_source']."</td>";
    echo "<td id='rs_td'>".$row['bts_number']."&nbsp;&nbsp;".(empty($row['formular_id'])? "" : "<img src='pics/fud_pic.png' width='25' height='16'>" )."</td>";
    echo "<td id='rs_td'>".$row['outside_id']."</td>";
    echo "<td id='rs_td' style='width: 355px;'>".FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])."</td>";
    // иконки удаления
    if ($bg=='w') echo "<td id='rs_td'><a href='#' title='удалить' onclick='confirmDelete(&#039;redirect.php?f=11&id=".$row['Id']."&del&#039;,&#039;budget_params&#039;);'><img src='pics/delete_pic.png' width='16' height='16'></a></td></tr>";
    }
  echo "</table></div>";
  }
  
// сводная информация
if (strlen($year)>0)
  {
  echo "<div id='budget_summary_block'><b>Бюджет $year года.</b>";
  echo "<br><br><b>2G</b><br>новое строительство:<br>";
  echo "<table id='additional_table'>";
  $sql="SELECT budget_source_2g, count(*) FROM budget WHERE budget_year=$year AND technology_generation in ('2g','2g/3g') AND (budget_type_2g NOT LIKE '%модерн%' OR budget_type_2g is NULL) GROUP BY budget_source_2g"; 
  $query=mysql_query($sql) or die(mysql_error());
  $sum=0;
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row = mysql_fetch_array($query);
    $sum=$sum+$row[1];
    echo "<tr><td id='ad_td' style='width:130px;'>".$row[0]."</td><td id='ad_td'>".$row[1]."</td></tr>";
    }
  echo "<tr><td id='ad_td' style='width:130px;'>всего</td><td id='ad_td'>$sum</td></tr>";  
  echo "</table>";  

  echo "<br>модернизация:<br>";
  echo "<table id='additional_table'>";
  $sql="SELECT budget_source_2g, count(*) FROM budget WHERE budget_year=$year AND technology_generation in ('2g','2g/3g') AND budget_type_2g LIKE '%модерн%' GROUP BY budget_source_2g"; 
  $query=mysql_query($sql) or die(mysql_error());
  $sum=0;
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row = mysql_fetch_array($query);
    $sum=$sum+$row[1];
    echo "<tr><td id='ad_td' style='width:130px;'>".$row[0]."</td><td id='ad_td'>".$row[1]."</td></tr>";
    }
  echo "<tr><td id='ad_td' style='width:130px;'>всего</td><td id='ad_td'>$sum</td></tr>";  
  echo "</table>";  

  echo "<br><br><b>3G</b><br>новое строительство:<br>";
  echo "<table id='additional_table'>";
  $sql="SELECT budget_source_3g, count(*) FROM budget WHERE budget_year=$year AND technology_generation in ('3g','2g/3g') AND (budget_type_3g NOT LIKE '%модерн%' OR budget_type_3g is NULL) GROUP BY budget_source_3g"; 
  $query=mysql_query($sql) or die(mysql_error());
  $sum=0;
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row = mysql_fetch_array($query);
    $sum=$sum+$row[1];
    echo "<tr><td id='ad_td' style='width:130px;'>".$row[0]."</td><td id='ad_td'>".$row[1]."</td></tr>";
    }
  echo "<tr><td id='ad_td' style='width:130px;'>всего</td><td id='ad_td'>$sum</td></tr>";  
  echo "</table>";  

  echo "<br>модернизация:<br>";
  echo "<table id='additional_table'>";
  $sql="SELECT budget_source_3g, count(*) FROM budget WHERE budget_year=$year AND technology_generation in ('3g','2g/3g') AND budget_type_3g LIKE '%модерн%' GROUP BY budget_source_3g"; 
  $query=mysql_query($sql) or die(mysql_error());
  $sum=0;
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row = mysql_fetch_array($query);
    $sum=$sum+$row[1];
    echo "<tr><td id='ad_td' style='width:130px;'>".$row[0]."</td><td id='ad_td'>".$row[1]."</td></tr>";
    }
  echo "<tr><td id='ad_td' style='width:130px;'>всего</td><td id='ad_td'>$sum</td></tr>";  
  echo "</table>";  

  echo "</div>";
  }    
}
?> 