<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql="SELECT";
$sql.= " site_type";
$sql.= ",bts_number";
$sql.= ",place_owner";
$sql.= ",cooperative";
$sql.= ",construction_2g_types.construction_type as construction_type_2g";
$sql.= ",construction_3g_types.construction_type as construction_type_3g";
$sql.= ",construction_4g_types.construction_type as construction_type_4g";
$sql.= ",model_type_2g";
$sql.= ",model_type_3g";
$sql.= ",model_type_4g";
$sql.= ",container_type";
$sql.= ",cupboard_2g_count";
$sql.= ",cupboard_3g_count";
$sql.= ",cupboard_4g_count";
$sql.= ",plan_gsm.gsm_config as plan_gsm_config";
$sql.= ",plan_dcs.dcs_config as plan_dcs_config";
$sql.= ",work_gsm.gsm_config as work_gsm_config";
$sql.= ",work_dcs.dcs_config as work_dcs_config";
$sql.= ",install_gsm.gsm_config as install_gsm_config";
$sql.= ",install_dcs.dcs_config as install_dcs_config";
$sql.= ",plan_umts.umts_config as plan_umts_config";
$sql.= ",work_umts.umts_config as work_umts_config";
$sql.= ",plan_umts9.umts_config as plan_umts9_config";
$sql.= ",work_umts9.umts_config as work_umts9_config";
$sql.= ",plan_lte.lte_config as plan_lte_config";
$sql.= ",work_lte.lte_config as work_lte_config";
$sql.= ",power_type";
$sql.= ",battery_capacity";
$sql.= ",power_cupboard_count";
$sql.= ",longitudel_s";
$sql.= ",longitudel_d";
$sql.= ",notes";
$sql.= ",focl_2g";
$sql.= ",rent_2g";
$sql.= ",focl_3g";
$sql.= ",rent_3g";
$sql.= ",settlements.type";
$sql.= ",settlement";
$sql.= ",area";
$sql.= ",region";
$sql.= ",street_type";
$sql.= ",street_name";
$sql.= ",house_type";
$sql.= ",house_number";
$sql.= " FROM bts";
$sql.= " LEFT JOIN construction_2g_types";
$sql.= " ON bts.construction_2g_type_id=construction_2g_types.id";
$sql.= " LEFT JOIN construction_3g_types";
$sql.= " ON bts.construction_3g_type_id=construction_3g_types.id";
$sql.= " LEFT JOIN construction_4g_types";
$sql.= " ON bts.construction_4g_type_id=construction_4g_types.id";
$sql.= " LEFT JOIN gsm_configs plan_gsm";
$sql.= " ON bts.plan_gsm_config_id=plan_gsm.id";
$sql.= " LEFT JOIN dcs_configs plan_dcs";
$sql.= " ON bts.plan_dcs_config_id=plan_dcs.id";
$sql.= " LEFT JOIN gsm_configs work_gsm";
$sql.= " ON bts.work_gsm_config_id=work_gsm.id";
$sql.= " LEFT JOIN dcs_configs work_dcs";
$sql.= " ON bts.work_dcs_config_id=work_dcs.id";
$sql.= " LEFT JOIN gsm_configs install_gsm";
$sql.= " ON bts.install_gsm_config_id=install_gsm.id";
$sql.= " LEFT JOIN dcs_configs install_dcs";
$sql.= " ON bts.install_dcs_config_id=install_dcs.id";
$sql.= " LEFT JOIN umts_configs plan_umts";
$sql.= " ON bts.plan_umts_config_id=plan_umts.id";
$sql.= " LEFT JOIN umts_configs work_umts";
$sql.= " ON bts.work_umts_config_id=work_umts.id";
$sql.= " LEFT JOIN umts_configs plan_umts9";
$sql.= " ON bts.plan_umts9_config_id=plan_umts9.id";
$sql.= " LEFT JOIN umts_configs work_umts9";
$sql.= " ON bts.work_umts9_config_id=work_umts9.id";
$sql.= " LEFT JOIN lte_configs plan_lte";
$sql.= " ON bts.plan_lte_config_id=plan_lte.id";
$sql.= " LEFT JOIN lte_configs work_lte";
$sql.= " ON bts.work_lte_config_id=work_lte.id";
$sql.= " LEFT JOIN power_types";
$sql.= " ON bts.power_type_id=power_types.id";
$sql.= " LEFT JOIN settlements";
$sql.= " ON bts.settlement_id=settlements.id";
$sql.= " LEFT JOIN areas";
$sql.= " ON settlements.area_id=areas.id";
$sql.= " LEFT JOIN regions";
$sql.= " ON areas.region_id=regions.id";
$sql.= " WHERE bts.Id=".NumOrNull($id); 
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

