<?php
// входные параметры
$id = $_GET['id'];

// основной запрос
$sql="SELECT * FROM bts WHERE id='$id'"; 
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

// формируем элементы
$info[] = $info1 = array (
   'field' => '<b>2G</b>'
  ,'el_type' => 'break'
);
$info[] = $info1 = array (
 'field' => 'привязывается по ВОЛС'
,'value' => PrvFill('focl_2g',$row['focl_2g'])
,'el_type' => 'checkbox'
,'name' => 'focl_2g'
);
$info[] = $info1 = array (
 'field' => 'привязывается по Аренде РУП "Белтелеком"'
,'value' => PrvFill('rent_2g',$row['rent_2g'])
,'el_type' => 'checkbox'
,'name' => 'rent_2g'
);
$info[] = $info1 = array (
   'field' => '<b>3G</b>'
  ,'el_type' => 'break'
);
$info[] = $info1 = array (
 'field' => 'привязывается по ВОЛС'
,'value' => PrvFill('focl_3g',$row['focl_3g'])
,'el_type' => 'checkbox'
,'name' => 'focl_3g'
);
$info[] = $info1 = array (
 'field' => 'привязывается по Аренде РУП "Белтелеком"'
,'value' => PrvFill('rent_3g',$row['rent_3g'])
,'el_type' => 'checkbox'
,'name' => 'rent_3g'
);
$info[] = $info1 = array (
   'el_type' => 'break'
);


// вывод элементов интерфейса
echo "<form action='transport_edit.php?id=$id' method='post' id='transport_edit_form'>";
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";

echo "<div id='right_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "</div>";

echo "<div style='clear:left;'>";

echo "<b>РРЛ</b><br><br>";

$sql = "SELECT";
$sql.= " *";
$sql.= " FROM rrl";
$sql.= " WHERE bts_id_point1=$id OR bts_id_point2=$id";

$query = mysql_query($sql) or die(mysql_error()); 
$row_count = PrvFill('row_count',mysql_num_rows($query));

echo "добавить новую РРЛ на БС:&nbsp;&nbsp;&nbsp;";
echo "<input type='text' size='4' name='bts_number' pattern='[0-9]*'>&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=9&id=$id&add&#039;,&#039;transport_edit_form&#039;);'>добавить</button>";

