<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql="SELECT * FROM bts WHERE id='$id'"; 
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

$sql = "SELECT gsm_config,Id FROM gsm_configs ORDER BY gsm_config";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $gsm_configs[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$sql = "SELECT dcs_config,Id FROM dcs_configs ORDER BY dcs_config";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $dcs_configs[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$sql = "SELECT umts_config,Id FROM umts_configs ORDER BY umts_config";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $umts_configs[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$sql = "SELECT lte_config,Id FROM lte_configs ORDER BY lte_config";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $lte_configs[] = array('value' => $row2[1], 'display' => $row2[0]);
}

// формируем элементы
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'1', 'display'=>'1')
  ,array ('value'=>'2', 'display'=>'2')
  ,array ('value'=>'3', 'display'=>'3')
  ,array ('value'=>'4', 'display'=>'4')
  ,array ('value'=>'5', 'display'=>'5')
  ,array ('value'=>'6', 'display'=>'6')
  ,array ('value'=>'7', 'display'=>'7')
);
$info[] = $info1 = array (
   'field' => 'Количество шкафов 2G'
  ,'value' => PrvFill('cupboard_2g_count',$row['cupboard_2g_count'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'cupboard_2g_count'
  ,'list' => $list
);
$info[] = $info1 = array (
   'field' => '<b>Конфигурация GSM</b>'
  ,'el_type' => 'break'
);
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<count($gsm_configs); $i++) {
    $list[] = array('value' => $gsm_configs[$i]['value'], 'display' => $gsm_configs[$i]['display']);  
}  
$info[] = $info1 = array (
   'field' => 'Планируемая конфигурация'
  ,'value' => PrvFill('plan_gsm_config_id',$row['plan_gsm_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'plan_gsm_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=gsm_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Установленная конфигурация'
  ,'value' => PrvFill('install_gsm_config_id',$row['install_gsm_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'install_gsm_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=gsm_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Рабочая конфигурация'
  ,'value' => PrvFill('work_gsm_config_id',$row['work_gsm_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'work_gsm_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=gsm_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => '<b>Конфигурация DCS</b>'
  ,'el_type' => 'break'
);
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<count($dcs_configs); $i++) {
    $list[] = array('value' => $dcs_configs[$i]['value'], 'display' => $dcs_configs[$i]['display']);  
}  
$info[] = $info1 = array (
   'field' => 'Планируемая конфигурация'
  ,'value' => PrvFill('plan_dcs_config_id',$row['plan_dcs_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'plan_dcs_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=dcs_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Установленная конфигурация'
  ,'value' => PrvFill('install_dcs_config_id',$row['install_dcs_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'install_dcs_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=dcs_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Рабочая конфигурация'
  ,'value' => PrvFill('work_dcs_config_id',$row['work_dcs_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'work_dcs_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=dcs_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'1', 'display'=>'1')
  ,array ('value'=>'2', 'display'=>'2')
  ,array ('value'=>'3', 'display'=>'3')
);
$info[] = $info1 = array (
   'field' => 'Количество шкафов 3G'
  ,'value' => PrvFill('cupboard_3g_count',$row['cupboard_3g_count'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'cupboard_3g_count'
  ,'list' => $list
);
$info[] = $info1 = array (
   'field' => '<b>Конфигурация UMTS 2100</b>'
  ,'el_type' => 'break'
);
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<count($umts_configs); $i++) {
    $list[] = array('value' => $umts_configs[$i]['value'], 'display' => $umts_configs[$i]['display']);  
}  
$info[] = $info1 = array (
   'field' => 'Планируемая конфигурация'
  ,'value' => PrvFill('plan_umts_config_id',$row['plan_umts_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'plan_umts_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=umts_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Рабочая конфигурация'
  ,'value' => PrvFill('work_umts_config_id',$row['work_umts_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'work_umts_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=umts_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => '<b>Конфигурация UMTS 900</b>'
  ,'el_type' => 'break'
);
$info[] = $info1 = array (
   'field' => 'Планируемая конфигурация'
  ,'value' => PrvFill('plan_umts9_config_id',$row['plan_umts9_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'plan_umts9_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=umts9_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Рабочая конфигурация'
  ,'value' => PrvFill('work_umts9_config_id',$row['work_umts9_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'work_umts9_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=umts9_configs&#039;,&#039;config_edit_form&#039;);"
);

// 4G
$info[] = $info1 = array (
  'el_type' => 'break'
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'1', 'display'=>'1')
  ,array ('value'=>'2', 'display'=>'2')
  ,array ('value'=>'3', 'display'=>'3')
);
$info[] = $info1 = array (
   'field' => 'Количество шкафов 4G'
  ,'value' => PrvFill('cupboard_4g_count',$row['cupboard_4g_count'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_small'
  ,'name' => 'cupboard_4g_count'
  ,'list' => $list
);
$info[] = $info1 = array (
   'field' => '<b>Конфигурация LTE 1800</b>'
  ,'el_type' => 'break'
);
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<count($lte_configs); $i++) {
    $list[] = array('value' => $lte_configs[$i]['value'], 'display' => $lte_configs[$i]['display']);  
}  
$info[] = $info1 = array (
   'field' => 'Планируемая конфигурация'
  ,'value' => PrvFill('plan_lte_config_id',$row['plan_lte_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'plan_lte_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=lte_configs&#039;,&#039;config_edit_form&#039;);"
);
$info[] = $info1 = array (
   'field' => 'Рабочая конфигурация'
  ,'value' => PrvFill('work_lte_config_id',$row['work_lte_config_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field_medium'
  ,'name' => 'work_lte_config_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=lte_configs&#039;,&#039;config_edit_form&#039;);"
);

// вывод элементов интерфейса
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='config_edit.php?id=$id' method='post' id='config_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>сохранить</button></p>";
echo "</form>";
echo "</div>";
?>