$sql = "SELECT *, sectors.tech_type as tech_type";
$sql.= " FROM sectors, antenna_types WHERE";
$sql.= "     sectors.antenna_type_id=antenna_types.id";
$sql.= " AND sectors.tech_type in ('2g','gsm','dcs')"; 
$sql.= " AND bts_id=$id ORDER BY num,sectors.id"; 
$query2 = mysql_query($sql) or die(mysql_error()); 

$sql = "SELECT";
$sql.= " num";
$sql.= ",sectors.tech_type";
$sql.= ",antenna_type";
$sql.= ",antenna_count";
$sql.= ",height";
$sql.= ",azimuth";
$sql.= ",tm_slope";
$sql.= ",te_slope";
$sql.= ",cable_type";
$sql.= ",cable_length";
$sql.= ",ret_type";
$sql.= ",msu_type";
$sql.= " FROM sectors, antenna_types WHERE";
$sql.= "     sectors.antenna_type_id=antenna_types.id";
$sql.= " AND sectors.tech_type='umts 2100'"; 
$sql.= " AND bts_id=$id ORDER BY num,sectors.id"; 
$query3 = mysql_query($sql) or die(mysql_error()); 

$sql = "SELECT";
$sql.= " num";
$sql.= ",sectors.tech_type";
$sql.= ",antenna_type";
$sql.= ",antenna_count";
$sql.= ",height";
$sql.= ",azimuth";
$sql.= ",tm_slope";
$sql.= ",te_slope";
$sql.= ",cable_type";
$sql.= ",cable_length";
$sql.= ",ret_type";
$sql.= ",msu_type";
$sql.= " FROM sectors, antenna_types WHERE";
$sql.= "     sectors.antenna_type_id=antenna_types.id";
$sql.= " AND sectors.tech_type='umts 900'"; 
$sql.= " AND bts_id=$id ORDER BY num,sectors.id"; 
$query6 = mysql_query($sql) or die(mysql_error()); 

$sql = "SELECT";
$sql.= " num";
$sql.= ",sectors.tech_type";
$sql.= ",antenna_type";
$sql.= ",antenna_count";
$sql.= ",height";
$sql.= ",azimuth";
$sql.= ",tm_slope";
$sql.= ",te_slope";
$sql.= ",cable_type";
$sql.= ",cable_length";
$sql.= ",ret_type";
$sql.= ",msu_type";
$sql.= " FROM sectors, antenna_types WHERE";
$sql.= "     sectors.antenna_type_id=antenna_types.id";
$sql.= " AND sectors.tech_type='lte 1800'"; 
$sql.= " AND bts_id=$id ORDER BY num,sectors.id"; 
$query7 = mysql_query($sql) or die(mysql_error()); 

$sql = "SELECT p1.bts_number ";
$sql.= ",IF(p1.id=p2.bts_id_point1,height_point1,height_point2) as height ";
$sql.= ",IF(p1.id=p2.bts_id_point1,diam_point1,diam_point2) as diam ";
$sql.= ",IF(p1.id=p2.bts_id_point1,azimuth_point1,azimuth_point2) as azimuth ";
$sql.= ",p3.bts_number as bts_number2 ";
$sql.= ",IF(p1.id=p2.bts_id_point2,height_point1,height_point2) as height2 ";
$sql.= ",IF(p1.id=p2.bts_id_point2,diam_point1,diam_point2) as diam2 ";
$sql.= ",IF(p1.id=p2.bts_id_point2,azimuth_point1,azimuth_point2) as azimuth2 ";
$sql.= ",fr_range,stream_total,stream_work,reserve,equipment ";
$sql.= "FROM (SELECT bts_number,id FROM bts WHERE bts.id=$id) p1 ";
$sql.= "JOIN (SELECT * FROM rrl) p2 ";
$sql.= "ON p1.id=p2.bts_id_point1 OR p1.id=p2.bts_id_point2 ";
$sql.= "JOIN (SELECT bts_number, id FROM bts) p3 ";
$sql.= "ON (p3.id=p2.bts_id_point1 OR p3.id=p2.bts_id_point2) AND p1.id<>p3.id ORDER BY bts_number2";
$query4=mysql_query($sql) or die(mysql_error());

$sql = "SELECT *";
$sql.= " FROM hardware WHERE";
$sql.= " bts_id=$id"; 
$query5 = mysql_query($sql) or die(mysql_error()); 

