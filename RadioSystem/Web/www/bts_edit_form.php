<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql = "SELECT"; 
$sql.=" bts_number";
$sql.=",site_type";
$sql.=",settlement_id";
$sql.=",street_type";
$sql.=",street_name";
$sql.=",house_type";
$sql.=",house_number";
$sql.=",place_owner";
$sql.=",cooperative";
$sql.=",construction_2g_type_id";
$sql.=",construction_3g_type_id";
$sql.=",construction_4g_type_id";
$sql.=",container_type";
$sql.=",model_type_2g";
$sql.=",model_type_3g";
$sql.=",model_type_4g";
$sql.=",power_type_id";
$sql.=",power_cupboard_count";
$sql.=",battery_capacity";
$sql.=",longitudel_s";
$sql.=",longitudel_d";
$sql.=",notes";
$sql.=" FROM bts"; 
$sql.=" WHERE bts.id='$id'"; 
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

$sql = "SELECT";
$sql.=" area_id";
$sql.=",area";
$sql.=",region_id";
$sql.=",region";
$sql.=",CONCAT(type,' ',settlement) as settlement";
$sql.=" FROM settlements";
$sql.=" LEFT JOIN areas";
$sql.=" ON settlements.area_id=areas.id";
$sql.=" LEFT JOIN regions";
$sql.=" ON areas.region_id=regions.id";
$sql.=" WHERE settlements.id=".StrOrNull(PrvFill('settlement_id',$row['settlement_id']));
$query = mysql_query($sql) or die(mysql_error());
$setlrow = mysql_fetch_array($query);