if ($row_count>0) {

  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>п.1</td><td id='rs_td'>выс. 1</td><td id='rs_td'>диаметр 1</td><td id='rs_td'>азимут 1</td><td id='rs_td'>п. 2</td><td id='rs_td'>адрес п. 2</td><td id='rs_td'>выс. 2</td><td id='rs_td'>диаметр 2</td><td id='rs_td'>азимут 2</td><td id='rs_td'>тип РРС</td><td id='rs_td'>поток</td><td id='rs_td'>поток вкл.</td><td id='rs_td'>резерв</td><td id='rs_td'>оборудование</td><td id='rs_td'></td></tr>";
  for ($i=0; $i<$row_count; $i++) {
    
    $row = mysql_fetch_array($query);
    
    $bts_id = PrvFill('bts_id_point1',$row['bts_id_point1']);
    
    if ($id == $bts_id) {$p1 = 1; $p2 = 2;} else {$p1 = 2; $p2 = 1;}
    
    // номер БС 1 и ID
    $value=PrvFill("Id_$i",$row['Id']);
    echo "<tr><td id='rs_td'>";
    echo "<input type='text' value='$value' name='Id_$i' hidden>";
    $bts_id = PrvFill("bts_id_point".$p1."_$i",$row['bts_id_point'.$p1]);
    if (empty($bts_id)) $bts_id = $id;
    echo "<input type='text' value='$bts_id' name='bts_id_point".$p1."_$i' hidden>";
    $sql = "SELECT bts_number FROM bts WHERE id=".StrOrNull($bts_id);
    $query2 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query2); 
    echo "БС".$row2[0]."</td>";
    
    // высота 1
    $value=PrvFill("height_point".$p1."_$i",$row['height_point'.$p1]);
    echo "<td id='rs_td'><input type='text' value='$value' name='height_point".$p1."_$i' size='2' pattern='[0-9./]*' required></td>";
    
    // диаметр 1
    $value=PrvFill("diam_point".$p1."_$i",$row['diam_point'.$p1]);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='diam_point".$p1."_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='0.3') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3'>0.3</option>";
    if ($value=='0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6'>0.6</option>";
    if ($value=='1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2'>1.2</option>";
    if ($value=='1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.8'>1.8</option>";
    if ($value=='0.3/0.3') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3/0.3'>0.3/0.3</option>";
    if ($value=='0.3/0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3/0.6'>0.3/0.6</option>";
    if ($value=='0.6/0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6/0.6'>0.6/0.6</option>";
    if ($value=='0.6/1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6/1.2'>0.6/1.2</option>"; 
    if ($value=='1.2/1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2/1.2'>1.2/1.2</option>";
    if ($value=='1.2/1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2/1.8'>1.2/1.8</option>";
    if ($value=='1.8/1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.8/1.8'>1.8/1.8</option>";
    echo "</select></td>";
    
    // азимут 1
    $value=PrvFill("azimuth_point".$p1."_$i",$row['azimuth_point'.$p1]);
    echo "<td id='rs_td'><input type='text' value='$value' name='azimuth_point".$p1."_$i' size='2' pattern='[0-9./]*' required></td>";
    
    // номер БС 2
    $bts_id = PrvFill("bts_id_point".$p2."_$i",$row['bts_id_point'.$p2]);
    if (empty($bts_id)) $bts_id = $_SESSION['point_2_id'];
    echo "<td id='rs_td'>";
    echo "<input type='text' value='$bts_id' name='bts_id_point".$p2."_$i' hidden>";
    $sql = "SELECT bts_number FROM bts WHERE id=".StrOrNull($bts_id);
    $query2 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query2); 
    echo "БС".$row2[0]."</td>";
        
    // адрес п.2
    echo "<td id='rs_td'>".GetSmallAddress($row2[0])."</td>";
   
    // высота 2
    $value=PrvFill("height_point".$p2."_$i",$row['height_point'.$p2]);
    echo "<td id='rs_td'><input type='text' value='$value' name='height_point".$p2."_$i' size='2' pattern='[0-9./]*' required></td>";
    
    // диаметр 2
    $value=PrvFill("diam_point".$p2."_$i",$row['diam_point'.$p2]);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='diam_point".$p2."_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='0.3') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3'>0.3</option>";
    if ($value=='0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6'>0.6</option>";
    if ($value=='1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2'>1.2</option>";
    if ($value=='1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.8'>1.8</option>";
    if ($value=='0.3/0.3') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3/0.3'>0.3/0.3</option>";
    if ($value=='0.3/0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.3/0.6'>0.3/0.6</option>";
    if ($value=='0.6/0.6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6/0.6'>0.6/0.6</option>";
    if ($value=='0.6/1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='0.6/1.2'>0.6/1.2</option>";
    if ($value=='1.2/1.2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2/1.2'>1.2/1.2</option>";
    if ($value=='1.2/1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.2/1.8'>1.2/1.8</option>";
    if ($value=='1.8/1.8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1.8/1.8'>1.8/1.8</option>";
    echo "</select></td>";
    
    // азимут 2
    $value=PrvFill("azimuth_point".$p2."_$i",$row['azimuth_point'.$p2]);
    echo "<td id='rs_td'><input type='text' value='$value' name='azimuth_point".$p2."_$i' size='2' pattern='[0-9./]*' required></td>";
   
    // тип РРС
    $value=PrvFill("fr_range_$i",$row['fr_range']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='fr_range_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='7 GHz') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='7 GHz'>7 GHz</option>";
    if ($value=='18 GHz') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='18 GHz'>18 GHz</option>";
    if ($value=='23 GHz') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='23 GHz'>23 GHz</option>";
    if ($value=='38 GHz') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='38 GHz'>38 GHz</option>";
    echo "</select></td>";
    
    // поток
    $value=PrvFill("stream_total_$i",$row['stream_total']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='stream_total_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='4E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='4E1'>4E1</option>";
    if ($value=='8E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='8E1'>8E1</option>";
    if ($value=='16E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='16E1'>16E1</option>";
    if ($value=='40E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='40E1'>40E1</option>";
    if ($value=='48E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='48E1'>48E1</option>";
    if ($value=='34 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='34 Мб/c'>34 Мб/c</option>";
    if ($value=='200 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='200 Мб/c'>200 Мб/c</option>";
    if ($value=='400 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='400 Мб/c'>400 Мб/c</option>";
    echo "</select></td>";
    
    // поток вкл.
    $value=PrvFill("stream_work_$i",$row['stream_work']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='stream_work_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='4E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='4E1'>4E1</option>";
    if ($value=='8E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='8E1'>8E1</option>";
    if ($value=='16E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='16E1'>16E1</option>";
    if ($value=='40E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='40E1'>40E1</option>";
    if ($value=='48E1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='48E1'>48E1</option>";
    if ($value=='34 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='34 Мб/c'>34 Мб/c</option>";
    if ($value=='200 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='200 Мб/c'>200 Мб/c</option>";
    if ($value=='400 Мб/c') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='400 Мб/c'>400 Мб/c</option>";
    echo "</select></td>";
    
    // резерв
    $value=PrvFill("reserve_$i",$row['reserve']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='reserve_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='1+0') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1+0'>1+0</option>";
    if ($value=='1+1') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1+1'>1+1</option>";
    echo "</select></td>";
    
    // оборудование
    $value=PrvFill("equipment_$i",$row['equipment']);
    echo "<td id='rs_td'><select size='1' id='select_field_medium' name='equipment_$i' required>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='Pasolink v3') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink v3'>Pasolink v3</option>";
    if ($value=='Pasolink v4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink v4'>Pasolink v4</option>";
    if ($value=='Pasolink v4 + LAN') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink v4 + LAN'>Pasolink v4 + LAN</option>";
    if ($value=='Pasolink Mx') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink Mx'>Pasolink Mx</option>";
    if ($value=='Pasolink NEO') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink NEO'>Pasolink NEO</option>";
    if ($value=='Pasolink NEO HP') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink NEO HP'>Pasolink NEO HP</option>";
    if ($value=='Pasolink 200') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink 200'>Pasolink 200</option>";
    if ($value=='Pasolink NEO/Compact') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Pasolink NEO/Compact'>Pasolink NEO/Compact</option>";
    if ($value=='Huawei RTN905') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='Huawei RTN905'>Huawei RTN905</option>";
    echo "</select></td>";
   
    echo "<td id='rs_td'><a href='#' onclick='confirmDelete(&#039;redirect.php?f=9&rn=$i&del&#039;,&#039;transport_edit_form&#039;);' title='удалить'><img src='pics/delete_pic.png' width='16' height='16'></a></td>";
    echo "</tr>";
  }
  echo "</table>";
}

echo "</div>";


echo "<br><p><button type='submit'>сохранить</button></p>";
echo "</form>";
?>