// формируем элементы
$info1 = array (
   $row['site_type'] => $row['bts_number']
  ,'адрес' =>  FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])  
  ,'размещение' => $row['place_owner']
  ,'кооперация' => $row['cooperative']
);
$info2 = array (
   'тип металлоконструкции' => $row['construction_type_2g']
  ,'модель' => $row['model_type_2g']
  ,'тип контейнера' => $row['container_type']
  ,'кол-во шкафов' => $row['cupboard_2g_count']
);
$table1 = array (
   array ('','gsm','dcs')
  ,array ('планируемая конфигурация',$row['plan_gsm_config'],$row['plan_dcs_config'])
  ,array ('установленная конфигурация',$row['install_gsm_config'],$row['install_dcs_config'])
  ,array ('рабочая конфигурация',$row['work_gsm_config'],$row['work_dcs_config'])
);  
$info3 = array (
   'тип металлоконструкции' => $row['construction_type_3g']
  ,'модель' => $row['model_type_3g']
  ,'кол-во шкафов' => $row['cupboard_3g_count']
);
$table2 = array (
   array ('','umts 2100','umts 900')
  ,array ('планируемая конфигурация',$row['plan_umts_config'],$row['plan_umts9_config'])
  ,array ('рабочая конфигурация',$row['work_umts_config'],$row['work_umts9_config'])
);
$info7 = array (
   'тип металлоконструкции' => $row['construction_type_4g']
  ,'модель' => $row['model_type_4g']
  ,'кол-во шкафов' => $row['cupboard_4g_count']
); 
$table7 = array (
   array ('','lte 1800')
  ,array ('планируемая конфигурация',$row['plan_lte_config'])
  ,array ('рабочая конфигурация',$row['work_lte_config'])
);
$info4 = array (
   'тип питания' => $row['power_type']
  ,'ёмкость аккумуляторов' => $row['battery_capacity']
  ,'кол-во шкафов питания' => $row['power_cupboard_count']
);

if (!empty($row['longitudel_d'])) {
  $geo = MyGeoToDisplay($row['longitudel_d'])." ВД&nbsp;&nbsp;&nbsp;".MyGeoToDisplay($row['longitudel_s'])." СШ"; 
  $dec_geo = "E".MyGeoToDecDisplay($row['longitudel_d'])."&nbsp;&nbsp;&nbsp;N".MyGeoToDecDisplay($row['longitudel_s']);
}

$info5 = array (
   'координаты' => $geo
  ,'десятичные координаты' => $dec_geo
  ,'примечание' => $row['notes']
);

$table3 = array (
   array ('номер','стандарт','тип антенны','кол-во','высота<br>(размещ.)','азимут','tm','te','тип каб.','длина каб.','мшу')
); 
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2);
  $table3[] = array(
     $row2['num']
    ,$row2['tech_type']
    ,$row2['antenna_type']
    ,$row2['antenna_count']
    ,$row2['height']
    ,ZeroOnEmpty($row2['azimuth'])
    ,ZeroOnEmpty($row2['tm_slope'])
    ,ZeroOnEmpty($row2['te_slope'])
    ,$row2['cable_type']
    ,$row2['cable_length']
    ,$row2['msu_type']
  ); 
}

$table4 = array (
   array ('номер','стандарт','тип антенны','кол-во','высота<br>(размещ.)','азимут','tm','te','тип каб.','длина каб.','ret','мшу')
); 
for ($i=0; $i<mysql_num_rows($query3); $i++) {
  $row2 = mysql_fetch_array($query3);
  $table4[] = array(
     $row2['num']
    ,$row2['tech_type']
    ,$row2['antenna_type']
    ,$row2['antenna_count']
    ,$row2['height']
    ,ZeroOnEmpty($row2['azimuth'])
    ,ZeroOnEmpty($row2['tm_slope'])
    ,ZeroOnEmpty($row2['te_slope'])
    ,$row2['cable_type']
    ,$row2['cable_length']
    ,$row2['ret_type']
    ,$row2['msu_type']
  ); 
}
    
$table8 = array (
   array ('номер','стандарт','тип антенны','кол-во','высота<br>(размещ.)','азимут','tm','te','тип каб.','длина каб.','ret','мшу')
); 
for ($i=0; $i<mysql_num_rows($query6); $i++) {
  $row2 = mysql_fetch_array($query6);
  $table8[] = array(
     $row2['num']
    ,$row2['tech_type']
    ,$row2['antenna_type']
    ,$row2['antenna_count']
    ,$row2['height']
    ,ZeroOnEmpty($row2['azimuth'])
    ,ZeroOnEmpty($row2['tm_slope'])
    ,ZeroOnEmpty($row2['te_slope'])
    ,$row2['cable_type']
    ,$row2['cable_length']
    ,$row2['ret_type']
    ,$row2['msu_type']
  ); 
}  

