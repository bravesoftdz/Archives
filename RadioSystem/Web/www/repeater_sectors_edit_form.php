<?php
// входные параметры
$id = $_GET['id'];

// основной запрос
$sql = "SELECT * FROM repeater_sectors WHERE repeater_id='$id'"; 
$query = mysql_query($sql) or die(mysql_error());
$exist_number = mysql_num_rows($query);

$sql="SELECT antenna_type, Id FROM antenna_types GROUP BY antenna_type"; 
$query_at=mysql_query($sql) or die(mysql_error());

// формируем элементы
$row_number = PrvFill('row_number',$exist_number);
$info[] = $info1 = array (
   'value' => $row_number
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'row_number'
  ,'start_line' => true
  ,'end_line' => true
  ,'pattern' => '[0-9]*'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<form action='repeater_sectors_edit.php?id=$id' method='post' id='repeater_sectors_edit_form'>";

echo "введите количество строк для секторов репитера:&nbsp;&nbsp;&nbsp;";
FieldEdit($info[0]);
echo "&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=32&#039;,&#039;repeater_sectors_edit_form&#039;);'>выбрать</button>";

if ($row_number>0) {
  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>номер сектора</td><td id='rs_td'>тип антенны</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>tm</td><td id='rs_td'>te</td><td id='rs_td'>тип каб.</td><td id='rs_td'>длина каб.</td><td id='rs_td'>примечание</td></tr>";
  
  $pr_num=0;
  for ($i=0; $i<$row_number; $i++) {
    $row = mysql_fetch_array($query);
  
    // номер сектора
    $value=PrvFill("num_$i",$row['num']);
    if ($value==0) {$value=$pr_num+1;}
    echo "<tr><td id='rs_td'>";

    echo "<input type='text' value='".$row['Id']."' name='Id_$i' hidden>";  // id
    
    echo "<select size='1' id='select_field_small' name='num_$i'>";
    for ($j=1; $j<$row_number+5; $j++) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
      $pr_num=$value;
    }
    echo "</select></td>";
  
    // тип антенны
    $value=PrvFill("antenna_type_id_$i",$row['antenna_type_id']);
    $sql = "SELECT antenna_type FROM antenna_types WHERE id=".NumOrNull($value); 
    $query3 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query3); 
    $value = $row2[0];
    echo "<td id='rs_td'><select size='1' id='select_field_medium' name='antenna_type_id_$i' required>";
    mysql_data_seek($query_at,0);
    echo "<option></option>";
    for ($j=0; $j<mysql_num_rows($query_at); $j++) {
      $row2 = mysql_fetch_array($query_at); 
      if ($value == $row2[0]) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='".$row2[1]."'>".$row2[0]."</option>";
    }
    echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types&#039;,&#039;repeater_sectors_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // высота (размещение)
    $value=PrvFill("height_$i",$row['height']);
    echo "<td id='rs_td'><input type='text' value='$value' name='height_$i' size='10'></td>";
  
    // азимут
    $value=PrvFill("azimuth_$i",$row['azimuth']);
    echo "<td id='rs_td'><input type='text' value='$value' name='azimuth_$i' size='1' pattern='[0-9]*'></td>";
  
    // TM
    $value=PrvFill("tm_slope_$i",$row['tm_slope']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='tm_slope_$i'>";
    for ($j=0; $j>-16; $j--) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
    }
    echo "</select></td>";
  
    // TE
    $value=PrvFill("te_slope_$i",$row['te_slope']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='te_slope_$i'>";
    for ($j=0; $j>-16; $j--) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
    }
    echo "</select></td>";
  
    // тип кабеля
    $value=PrvFill("cable_type_$i",$row['cable_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='cable_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    echo "</select></td>";
  
    // длина кабеля
    $value=PrvFill("cable_length_$i",$row['cable_length']);
    echo "<td id='rs_td'><input type='text' value='$value' name='cable_length_$i' size='3' pattern='[0-9]*'></td>"; 
  
    // примечание
    $value=PrvFill("notes_$i",$row['notes']);
    echo "<td id='rs_td'>";
    echo "<textarea id='select_field' name='notes_$i'>$value</textarea>";
    echo "</td></tr>";
  }
  echo "</table>";
}
echo "<br><p><button type='submit'>сохранить</button></p>";
echo "</form>";
?>