// формируем элементы
$info[] = $info1 = array (
   'field' => 'Номер БС'
  ,'value' => PrvFill('bts_number',$row['bts_number'])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'bts_number'
  ,'disabled' => true
);
$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'БС', 'display'=>'БС')
 ,array ('value'=>'мкБС', 'display'=>'мкБС')
 ,array ('value'=>'РРУ', 'display'=>'РРУ')
);
$info[] = $info1 = array (
   'field' => 'Тип БС'
  ,'value' => PrvFill('site_type',$row['site_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'site_type'
  ,'list' => $list
  ,'required' => true
);
$info[] = $info1 = array (
  'el_type' => 'break'
);

$info[] = $info1 = array (
   'value' => PrvFill('settlement_id',$row['settlement_id'])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'settlement_id'
  ,'hidden' => true
  ,'required' => true
);
$info[] = $info1 = array (
   'value' => $setlrow['area_id']
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'area_id'
  ,'hidden' => true
);
$info[] = $info1 = array (
   'value' => $setlrow['region_id']
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'region_id'
  ,'hidden' => true
);
$info[] = $info1 = array (
   'field' => 'Населённый пункт'
  ,'value' => $setlrow['settlement']
  ,'el_type' => 'text'
  ,'id' => 'text_field_medium'
  ,'name' => 'settlement'
  ,'disabled' => true
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=region&#039;,&#039;bts_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Район'
  ,'value' => $setlrow['area']
  ,'el_type' => 'text'
  ,'id' => 'text_field_medium'
  ,'name' => 'area'
  ,'disabled' => true
);
$info[] = $info1 = array (
   'field' => 'Область'
  ,'value' => $setlrow['region']
  ,'el_type' => 'text'
  ,'id' => 'text_field_medium'
  ,'name' => 'region'
  ,'disabled' => true
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'ул.', 'display'=>'ул.')
  ,array ('value'=>'пер.', 'display'=>'пер.')
  ,array ('value'=>'пр-т', 'display'=>'пр-т')
  ,array ('value'=>'тракт', 'display'=>'тракт')
  ,array ('value'=>'бул.', 'display'=>'бул.')
  ,array ('value'=>'пл.', 'display'=>'пл.')
  ,array ('value'=>'шоссе', 'display'=>'шоссе')
  ,array ('value'=>'р-н', 'display'=>'р-н')
  ,array ('value'=>'парк', 'display'=>'парк')
);
$info[] = $info1 = array (
   'field' => 'Улица'
  ,'value' => PrvFill('street_type',$row['street_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'street_type'
  ,'list' => $list
  ,'start_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('street_name',$row['street_name'])
  ,'el_type' => 'text'
  ,'id' => 'text_field_medium'
  ,'name' => 'street_name'
  ,'end_line' => true
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'д.', 'display'=>'д.')
  ,array ('value'=>'стр.', 'display'=>'стр.')
);
$info[] = $info1 = array (
   'field' => 'Номер здания'
  ,'value' => PrvFill('house_type',$row['house_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'house_type'
  ,'list' => $list
  ,'start_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('house_number',$row['house_number'])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'house_number'
  ,'end_line' => true
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$info[] = $info1 = array (
   'field' => 'Расположение'
  ,'value' => PrvFill('place_owner',$row['place_owner'])
  ,'el_type' => 'text'
  ,'id' => 'text_field_large'
  ,'name' => 'place_owner'
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'совместная с ИП Velcom', 'display'=>'совместная с ИП Velcom')
  ,array ('value'=>'совместная с ЗАО БеСТ', 'display'=>'совместная с ЗАО БеСТ')
  ,array ('value'=>'совместная с СООО МТС', 'display'=>'совместная с СООО МТС')
);
$info[] = $info1 = array (
   'field' => 'Совместный объект'
  ,'value' => PrvFill('cooperative',$row['cooperative'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'cooperative'
  ,'list' => $list
);
$info[] = $info1 = array (
   'field' => '<b>2G</b>'
  ,'el_type' => 'break'
);
$sql = "SELECT construction_type,Id FROM construction_2g_types ORDER BY construction_type";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
}  
$info[] = $info1 = array (
   'field' => 'Тип металлоконструкции'
  ,'value' => PrvFill('construction_2g_type_id',$row['construction_2g_type_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'construction_2g_type_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=construction_2g_types&#039;,&#039;bts_edit_form&#039;);"
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'контейнер', 'display'=>'контейнер')
  ,array ('value'=>'сборный контейнер', 'display'=>'сборный контейнер')
);
$info[] = $info1 = array (
   'field' => 'Контейнер'
  ,'value' => PrvFill('container_type',$row['container_type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'container_type'
  ,'list' => $list
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'BS - 240', 'display'=>'BS - 240')
  ,array ('value'=>'BS - 240 II', 'display'=>'BS - 240 II')
  ,array ('value'=>'BS - 240 II + BS - 82 II', 'display'=>'BS - 240 II + BS - 82 II')
  ,array ('value'=>'BS - 82', 'display'=>'BS - 82')
  ,array ('value'=>'BS - 82 II', 'display'=>'BS - 82 II')
  ,array ('value'=>'BS240 XL', 'display'=>'BS240 XL')
  ,array ('value'=>'BTS - 3900', 'display'=>'BTS - 3900')
  ,array ('value'=>'BTS - 3900 + DBS3900', 'display'=>'BTS - 3900 + DBS3900')
  ,array ('value'=>'DBS - 3900', 'display'=>'DBS - 3900')
  ,array ('value'=>'РРУ', 'display'=>'РРУ')
);
$info[] = $info1 = array (
   'field' => 'Модель БС'
  ,'value' => PrvFill('model_type_2g',$row['model_type_2g'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'model_type_2g'
  ,'list' => $list
);

// 3G
$info[] = $info1 = array (
   'field' => '<b>3G</b>'
  ,'el_type' => 'break'
);
$sql = "SELECT construction_type,Id FROM construction_3g_types ORDER BY construction_type";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
}  
$info[] = $info1 = array (
   'field' => 'Тип металлоконструкции'
  ,'value' => PrvFill('construction_3g_type_id',$row['construction_3g_type_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'construction_3g_type_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=construction_3g_types&#039;,&#039;bts_edit_form&#039;);"
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'BTS - 3900C', 'display'=>'BTS - 3900C')
  ,array ('value'=>'BTS - 3902E', 'display'=>'BTS - 3902E')
  ,array ('value'=>'DBS - 3900', 'display'=>'DBS - 3900')
  ,array ('value'=>'Flexi WCDMA BTS', 'display'=>'Flexi WCDMA BTS')
);
$info[] = $info1 = array (
   'field' => 'Модель БС'
  ,'value' => PrvFill('model_type_3g',$row['model_type_3g'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'model_type_3g'
  ,'list' => $list
);

// 4G
$info[] = $info1 = array (
   'field' => '<b>4G</b>'
  ,'el_type' => 'break'
);
$sql = "SELECT construction_type,Id FROM construction_4g_types ORDER BY construction_type";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
}  
$info[] = $info1 = array (
   'field' => 'Тип металлоконструкции'
  ,'value' => PrvFill('construction_4g_type_id',$row['construction_4g_type_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'construction_4g_type_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=construction_4g_types&#039;,&#039;bts_edit_form&#039;);"
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'BTS - 3900C', 'display'=>'BTS - 3900C')
  ,array ('value'=>'BTS - 3902E', 'display'=>'BTS - 3902E')
  ,array ('value'=>'DBS - 3900', 'display'=>'DBS - 3900')
  ,array ('value'=>'Flexi WCDMA BTS', 'display'=>'Flexi WCDMA BTS')
);
$info[] = $info1 = array (
   'field' => 'Модель БС'
  ,'value' => PrvFill('model_type_4g',$row['model_type_4g'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'model_type_4g'
  ,'list' => $list
);

$info[] = $info1 = array (
  'el_type' => 'break'
);
$sql = "SELECT power_type,Id FROM power_types ORDER BY power_type";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
}  
$info[] = $info1 = array (
   'field' => 'Тип питания'
  ,'value' => PrvFill('power_type_id',$row['power_type_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'power_type_id'
  ,'list' => $list
  ,'required' => true
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=power_types&#039;,&#039;bts_edit_form&#039;);"  
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'1', 'display'=>'1')
  ,array ('value'=>'2', 'display'=>'2')
  ,array ('value'=>'3', 'display'=>'3')
  ,array ('value'=>'4', 'display'=>'4')
);
$info[] = $info1 = array (
   'field' => 'Количество шкафов'
  ,'value' => PrvFill('power_cupboard_count',$row['power_cupboard_count'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'power_cupboard_count'
  ,'list' => $list
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'160', 'display'=>'160')
  ,array ('value'=>'165', 'display'=>'165')
  ,array ('value'=>'180', 'display'=>'180')
  ,array ('value'=>'250', 'display'=>'250')
  ,array ('value'=>'260', 'display'=>'260')
  ,array ('value'=>'300', 'display'=>'300')
  ,array ('value'=>'92', 'display'=>'92')
);
$info[] = $info1 = array (
   'field' => 'Аккумуляторы'
  ,'value' => PrvFill('battery_capacity',$row['battery_capacity'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'battery_capacity'
  ,'list' => $list
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$longitudel_s = explode(' ',$row['longitudel_s']);
$info[] = $info1 = array (
   'field' => 'Географическая широта'
  ,'value' => PrvFill('s_grad',$longitudel_s[0])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 's_grad'
  ,'required' => true
  ,'pattern' => '[0-9]{2,}'
  ,'start_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('s_min',$longitudel_s[1])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 's_min'
  ,'required' => true
  ,'pattern' => '[0-9]{2,}'
  ,'start_line' => true
  ,'end_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('s_sec',$longitudel_s[2])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 's_sec'
  ,'required' => true
  ,'pattern' => '[0-9\.]{2,}'
  ,'end_line' => true
);
$longitudel_d = explode(' ',$row['longitudel_d']);
$info[] = $info1 = array (
   'field' => 'Географическая долгота'
  ,'value' => PrvFill('d_grad',$longitudel_d[0])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'd_grad'
  ,'required' => true
  ,'pattern' => '[0-9]{2,}'
  ,'start_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('d_min',$longitudel_d[1])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'd_min'
  ,'required' => true
  ,'pattern' => '[0-9]{2,}'
  ,'start_line' => true
  ,'end_line' => true
);
$info[] = $info1 = array (
   'value' => PrvFill('d_sec',$longitudel_d[2])
  ,'el_type' => 'text'
  ,'id' => 'select_field_small'
  ,'name' => 'd_sec'
  ,'required' => true
  ,'pattern' => '[0-9\.]{2,}'
  ,'end_line' => true
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$info[] = $info1 = array (
 'field' => 'Примечания'
,'value' => PrvFill('notes',$row['notes'])
,'el_type' => 'textarea'
,'id' => 'note_edit'
,'name' => 'notes'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='bts_edit.php?id=$id' method='post' id='bts_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>сохранить</button></p>";
echo "</form>";
echo "</div>";
?>