$table9 = array (
   array ('номер','стандарт','тип антенны','кол-во','высота<br>(размещ.)','азимут','tm','te','тип каб.','длина каб.','ret','мшу')
); 
for ($i=0; $i<mysql_num_rows($query7); $i++) {
  $row2 = mysql_fetch_array($query7);
  $table9[] = array(
     $row2['num']
    ,$row2['tech_type']
    ,$row2['antenna_type']
    ,$row2['antenna_count']
    ,$row2['height']
    ,ZeroOnEmpty($row2['azimuth'])
    ,ZeroOnEmpty($row2['tm_slope'])
    ,ZeroOnEmpty($row2['te_slope'])
    ,$row2['cable_type']
    ,$row2['cable_length']
    ,$row2['ret_type']
    ,$row2['msu_type']
  ); 
}    
                                                                    
  //echo "bsc будет браться с кроссировок<br>";
  //echo "lac 2G<br>";
  //echo "<br>";
  //echo "rnc будет браться с кроссировок<br>";
  //echo "lac 3G<br>";
  //echo "<br>";
  
$info6 = array (
   '2G привязывается по ВОЛС' => ($row['focl_2g']==1? 'да' : '')
  ,'2G привязывается по аренде РУП "Белтелеком"' => ($row['rent_2g']==1? 'да' : '')
  ,'3G привязывается по ВОЛС' => ($row['focl_3g']==1? 'да' : '')
  ,'3G привязывается по аренде РУП "Белтелеком"' => ($row['rent_3g']==1? 'да' : '')
);  

$table5 = array (
   array ('п.1','выс.1','диам.1','азим.1','п.2','выс.2','диам.2','азим.2','тип РРС','поток','резерв','оборудов.')
); 
for ($i=0; $i<mysql_num_rows($query4); $i++) {
  $row2 = mysql_fetch_array($query4);
  $table5[] = array(
     "БС".$row2['bts_number']
    ,$row2['height']
    ,$row2['diam']
    ,$row2['azimuth']
    ,"БС".$row2['bts_number2']
    ,$row2['height2']
    ,$row2['diam2']
    ,$row2['azimuth2']
    ,$row2['fr_range']
    ,$row2['stream_total']
    ,$row2['reserve']
    ,str_replace('Pasolink','',$row2['equipment'])
  ); 
}

$table6 = array (
   array ('','оборудование','кол-во')
); 
for ($i=0; $i<mysql_num_rows($query5); $i++) {
  $row2 = mysql_fetch_array($query5);
  $table6[] = array(
     ''
    ,$row2['equipment']
    ,$row2['quantity']
  ); 
}

// блок списка кнопок действий
if ($bm == 'w' || ($fm == 'w' && $_SESSION['enable_to_edit'] == 1) ) {
  $info=array (
     'Редактировать Общие Данные' => "index.php?f=3&id=$id"
    ,'Редактировать Конфигурацию' => "index.php?f=7&id=$id"
    ,'Редактировать Сектора' => "index.php?f=8&id=$id"
    ,'Редактировать Транспорт' => "index.php?f=9&id=$id"
    ,'Редактировать Доп. Оборудов.' => "index.php?f=18&id=$id"
  );
  ActionBlock($info);
}

// кнопки списка действий доп. информации
$info=array (
  'История Изменений' => "index.php?f=16&cat=bts&id=$id"
);
AdInfoBlock($info);

// вывод элементов интерфейса
echo "<div>";
echo "  <div id='info_left_indent'>";  
InfoBlock('bts_info_block',$info=array($info1));
InfoBlock('bts_info_block',$info=array($info2),'2G',$table1);
InfoBlock('bts_info_block',$info=array($info3),'3G',$table2);
InfoBlock('bts_info_block',$info=array($info7),'4G',$table7);
InfoBlock('bts_info_block',$info=array($info4),'питание');
InfoBlock('bts_info_block',$info=array($info5));
InfoBlock('bts_info_block',$info=array(),'доп. оборудование',$table6);
echo "  </div>";
echo "  <div id='info_right_indent'>"; 
InfoBlock('bts_ad_info_block',$info=array(),'сектора 2G',$table3);
InfoBlock('bts_ad_info_block',$info=array(),'сектора 3G UMTS 2100',$table4);
InfoBlock('bts_ad_info_block',$info=array(),'сектора 3G UMTS 900',$table8);
InfoBlock('bts_ad_info_block',$info=array(),'сектора 4G LTE 1800',$table9);
InfoBlock('bts_ad_info_block',$info=array($info6),'транспорт',$table5);
echo "  </div>";
echo "</div>";
?>