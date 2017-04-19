<?php
// ������� ���������
$id=$_GET['id'];

// �������� ������
$sql="     SELECT ";
$sql=$sql."technology_generation ";
$sql=$sql.",budget_type_2g ";
$sql=$sql.",budget_number_2g ";
$sql=$sql.",budget_source_2g ";
$sql=$sql.",budget_type_3g ";
$sql=$sql.",budget_number_3g ";
$sql=$sql.",budget_source_3g ";
$sql=$sql.",existing_object ";
$sql=$sql.",bts.bts_number ";
$sql=$sql.",bts_demon.bts_number as demon_number ";
$sql=$sql.",outside_id ";
$sql=$sql.",budget.site_type ";
$sql=$sql.",budget.cooperative ";
$sql=$sql.",budget_year ";
$sql=$sql.",budget_month ";
$sql=$sql.",construction_2g_types.construction_type as constract_2g ";
$sql=$sql.",construction_3g_types.construction_type as constract_3g ";
$sql=$sql.",budget.model_type_2g ";
$sql=$sql.",budget.model_type_3g ";
$sql=$sql.",gsm_config ";
$sql=$sql.",dcs_config ";
$sql=$sql.",umts_config ";
$sql=$sql.",transport_type ";
$sql=$sql.",transport_technology ";
$sql=$sql.",bsc_number ";
$sql=$sql.",rnc_number ";
$sql=$sql.",budget.lac_2g ";
$sql=$sql.",budget.lac_3g ";
$sql=$sql.",equipment_delivered ";
$sql=$sql.",budget.notes ";
$sql=$sql.",settlement ";
$sql=$sql.",settlements.type ";
$sql=$sql.",area ";
$sql=$sql.",region ";
$sql=$sql.",p1.street_type ";
$sql=$sql.",p1.street_name ";
$sql=$sql.",p1.house_type ";
$sql=$sql.",p1.house_number ";
$sql=$sql.",formulars.id as formular_id ";
$sql=$sql."FROM budget ";
$sql=$sql."LEFT JOIN (SELECT * FROM budget_addresses WHERE budget_id=".NumOrNull($id)." ORDER BY id DESC LIMIT 1) p1 ";
$sql=$sql."ON budget.id=p1.budget_id ";
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
$sql=$sql."LEFT JOIN settlements ";
$sql=$sql."ON settlements.id=settlement_id ";
$sql=$sql."LEFT JOIN areas ";
$sql=$sql."ON areas.id=area_id ";
$sql=$sql."LEFT JOIN regions ";
$sql=$sql."ON regions.id=region_id ";
$sql=$sql."LEFT JOIN bts ";
$sql=$sql."ON bts.id=bts_id ";
$sql=$sql."LEFT JOIN bsc ";
$sql=$sql."ON bsc.id=budget.bsc_id ";
$sql=$sql."LEFT JOIN rnc ";
$sql=$sql."ON rnc.id=budget.rnc_id ";
$sql=$sql."LEFT JOIN bts bts_demon ";
$sql=$sql."ON bts_demon.id=demontation_bts_id ";
$sql=$sql."LEFT JOIN formulars ";
$sql=$sql."ON budget.id=formulars.budget_id ";
$sql=$sql."WHERE budget.id=".NumOrNull($id);
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// ���� ������ ������ ��������
if ($bg == 'w') {
  $info=array (
     '������������� ������ �������' => "index.php?f=13&id=$id"
  );
  ActionBlock($info);
}

// ������ ������ �������� ���. ����������
$info=array (
  '������� ���������' => "index.php?f=16&cat=budget&id=$id"
);
AdInfoBlock($info);

if (isset($fm) && !empty($row['formular_id'])) {
  $info=array (
    '��������' => "index.php?f=20&id=".$row['formular_id']
  );
  AdInfoBlock($info);
}
  
// ����� ��������� ���������� 
echo "<div>";
echo "<div id='info_left_indent'>";  

if (strlen($row['budget_type_2g'])>0) {$budget_number_2g=$row['budget_type_2g'].'_'.$row['budget_number_2g'];}
if (strlen($row['budget_type_3g'])>0) {$budget_number_3g=$row['budget_type_3g'].'_'.$row['budget_number_3g'];}
if ($row['existing_object']==1) $existing_object='��';
$info1=array (
 '���'=>$row['technology_generation']
,'����� ������� 2g'=>$budget_number_2g
,'�������� 2g'=>$row['budget_source_2g']
,'����� ������� 3g'=>$budget_number_3g
,'�������� 3g'=>$row['budget_source_3g']
);
$info2=array (
 '��������� �� ������������ ������'=>$existing_object
,'����� ��'=>$row['bts_number']
,'����� ������������� ��'=>$row['demon_number']
,'������� id'=>$row['outside_id']
);
$info3=array (
 '���'=>$row['budget_year']
,'�����'=>$row['budget_month']
);
$info4=array (
 '��� ��������'=>$row['site_type']
,'�����'=>FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])
,'����������'=>$row['cooperative']
);
InfoBlock('bts_info_block',$info=array($info1,$info2,$info3,$info4));

$info1=array(
 '��� ������������������ 2g'=>$row['constract_2g']
,'������ 2g'=>$row['model_type_2g']
,'������������ gsm'=>$row['gsm_config']
,'������������ dcs'=>$row['dcs_config']
);
$info2=array(
 '��� ������������������ 3g'=>$row['constract_3g']
,'������ 3g'=>$row['model_type_3g']
,'������������ umts'=>$row['umts_config']
);
InfoBlock('bts_info_block',$info=array($info1,$info2));

$info1=array(
 '��� ����������'=>$row['transport_type']
,'���������� ����������'=>$row['transport_technology']
);
$info2=array(
 '����������� BSC'=>$row['bsc_number']
,'����������� LAC 2g'=>$row['lac_2g']
);
$info3=array(
 '����������� RNC'=>$row['rnc_number']
,'����������� LAC 3g'=>$row['lac_3g']
);
InfoBlock('bts_info_block',$info=array($info1,$info2,$info3));

if ($row['equipment_delivered']==1) {$equipment_delivered='���������';}
$info1=array(
 '������ ������������'=>$equipment_delivered
,'����������'=>$row['notes']
);
InfoBlock('bts_info_block',$info=array($info1));

echo "</div>";
echo "<div id='info_right_indent'>";

// ���. ������ ������ - ������, ����� ������������
$sql="SELECT * FROM budget_addresses LEFT JOIN settlements ON budget_addresses.settlement_id=settlements.id LEFT JOIN areas ON settlements.area_id=areas.id LEFT JOIN regions ON areas.region_id=regions.id WHERE budget_id=".NumOrNull($id)." AND doc_link IS NOT NULL ORDER BY budget_addresses.id DESC";
$query=mysql_query($sql) or die(mysql_error());
array_splice ($info,0);
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  $link=(empty($row['doc_link'])? "" : "<a href='".$row['doc_link']."' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
  $info1=array(
   '����� ����� ������������'=>FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])
  ,'����'=>$row['doc_date']
  ,''=>$link
  );
  $info[]=$info1;
}
InfoBlock('bts_ad_info_block',$info);

echo "</div>";
echo "</div>";
?> 