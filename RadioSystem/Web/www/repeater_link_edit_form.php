<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql = "SELECT"; 
$sql.=" link_bts_id";
$sql.=",link_type";
$sql.=",divider_type";
$sql.=",incut_place";
$sql.=" FROM repeaters";
$sql.=" WHERE repeaters.Id='$id'"; 
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

$sql = "SELECT *"; 
$sql.=" FROM repeater_sectors";
$sql.=" WHERE repeater_link_id='$id'"; 
$query = mysql_query($sql) or die(mysql_error());
$row2 = mysql_fetch_array($query); 

// формируем элементы
$sql = "SELECT bts_number,Id FROM bts WHERE bts_number IS NOT NULL ORDER BY bts_number";
$query = mysql_query($sql) or die(mysql_error());
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row3 = mysql_fetch_array($query);
  $list[] = array ('value'=>$row3[1], 'display'=>$row3[0]);
}
$info[] = array (
   'field' => 'БС привязки'
  ,'value' => PrvFill('link_bts_id',$row['link_bts_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'link_bts_id'
  ,'list' => $list
); 
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'Врезка в сущ. АФУ', 'display'=>'Врезка в сущ. АФУ')
);
$info[] = $info1 = array (
   'field' => 'тип привязки'
  ,'value' => PrvFill('link_type',$row['link_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'link_type'
  ,'list' => $list
);  
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'Ответвитель на -30 db', 'display'=>'Ответвитель на -30 db')
);
$info[] = $info1 = array (
   'field' => 'тип делителя'
  ,'value' => PrvFill('divider_type',$row['divider_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'divider_type'
  ,'list' => $list
);  
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'Между джампа-кабелем антенны и TMA', 'display'=>'Между джампа-кабелем антенны и TMA')
);
$info[] = $info1 = array (                         
   'field' => 'место врезки'
  ,'value' => PrvFill('incut_place',$row['incut_place'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'incut_place'
  ,'list' => $list
);  

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='repeater_link_edit.php?id=$id' method='post' id='repeater_link_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "</div>";
echo "<div style='clear:both'><br>";
echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>тип антенны</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>тип каб.</td><td id='rs_td'>примечание</td></tr>";
  
  // id и номер сектора
  echo "<input type='text' value='".$row2['Id']."' name='Id_0' hidden>";  // id
  echo "<input type='text' value='0' name='num_0' hidden>";  // num
      
  // тип антенны
  $value = PrvFill("antenna_type_id_0",$row2['antenna_type_id']);
  $sql = "SELECT antenna_type, Id FROM antenna_types GROUP BY antenna_type"; 
  $query = mysql_query($sql) or die(mysql_error());
  echo "<td id='rs_td'><select size='1' id='select_field_medium' name='antenna_type_id_0'>";
  echo "<option></option>";
  for ($j=0; $j<mysql_num_rows($query); $j++) {
  $row3 = mysql_fetch_array($query); 
  if ($value == $row3[1]) {$selected='selected';} else {$selected='';}
    echo "<option $selected value='".$row3[1]."'>".$row3[0]."</option>";
  }
  echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types&#039;,&#039;repeater_link_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // высота (размещение)
    $value=PrvFill("height_0",$row2['height']);
    echo "<td id='rs_td'><input type='text' value='$value' name='height_0' size='10'></td>";
  
    // азимут
    $value=PrvFill("azimuth_0",$row2['azimuth']);
    echo "<td id='rs_td'><input type='text' value='$value' name='azimuth_0' size='4' pattern='[0-9]*'></td>";
   
    // тип кабеля
    $value=PrvFill("cable_type_0",$row2['cable_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='cable_type_0'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    echo "</select></td>";
  
    // примечание
    $value=PrvFill("notes_0",$row2['notes']);
    echo "<td id='rs_td'>";
    echo "<textarea id='select_field_medium' name='notes_0'>$value</textarea>";
    echo "</td></tr>";
  
  echo "</table>";

echo "<p><button type='submit'>сохранить</button></p>";
echo "</div>";
echo "</form>";
?>