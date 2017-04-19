<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql="     SELECT ";
$sql=$sql." technology_generation ";
$sql=$sql.",budget_type_2g ";
$sql=$sql.",budget_number_2g ";
$sql=$sql.",budget_source_2g ";
$sql=$sql.",budget_type_3g ";
$sql=$sql.",budget_number_3g ";
$sql=$sql.",budget_source_3g ";
$sql=$sql.",existing_object ";
$sql=$sql.",bts.bts_number ";
$sql=$sql.",budget.bts_id ";
$sql=$sql.",demontation_bts_id ";
$sql=$sql.",bts_demon.bts_number as demon_number ";
$sql=$sql.",outside_id ";
$sql=$sql.",budget.site_type ";
$sql=$sql.",budget.cooperative ";
$sql=$sql.",budget_year ";
$sql=$sql.",budget_month ";
$sql=$sql.",budget.construction_2g_type_id ";
$sql=$sql.",construction_2g_types.construction_type as constract_2g ";
$sql=$sql.",budget.construction_3g_type_id ";
$sql=$sql.",construction_3g_types.construction_type as constract_3g ";
$sql=$sql.",budget.model_type_2g as model_type_2g";
$sql=$sql.",budget.model_type_3g as model_type_3g";
$sql=$sql.",budget.gsm_config_id as gsm_config_id";
$sql=$sql.",gsm_config ";
$sql=$sql.",budget.dcs_config_id as dcs_config_id";
$sql=$sql.",dcs_config ";
$sql=$sql.",budget.umts_config_id as umts_config_id";
$sql=$sql.",umts_config ";
$sql=$sql.",transport_type ";
$sql=$sql.",transport_technology ";
$sql=$sql.",budget.bsc_id as bsc_id";
$sql=$sql.",bsc_number ";
$sql=$sql.",budget.rnc_id as rnc_id";
$sql=$sql.",rnc_number ";
$sql=$sql.",budget.lac_2g ";
$sql=$sql.",budget.lac_3g ";
$sql=$sql.",equipment_delivered ";
$sql=$sql.",budget.notes ";
$sql=$sql."FROM budget ";
$sql=$sql."LEFT JOIN construction_2g_types ";
$sql=$sql."ON construction_2g_type_id=construction_2g_types.id ";
$sql=$sql."LEFT JOIN construction_3g_types ";
$sql=$sql."ON construction_3g_type_id=construction_3g_types.id ";
$sql=$sql."LEFT JOIN gsm_configs ";
$sql=$sql."ON gsm_config_id=gsm_configs.id ";
$sql=$sql."LEFT JOIN dcs_configs ";
$sql=$sql."ON dcs_config_id=dcs_configs.id ";
$sql=$sql."LEFT JOIN umts_configs ";
$sql=$sql."ON umts_config_id=umts_configs.id ";
$sql=$sql."LEFT JOIN bts ";
$sql=$sql."ON bts.id=bts_id ";
$sql=$sql."LEFT JOIN bsc ";
$sql=$sql."ON bsc.id=budget.bsc_id ";
$sql=$sql."LEFT JOIN rnc ";
$sql=$sql."ON rnc.id=budget.rnc_id ";
$sql=$sql."LEFT JOIN bts bts_demon ";
$sql=$sql."ON bts_demon.id=demontation_bts_id ";
$sql=$sql."WHERE budget.id=".NumOrNull($id);
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// формируем элементы
$info[] = $info1 = array (
 'field' => 'Тип'
,'value' => PrvFill('technology_generation',$row['technology_generation'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'technology_generation'
,'required' => true
,'disabled' => true
,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=budget_year&#039;,&#039;budget_edit&#039;);"
);

$info[] = $info1 = array (
 'field' => 'Год бюджета'
,'value' => PrvFill('budget_year',$row['budget_year'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'budget_year'
,'required' => true
,'disabled' => true
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$info[] = $info1 = array (
 'field' => 'Тип и номер бюджета 2G'
,'value' => PrvFill('budget_type_2g',$row['budget_type_2g'])
,'el_type' => 'text'
,'id' => 'select_field_medium'
,'name' => 'budget_type_2g'
,'start_line' => true
,'disabled' => true
);

$info[] = $info1 = array (
 'value' => PrvFill('budget_number_2g',$row['budget_number_2g'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'budget_number_2g'
,'end_line' => true
,'disabled' => true
);

$info[] = $info1 = array (
 'field' => 'Источник для 2G'
,'value' => PrvFill('budget_source_2g',$row['budget_source_2g'])
,'el_type' => 'text'
,'id' => 'text_field_medium'
,'name' => 'budget_source_2g'
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$info[] = $info1 = array (
 'field' => 'Тип и номер бюджета 3G'
,'value' => PrvFill('budget_type_3g',$row['budget_type_3g'])
,'el_type' => 'text'
,'id' => 'select_field_medium'
,'name' => 'budget_type_3g'
,'start_line' => true
,'disabled' => true
);

$info[] = $info1 = array (
 'value' => PrvFill('budget_number_3g',$row['budget_number_3g'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'budget_number_3g'
,'end_line' => true
,'disabled' => true
);

$info[] = $info1 = array (
 'field' => 'Источник для 3G'
,'value' => PrvFill('budget_source_3g',$row['budget_source_3g'])
,'el_type' => 'text'
,'id' => 'text_field_medium'
,'name' => 'budget_source_3g'
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'январь', 'display'=>'январь')
 ,array ('value'=>'февраль', 'display'=>'февраль')
 ,array ('value'=>'март', 'display'=>'март')
 ,array ('value'=>'апрель', 'display'=>'апрель')
 ,array ('value'=>'май', 'display'=>'май')
 ,array ('value'=>'июнь', 'display'=>'июнь')
 ,array ('value'=>'июль', 'display'=>'июль')
 ,array ('value'=>'август', 'display'=>'август')
 ,array ('value'=>'сентябрь', 'display'=>'сентябрь')
 ,array ('value'=>'октябрь', 'display'=>'октябрь')
 ,array ('value'=>'ноябрь', 'display'=>'ноябрь')
 ,array ('value'=>'декабрь', 'display'=>'декабрь')
);
$info[] = $info1 = array (
 'field' => 'Месяц бюджета'
,'value' => PrvFill('budget_month',$row['budget_month'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'budget_month' 
,'list' => $list
);

$existing_object = PrvFill('existing_object',$row['existing_object']);
$info[] = $info1 = array (
 'field' => 'Вхождение на существующий объект'
,'value' => $existing_object
,'el_type' => 'checkbox'
,'id' => ''
,'name' => 'existing_object'
,'onclick' => "ad_edit(&#039;redirect.php?f=13&id=$id&#039;,&#039;budget_edit&#039;);"
);

$sql2="SELECT bts_number,Id FROM bts WHERE bts_number IS NOT NULL ORDER BY bts_number";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
$list2[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
  $list2[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}

if (!$existing_object == 1) {$disabled = true;} else {$disabled = false;} 
$info[] = $info1 = array (
 'field' => 'Номер БС'
,'value' => PrvFill('bts_id',$row['bts_id'])
,'el_type' => 'select'
,'id' => 'select_field_small'
,'name' => 'bts_id'
,'list' => $list2
,'disabled' => $disabled
);

$info[] = $info1 = array (
 'field' => 'Номер демонтируемой БС'
,'value' => PrvFill('demontation_bts_id',$row['demontation_bts_id'])
,'el_type' => 'select'
,'id' => 'select_field_small'
,'name' => 'demontation_bts_id'
,'list' => $list
);

$info[] = $info1 = array (
 'field' => 'Внешний id'
,'value' => PrvFill('outside_id',$row['outside_id'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'outside_id'
);

$info[] = $info1 = array (
'el_type' => 'break'
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
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'совместная с ИП Velcom', 'display'=>'совместная с ИП Velcom')
 ,array ('value'=>'совместная с ЗАО БеСТ', 'display'=>'совместная с ЗАО БеСТ')
 ,array ('value'=>'совместная с СООО МТС', 'display'=>'совместная с СООО МТС')
);
$info[] = $info1 = array (
 'field' => 'Совместная'
,'value' => PrvFill('cooperative',$row['cooperative'])
,'el_type' => 'select'
,'id' => 'select_field'
,'name' => 'cooperative' 
,'list' => $list
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$sql2="SELECT construction_type,Id FROM construction_2g_types ORDER BY construction_type";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Тип металлоконструкции 2G'
,'value' => PrvFill('construction_2g_type_id',$row['construction_2g_type_id'])
,'el_type' => 'select'
,'id' => 'select_field'
,'name' => 'construction_2g_type_id'
,'list' => $list
,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=construction_2g_types&#039;,&#039;budget_edit&#039;);"
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'BS - 240', 'display'=>'BS - 240')
 ,array ('value'=>'BS - 240 II', 'display'=>'BS - 240 II')
 ,array ('value'=>'BS - 240 II + BS - 82 II', 'display'=>'BS - 240 II + BS - 82 II')
 ,array ('value'=>'BS - 82', 'display'=>'BS - 82')
 ,array ('value'=>'BS - 82 II', 'display'=>'BS - 82 II')
 ,array ('value'=>'BS - 240 XL', 'display'=>'BS - 240 XL')
 ,array ('value'=>'BTS - 3900', 'display'=>'BTS - 3900')
 ,array ('value'=>'BTS - 3900 + DBS - 3900', 'display'=>'BTS - 3900 + DBS - 3900')
 ,array ('value'=>'DBS - 3900', 'display'=>'DBS - 3900')
);
$info[] = $info1 = array (
 'field' => 'Модель 2G'
,'value' => PrvFill('model_type_2g',$row['model_type_2g'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'model_type_2g'
,'list' => $list
);

$sql2="SELECT gsm_config,Id FROM gsm_configs ORDER BY gsm_config";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Конфигурация GSM'
,'value' => PrvFill('gsm_config_id',$row['gsm_config_id'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'gsm_config_id'
,'list' => $list
,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=gsm_configs&#039;,&#039;budget_edit&#039;);"
);

$sql2="SELECT dcs_config,Id FROM dcs_configs ORDER BY dcs_config";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Конфигурация DCS'
,'value' => PrvFill('dcs_config_id',$row['dcs_config_id'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'dcs_config_id'
,'list' => $list
,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=dcs_configs&#039;,&#039;budget_edit&#039;);"
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$sql2="SELECT construction_type,Id FROM construction_3g_types ORDER BY construction_type";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Тип металлоконструкции 3G'
,'value' => PrvFill('construction_3g_type_id',$row['construction_3g_type_id'])
,'el_type' => 'select'
,'id' => 'select_field'
,'name' => 'construction_3g_type_id'
,'list' => $list
,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=construction_3g_types&#039;,&#039;budget_edit&#039;);"
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'DBS - 3900', 'display'=>'DBS - 3900')
 ,array ('value'=>'Flexi WCDMA BTS', 'display'=>'Flexi WCDMA BTS')
);
$info[] = $info1 = array (
 'field' => 'Модель 3G'
,'value' => PrvFill('model_type_3g',$row['model_type_3g'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'model_type_3g'
,'list' => $list
);

$sql2="SELECT umts_config,Id FROM umts_configs ORDER BY umts_config";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Конфигурация UMTS'
,'value' => PrvFill('umts_config_id',$row['umts_config_id'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'umts_config_id'
,'list' => $list
,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=umts_configs&#039;,&#039;budget_edit&#039;);"
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'Аренда', 'display'=>'Аренда')
 ,array ('value'=>'ВОЛС', 'display'=>'ВОЛС')
 ,array ('value'=>'РРЛ', 'display'=>'РРЛ')
 ,array ('value'=>'MBH', 'display'=>'MBH')
 ,array ('value'=>'ВОК', 'display'=>'ВОК')
 ,array ('value'=>'ВОЛС, Аренда', 'display'=>'ВОЛС, Аренда')
 ,array ('value'=>'Модем', 'display'=>'Модем')
 ,array ('value'=>'РУЭС', 'display'=>'РУЭС')
);
$info[] = $info1 = array (
 'field' => 'Тип транспорта'
,'value' => PrvFill('transport_type',$row['transport_type'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'transport_type'
,'list' => $list
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'E1', 'display'=>'E1')
 ,array ('value'=>'Ethernet', 'display'=>'Ethernet')
 ,array ('value'=>'РРЛ', 'display'=>'РРЛ')
);
$info[] = $info1 = array (
 'field' => 'Технология транспорта'
,'value' => PrvFill('transport_technology',$row['transport_technology'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'transport_technology'
,'list' => $list
);

$sql2="SELECT bsc_number,Id FROM bsc ORDER BY bsc_number";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Планируемый BSC'
,'value' => PrvFill('bsc_id',$row['bsc_id'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'bsc_id'
,'list' => $list
);

$info[] = $info1 = array (
 'field' => 'Планируемый LAC 2G'
,'value' => PrvFill('lac_2g',$row['lac_2g'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'lac_2g'
,'pattern' => '[0-9]*'
);

$sql2="SELECT rnc_number,Id FROM rnc ORDER BY rnc_number";
$query2=mysql_query($sql2) or die(mysql_error());
array_splice ($list,0);
$list[] = array ('value'=>'', 'display'=>'');
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
}
$info[] = $info1 = array (
 'field' => 'Планируемый RNC'
,'value' => PrvFill('rnc_id',$row['rnc_id'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'rnc_id'
,'list' => $list
);

$info[] = $info1 = array (
 'field' => 'Планируемый LAC 3G'
,'value' => PrvFill('lac_3g',$row['lac_3g'])
,'el_type' => 'text'
,'id' => 'select_field_small'
,'name' => 'lac_3g'
,'pattern' => '[0-9]*'
);

$info[] = $info1 = array (
'el_type' => 'break'
);

$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>1, 'display'=>'развезено')
);
$info[] = $info1 = array (
 'field' => 'Развоз оборудования'
,'value' => PrvFill('equipment_delivered',$row['equipment_delivered'])
,'el_type' => 'select'
,'id' => 'select_field_medium'
,'name' => 'equipment_delivered'
,'list' => $list
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

// дополнительный запрос
$sql="SELECT ";
$sql=$sql." Id ";
$sql=$sql.",settlement_id ";
$sql=$sql.",street_type ";
$sql=$sql.",street_name ";
$sql=$sql.",house_type ";
$sql=$sql.",house_number ";
$sql=$sql.",doc_date ";
$sql=$sql.",doc_link ";
$sql=$sql."FROM budget_addresses ";
$sql=$sql."WHERE budget_addresses.budget_id=$id ORDER BY budget_addresses.id DESC";
$query=mysql_query($sql) or die(mysql_error());

$row_count=PrvFill('row_count',mysql_num_rows($query));

for ($i=0; $i<$row_count; $i++) {
  $row = mysql_fetch_array($query);
  
  // формируем дополнительные элементы
  $settlement_id = PrvFill('settlement_id_'.$i,$row['settlement_id']);
  $sql="SELECT ";
  $sql=$sql." settlement ";
  $sql=$sql.",type ";
  $sql=$sql.",area ";
  $sql=$sql.",region ";
  $sql=$sql.",areas.id as area_id ";
  $sql=$sql.",regions.id as region_id ";
  $sql=$sql."FROM settlements, areas, regions ";
  $sql=$sql."WHERE settlements.area_id=areas.id AND areas.region_id=regions.id  AND settlements.id=".NumOrNull($settlement_id);
  $query2=mysql_query($sql) or die(mysql_error());
  $row2 = mysql_fetch_array($query2);
 
  $ad_info[] = $info1 = array (
     'value' => PrvFill('Id_'.$i,$row['Id'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'Id_'.$i
    ,'hidden' => true
  );
 
  $ad_info[] = $info1 = array (
    'field' => 'Населённый пункт'
    ,'value' => $row2['type']." ".$row2['settlement']
    ,'el_type' => 'text'
    ,'id' => 'text_field_medium'
    ,'name' => 'settlement_id_'.$i
    ,'disabled' => true
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=region&i=$i&#039;,&#039;budget_edit&#039;);"
    ,'ad_delete' => "confirmDelete(&#039;redirect.php?f=13&rn=$i&del&#039;,&#039;budget_edit&#039;);"
    ,'show_field' => true
    ,'required' => true
  );
  $ad_info[] = $info1 = array (
    'field' => 'Район'
    ,'value' => $row2['area']
    ,'el_type' => 'text'
    ,'id' => 'text_field_medium'
    ,'name' => 'area_'.$i
    ,'disabled' => true
    ,'show_field' => true
  );
  $ad_info[] = $info1 = array (
    'field' => 'Область'
    ,'value' => $row2['region']
    ,'el_type' => 'text'
    ,'id' => 'text_field_medium'
    ,'name' => 'region_'.$i
    ,'disabled' => true
    ,'show_field' => true
  );
  
  $ad_info[] = $info1 = array (
     'value' => $settlement_id
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'settlement_id_'.$i
    ,'hidden' => true
    ,'required' => true
  );
  
  $ad_info[] = $info1 = array (
     'value' => $row2['area_id']
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'area_id_'.$i
    ,'hidden' => true
  );
  
  $ad_info[] = $info1 = array (
     'value' => $row2['region_id']
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'region_id_'.$i
    ,'hidden' => true
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
  $ad_info[] = $info1 = array (
     'field' => 'Улица'
    ,'value' => PrvFill('street_type_'.$i,$row['street_type'])
    ,'el_type' => 'select'
    ,'id' => 'select_field_small'
    ,'name' => 'street_type_'.$i
    ,'show_field' => true
    ,'list' => $list
    ,'start_line' => true
  );
  
  $ad_info[] = $info1 = array (
     'value' => PrvFill('street_name_'.$i,$row['street_name'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_medium'
    ,'name' => 'street_name_'.$i
    ,'end_line' => true
  );
  
  $list = array (
    array ('value'=>'', 'display'=>'')
   ,array ('value'=>'д.', 'display'=>'д.')
   ,array ('value'=>'стр.', 'display'=>'стр.')
  );
  $ad_info[] = $info1 = array (
     'field' => 'Дом'
    ,'value' => PrvFill('house_type_'.$i,$row['house_type'])
    ,'el_type' => 'select'
    ,'id' => 'select_field_small'
    ,'name' => 'house_type_'.$i
    ,'show_field' => true
    ,'list' => $list
    ,'start_line' => true
  );
  
  $ad_info[] = $info1 = array (
     'value' => PrvFill('house_number_'.$i,$row['house_number'])
    ,'el_type' => 'text'
    ,'id' => 'select_field_small'
    ,'name' => 'house_number_'.$i
    ,'end_line' => true
  );
  
  $ad_info[] = $info1 = array (
     'field' => 'Дата'
    ,'value' => PrvFill('doc_date_'.$i,$row['doc_date'])
    ,'el_type' => 'date'
    ,'id' => 'text_field_medium'
    ,'name' => 'doc_date_'.$i
    ,'show_field' => true
  );
  
  $ad_info[] = $info1 = array (
     'field' => 'Ссылка'
    ,'value' => PrvFill('doc_link_'.$i,$row['doc_link'])
    ,'el_type' => 'link'
    ,'id' => 'text_field_medium'
    ,'name' => 'doc_link_'.$i
    ,'show_field' => true
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=doc_link&i=$i&#039;,&#039;budget_edit&#039;);"
  );
  
  $ad_info[] = $info1 = array (
     'value' => PrvFill('doc_link_'.$i,$row['doc_link'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'doc_link_'.$i
    ,'hidden' => true
  );
  
  $ad_info[] = $info1 = array (
    'el_type' => 'break'
  );
  $ad_info[] = $info1 = array (
    'el_type' => 'break'
  );
  $ad_info[] = $info1 = array (
    'el_type' => 'break'
  );
}

// вывод элементов интерфейса
echo "<div id='main_content'>";

echo "  <div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "  </div>";

echo "<form action='budget_edit.php?id=$id' method='post' id='budget_edit'>";
echo "  <div id='right_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "  <p><button type='submit'>сохранить</button></p>";
echo "  </div>";
echo "  <div id='add_indent'>";
echo "  <p><input type='button' value='добавить лист согласования' onclick='ad_edit(&#039;redirect.php?f=13&add&#039;,&#039;budget_edit&#039;);'></p><br>";

for ($i=0;$i<count($ad_info);$i++) {
  FieldEdit($ad_info[$i]);
}
echo "  </div>";
echo "</form";

echo "</div>";
?>