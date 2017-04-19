<?php
// входные параметры
$id = $_GET['id'];

// основной запрос
$sql = "SELECT * FROM sectors WHERE tech_type in ('gsm','dcs','2g') AND bts_id='$id'"; 
$query = mysql_query($sql) or die(mysql_error());
$exist_number_2g = mysql_num_rows($query);

$sql = "SELECT * FROM sectors WHERE tech_type in ('umts 2100') AND bts_id='$id'"; 
$query2 = mysql_query($sql) or die(mysql_error());
$exist_number_3g = mysql_num_rows($query2);

$sql = "SELECT * FROM sectors WHERE tech_type in ('umts 900') AND bts_id='$id'"; 
$query4 = mysql_query($sql) or die(mysql_error());
$exist_number_3g9 = mysql_num_rows($query4);

$sql = "SELECT * FROM sectors WHERE tech_type in ('lte 1800') AND bts_id='$id'"; 
$query5 = mysql_query($sql) or die(mysql_error());
$exist_number_4g = mysql_num_rows($query5);

$sql="SELECT antenna_type, Id FROM antenna_types WHERE tech_type in ('2g','gsm','3g') GROUP BY antenna_type"; 
$query_at=mysql_query($sql) or die(mysql_error());
$sql="SELECT antenna_type, Id FROM antenna_types WHERE tech_type in ('3g') GROUP BY antenna_type"; 
$query_at_3g=mysql_query($sql) or die(mysql_error());
$sql="SELECT antenna_type, Id FROM antenna_types WHERE tech_type in ('4g') GROUP BY antenna_type"; 
$query_at_4g=mysql_query($sql) or die(mysql_error());

// формируем элементы
$row_number_2g = PrvFill('row_number_2g',$exist_number_2g);
$info[] = $info1 = array (
   'value' => $row_number_2g
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'row_number_2g'
  ,'start_line' => true
  ,'end_line' => true
  ,'pattern' => '[0-9]*'
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$row_number_3g = PrvFill('row_number_3g',$exist_number_3g);
$info[] = $info1 = array (
   'value' => $row_number_3g
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'row_number_3g'
  ,'start_line' => true
  ,'end_line' => true
  ,'pattern' => '[0-9]*'
);
$row_number_3g9 = PrvFill('row_number_3g9',$exist_number_3g9);
$info[] = $info1 = array (
   'value' => $row_number_3g9
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'row_number_3g9'
  ,'start_line' => true
  ,'end_line' => true
  ,'pattern' => '[0-9]*'
);
$row_number_4g = PrvFill('row_number_4g',$exist_number_4g);
$info[] = $info1 = array (
   'value' => $row_number_4g
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'row_number_4g'
  ,'start_line' => true
  ,'end_line' => true
  ,'pattern' => '[0-9]*'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<form action='sectors_edit.php?id=$id' method='post' id='sectors_edit_form'>";

echo "введите количество строк для секторов 2G:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
FieldEdit($info[0]);
echo "&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=8&#039;,&#039;sectors_edit_form&#039;);'>выбрать</button>";

if ($row_number_2g>0) {
  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>номер сектора</td><td id='rs_td'>стандарт</td><td id='rs_td'>тип антенны</td><td id='rs_td'>кол-во</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>tm</td><td id='rs_td'>te</td><td id='rs_td'>тип каб.</td><td id='rs_td'>длина каб.</td><td id='rs_td'>мшу</td></tr>";
  
  $pr_num=0;
  for ($i=0; $i<$row_number_2g; $i++) {
    $row = mysql_fetch_array($query);
  
    // номер сектора
    $value=PrvFill("num_$i",$row['num']);
    if ($value==0) {$value=$pr_num+1;}
    echo "<tr><td id='rs_td'>";

    echo "<input type='text' value='".$row['Id']."' name='Id_$i' hidden>";  // id
    
    echo "<select size='1' id='select_field_small' name='num_$i'>";
    for ($j=1; $j<$row_number_2g+5; $j++) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
      $pr_num=$value;
    }
    echo "</select></td>";
  
    // стандарт
    $value=PrvFill("tech_type_$i",$row['tech_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='tech_type_$i'>";
    if ($value=='gsm') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='gsm'>gsm</option>";
    if ($value=='dcs') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='dcs'>dcs</option>";
    if ($value=='2g') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='2g'>2g</option>";
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
    echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types_2g&#039;,&#039;sectors_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // кол-во антенн
    $value=PrvFill("antenna_count_$i",$row['antenna_count']);
    if ($value=='') {$value=1;}
    echo "<td id='rs_td'><input type='number' value='$value' name='antenna_count_$i' id='select_field_small' pattern='[0-9]*' required></td>";
  
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
    if ($value=='1/2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1/2'>1/2</option>";
    if ($value=='3/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='3/8'>3/8</option>";
    if ($value=='5/4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='5/4'>5/4</option>";
    if ($value=='7/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='7/8'>7/8</option>";
    if ($value=='13/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='13/8'>13/8</option>";
    if ($value=='LCF-11-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-11-50J'>LCF-11-50J</option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    if ($value=='LCF12') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF12'>LCF12</option>";
    if ($value=='LDF4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4'>LDF4</option>";
    if ($value=='LDF4RN50A') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4RN50A'>LDF4RN50A</option>";
    if ($value=='LDF6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF6'>LDF6</option>";
    echo "</select></td>";
  
    // длинна кабеля
    $value=PrvFill("cable_length_$i",$row['cable_length']);
    echo "<td id='rs_td'><input type='text' value='$value' name='cable_length_$i' size='3' pattern='[0-9]*'></td>"; 
  
    // тип мшу
    $value=PrvFill("msu_type_$i",$row['msu_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='msu_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='TMA900') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='TMA900'>TMA900</option>";
    echo "</select></td></tr>";
  }
  echo "</table>";
}
FieldEdit($info[1]);
FieldEdit($info[1]);

echo "введите количество строк для секторов 3G UMTS 2100:&nbsp;&nbsp;&nbsp;";
FieldEdit($info[2]);
echo "&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=8&#039;,&#039;sectors_edit_form&#039;);'>выбрать</button>";

if ($row_number_3g>0) {
  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>номер сектора</td><td id='rs_td'>стандарт</td><td id='rs_td'>тип антенны</td><td id='rs_td'>кол-во</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>tm</td><td id='rs_td'>te</td><td id='rs_td'>тип каб.</td><td id='rs_td'>длина каб.</td><td id='rs_td'>ret</td><td id='rs_td'>мшу</td></tr>";
  $pr_num=0;
  for ($i=0+$row_number_2g; $i<$row_number_3g+$row_number_2g; $i++) {
    $row = mysql_fetch_array($query2);
    
    // номер сектора
    $value=PrvFill("num_$i",$row['num']); 
    if ($value==0) {$value=$pr_num+1;}  
    echo "<tr><td id='rs_td'>";
    
    echo "<input type='text' value='".$row['Id']."' name='Id_$i' hidden>"; // id 

    echo "<select size='1' id='select_field_small' name='num_$i'>";
    
    for ($j=1; $j<$row_number_3g+1; $j++) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
      $pr_num=$value;
    }
    echo "</select></td>";
    
    // стандарт
    $value=PrvFill("tech_type_$i",$row['tech_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='tech_type_$i'>";
    if ($value=='3g') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='umts 2100'>umts 2100</option>";
    echo "</select></td>";
  
    // тип антенны
    $value = PrvFill("antenna_type_id_$i",$row['antenna_type_id']);
    $sql = "SELECT antenna_type FROM antenna_types WHERE id=".NumOrNull($value); 
    $query3 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query3); 
    $value = $row2[0]; 
    echo "<td id='rs_td'><select size='1' id='select_field_medium' name='antenna_type_id_$i' required>";
    echo "<option></option>";
    mysql_data_seek($query_at_3g,0);
    for ($j=0; $j<mysql_num_rows($query_at_3g); $j++) {
      $row2=mysql_fetch_array($query_at_3g); 
      if ($value==$row2[0]) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='".$row2[1]."'>".$row2[0]."</option>";
    }
    echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types_3g&#039;,&#039;sectors_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // кол-во антенн
    $value=PrvFill("antenna_count_$i",$row['antenna_count']);
    if ($value=='') {$value=1;}
    echo "<td id='rs_td'><input type='number' value='$value' name='antenna_count_$i' id='select_field_small' pattern='[0-9]*' required></td>";
  
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
    if ($value=='1/2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1/2'>1/2</option>";
    if ($value=='3/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='3/8'>3/8</option>";
    if ($value=='5/4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='5/4'>5/4</option>";
    if ($value=='7/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='7/8'>7/8</option>";
    if ($value=='13/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='13/8'>13/8</option>";
    if ($value=='LCF-11-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-11-50J'>LCF-11-50J</option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    if ($value=='LCF12') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF12'>LCF12</option>";
    if ($value=='LDF4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4'>LDF4</option>";
    if ($value=='LDF4RN50A') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4RN50A'>LDF4RN50A</option>";
    if ($value=='LDF6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF6'>LDF6</option>";
    echo "</select></td>";
    
    // длинна кабеля
    $value=PrvFill("cable_length_$i",$row['cable_length']);
    echo "<td id='rs_td'><input type='text' value='$value' name='cable_length_$i' size='3' pattern='[0-9]*'></td>"; 
  
    // ret
    $value=PrvFill("ret_type_$i",$row['ret_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='ret_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='да') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='да'>да</option>";
    echo "</select></td>";
  
    // тип мшу
    $value=PrvFill("msu_type_$i",$row['msu_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='msu_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='TMA2100') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='TMA2100'>TMA2100</option>";
    echo "</select></td></tr>";
  }
  echo "</table>";
}
FieldEdit($info[1]);
FieldEdit($info[1]);

echo "введите количество строк для секторов 3G UMTS 900:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
FieldEdit($info[3]);
echo "&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=8&#039;,&#039;sectors_edit_form&#039;);'>выбрать</button>";

if ($row_number_3g9>0) {
  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>номер сектора</td><td id='rs_td'>стандарт</td><td id='rs_td'>тип антенны</td><td id='rs_td'>кол-во</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>tm</td><td id='rs_td'>te</td><td id='rs_td'>тип каб.</td><td id='rs_td'>длина каб.</td><td id='rs_td'>ret</td><td id='rs_td'>мшу</td></tr>";
  $pr_num=0;
  for ($i=0+$row_number_2g+$row_number_3g; $i<$row_number_3g9+$row_number_3g+$row_number_2g; $i++) {
    $row = mysql_fetch_array($query4);
    
    // номер сектора
    $value=PrvFill("num_$i",$row['num']); 
    if ($value==0) {$value=$pr_num+1;}  
    echo "<tr><td id='rs_td'>";
    
    echo "<input type='text' value='".$row['Id']."' name='Id_$i' hidden>"; // id 

    echo "<select size='1' id='select_field_small' name='num_$i'>";
    
    for ($j=1; $j<$row_number_3g9+1; $j++) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
      $pr_num=$value;
    }
    echo "</select></td>";
    
    // стандарт
    $value=PrvFill("tech_type_$i",$row['tech_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='tech_type_$i'>";
    if ($value=='3g') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='umts 900'>umts 900</option>";
    echo "</select></td>";
  
    // тип антенны
    $value = PrvFill("antenna_type_id_$i",$row['antenna_type_id']);
    $sql = "SELECT antenna_type FROM antenna_types WHERE id=".NumOrNull($value); 
    $query3 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query3); 
    $value = $row2[0]; 
    echo "<td id='rs_td'><select size='1' id='select_field_medium' name='antenna_type_id_$i' required>";
    echo "<option></option>";
    mysql_data_seek($query_at_3g,0);
    for ($j=0; $j<mysql_num_rows($query_at_3g); $j++) {
      $row2=mysql_fetch_array($query_at_3g); 
      if ($value==$row2[0]) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='".$row2[1]."'>".$row2[0]."</option>";
    }
    echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types_3g&#039;,&#039;sectors_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // кол-во антенн
    $value=PrvFill("antenna_count_$i",$row['antenna_count']);
    if ($value=='') {$value=1;}
    echo "<td id='rs_td'><input type='number' value='$value' name='antenna_count_$i' id='select_field_small' pattern='[0-9]*' required></td>";
  
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
    if ($value=='1/2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1/2'>1/2</option>";
    if ($value=='3/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='3/8'>3/8</option>";
    if ($value=='5/4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='5/4'>5/4</option>";
    if ($value=='7/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='7/8'>7/8</option>";
    if ($value=='13/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='13/8'>13/8</option>";
    if ($value=='LCF-11-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-11-50J'>LCF-11-50J</option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    if ($value=='LCF12') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF12'>LCF12</option>";
    if ($value=='LDF4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4'>LDF4</option>";
    if ($value=='LDF4RN50A') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4RN50A'>LDF4RN50A</option>";
    if ($value=='LDF6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF6'>LDF6</option>";
    echo "</select></td>";
    
    // длинна кабеля
    $value=PrvFill("cable_length_$i",$row['cable_length']);
    echo "<td id='rs_td'><input type='text' value='$value' name='cable_length_$i' size='3' pattern='[0-9]*'></td>"; 
  
    // ret
    $value=PrvFill("ret_type_$i",$row['ret_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='ret_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='да') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='да'>да</option>";
    echo "</select></td>";
  
    // тип мшу
    $value=PrvFill("msu_type_$i",$row['msu_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='msu_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='TMA900') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='TMA900'>TMA900</option>";
    echo "</select></td></tr>";
  }
  echo "</table>";
}
FieldEdit($info[1]);
FieldEdit($info[1]);

echo "введите количество строк для секторов 4G LTE 1800:&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
FieldEdit($info[4]);
echo "&nbsp;&nbsp;&nbsp;<button type='button' onclick='ad_edit(&#039;redirect.php?f=8&#039;,&#039;sectors_edit_form&#039;);'>выбрать</button>";

if ($row_number_4g>0) {
  echo "<table id='result_table'>";
  echo "<tr><td id='rs_td'>номер сектора</td><td id='rs_td'>стандарт</td><td id='rs_td'>тип антенны</td><td id='rs_td'>кол-во</td><td id='rs_td'>высота(размещ.)</td><td id='rs_td'>азимут</td><td id='rs_td'>tm</td><td id='rs_td'>te</td><td id='rs_td'>тип каб.</td><td id='rs_td'>длина каб.</td><td id='rs_td'>ret</td><td id='rs_td'>мшу</td></tr>";
  $pr_num=0;
  for ($i=0+$row_number_2g+$row_number_3g+$row_number_3g9; $i<$row_number_4g+$row_number_3g9+$row_number_3g+$row_number_2g; $i++) {
    $row = mysql_fetch_array($query5);
    
    // номер сектора
    $value=PrvFill("num_$i",$row['num']); 
    if ($value==0) {$value=$pr_num+1;}  
    echo "<tr><td id='rs_td'>";
    
    echo "<input type='text' value='".$row['Id']."' name='Id_$i' hidden>"; // id 

    echo "<select size='1' id='select_field_small' name='num_$i'>";
    
    for ($j=1; $j<$row_number_4g+1; $j++) {
      if ($value==$j) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='$j'>$j</option>";
      $pr_num=$value;
    }
    echo "</select></td>";
    
    // стандарт
    $value=PrvFill("tech_type_$i",$row['tech_type']);
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='tech_type_$i'>";
    if ($value=='4g') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='lte 1800'>lte 1800</option>";
    echo "</select></td>";
  
    // тип антенны
    $value = PrvFill("antenna_type_id_$i",$row['antenna_type_id']);
    $sql = "SELECT antenna_type FROM antenna_types WHERE id=".NumOrNull($value); 
    $query3 = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query3); 
    $value = $row2[0]; 
    echo "<td id='rs_td'><select size='1' id='select_field_medium' name='antenna_type_id_$i' required>";
    echo "<option></option>";
    mysql_data_seek($query_at_4g,0);
    for ($j=0; $j<mysql_num_rows($query_at_4g); $j++) {
      $row2=mysql_fetch_array($query_at_4g); 
      if ($value==$row2[0]) {$selected='selected';} else {$selected='';}
      echo "<option $selected value='".$row2[1]."'>".$row2[0]."</option>";
    }
    echo "</select>&nbsp;<a href='#' title='редактировать список' onclick='ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=antenna_types_4g&#039;,&#039;sectors_edit_form&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
  
    // кол-во антенн
    $value=PrvFill("antenna_count_$i",$row['antenna_count']);
    if ($value=='') {$value=1;}
    echo "<td id='rs_td'><input type='number' value='$value' name='antenna_count_$i' id='select_field_small' pattern='[0-9]*' required></td>";
  
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
    if ($value=='1/2') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='1/2'>1/2</option>";
    if ($value=='3/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='3/8'>3/8</option>";
    if ($value=='5/4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='5/4'>5/4</option>";
    if ($value=='7/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='7/8'>7/8</option>";
    if ($value=='13/8') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='13/8'>13/8</option>";
    if ($value=='LCF-11-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-11-50J'>LCF-11-50J</option>";
    if ($value=='LCF-12-50J') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF-12-50J'>LCF-12-50J</option>";
    if ($value=='LCF12') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LCF12'>LCF12</option>";
    if ($value=='LDF4') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4'>LDF4</option>";
    if ($value=='LDF4RN50A') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF4RN50A'>LDF4RN50A</option>";
    if ($value=='LDF6') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='LDF6'>LDF6</option>";
    echo "</select></td>";
    
    // длинна кабеля
    $value=PrvFill("cable_length_$i",$row['cable_length']);
    echo "<td id='rs_td'><input type='text' value='$value' name='cable_length_$i' size='3' pattern='[0-9]*'></td>"; 
  
    // ret
    $value=PrvFill("ret_type_$i",$row['ret_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='ret_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='да') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='да'>да</option>";
    echo "</select></td>";
  
    // тип мшу
    $value=PrvFill("msu_type_$i",$row['msu_type']); 
    echo "<td id='rs_td'><select size='1' id='select_field_small' name='msu_type_$i'>";
    if ($value=='') {$selected='selected';} else {$selected='';}
    echo "<option $selected value=''></option>";
    if ($value=='TMA1800') {$selected='selected';} else {$selected='';}
    echo "<option $selected value='TMA1800'>TMA1800</option>";
    echo "</select></td></tr>";
  }
  echo "</table>";
}
echo "<br><p><button type='submit'>сохранить</button></p>";
echo "</form>";
?>