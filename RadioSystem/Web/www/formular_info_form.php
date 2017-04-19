<?php
// ������� ���������
$id=$_GET['id'];
$function = $_SESSION['function'];
$department = $_SESSION['department'];

// �������� ������
$sql = "SELECT";
$sql.= " formulars.bts_id";
$sql.= ",repeater_id";
$sql.= ",repeater_number";
$sql.= ",users.surname";
$sql.= ",users.name";
$sql.= ",users.middle_name";
$sql.= ",projector_user_id";
$sql.= ",agreement_persons.name as agreement_person";
$sql.= ",build_persons.name as build_person";
$sql.= ",project_organizations.title as project_organization";
$sql.= ",build_organizations.title as build_organization";
$sql.= ",create_date";
$sql.= ",inspect_date";
$sql.= ",form_1bs_link";
$sql.= ",agreem_link";
$sql.= ",form_rrl_link";
$sql.= ",formulars.notes";
$sql.= ",formulars.type as formular_type";
$sql.= ",bts.site_type";
$sql.= ",bts_number";
$sql.= ",settlements.type";
$sql.= ",settlements.settlement";
$sql.= ",areas.area";
$sql.= ",regions.region";
$sql.= ",bts.street_type";
$sql.= ",bts.street_name";
$sql.= ",bts.house_type";
$sql.= ",bts.house_number";
$sql.= ",rsettlements.type rtype";
$sql.= ",rsettlements.settlement rsettlement";
$sql.= ",rareas.area rarea";
$sql.= ",rregions.region rregion";
$sql.= ",repeaters.street_type rstreet_type";
$sql.= ",repeaters.street_name rstreet_name";
$sql.= ",repeaters.house_type rhouse_type";
$sql.= ",repeaters.house_number rhouse_number";
$sql.= ",b_settlements.type as b_type";
$sql.= ",b_settlements.settlement as b_settlement";
$sql.= ",b_areas.area as b_area";
$sql.= ",b_regions.region as b_region";
$sql.= ",budget.budget_year";
$sql.= ",budget_addresses.street_type as b_street_type";
$sql.= ",budget_addresses.street_name as b_street_name";
$sql.= ",budget_addresses.house_type as b_house_type";
$sql.= ",budget_addresses.house_number as b_house_number";

$sql.= ",CASE WHEN budget_type_2g is not NULL AND budget_type_3g is NULL THEN CONCAT('2g ',budget_type_2g) "; 
$sql.= "      WHEN budget_type_3g is not NULL AND budget_type_2g is NULL THEN CONCAT('3g ',budget_type_3g) ";
$sql.="       WHEN budget_type_2g is not NULL AND budget_type_3g is not NULL THEN CONCAT('2g ',budget_type_2g,'<br>','3g ',budget_type_3g) "; 
$sql.=" END as budget_type";

$sql.=",CASE WHEN budget_source_2g is not NULL AND budget_source_3g is NULL THEN budget_source_2g "; 
$sql.="      WHEN budget_source_3g is not NULL AND budget_source_2g is NULL THEN budget_source_3g ";
$sql.="      WHEN budget_source_2g is not NULL AND budget_source_3g is not NULL THEN CONCAT(budget_source_2g,'<br>',budget_source_3g) "; 
$sql.=" END as budget_source "; 
 
$sql.= ",to_lotus_date";
$sql.= ",signed_date";
$sql.= ",outside_id";
$sql.= ",fud_user_id";
$sql.= ",fud_lotus_link";
$sql.= " FROM formulars";
$sql.= " LEFT JOIN users";
$sql.= " ON formulars.projector_user_id=users.id";
$sql.= " LEFT JOIN agreement_persons";
$sql.= " ON formulars.agreem_person_id=agreement_persons.id";
$sql.= " LEFT JOIN build_persons";
$sql.= " ON formulars.build_person_id=build_persons.id";
$sql.= " LEFT JOIN project_organizations";
$sql.= " ON formulars.project_organization_id=project_organizations.id";
$sql.= " LEFT JOIN build_organizations";
$sql.= " ON formulars.build_organization_id=build_organizations.id";
$sql.= " LEFT JOIN bts";
$sql.= " ON formulars.bts_id=bts.id";
$sql.= " LEFT JOIN settlements";
$sql.= " ON bts.settlement_id=settlements.id";
$sql.= " LEFT JOIN areas";
$sql.= " ON settlements.area_id=areas.id";
$sql.= " LEFT JOIN regions";
$sql.= " ON areas.region_id=regions.id";
$sql.= " LEFT JOIN budget";
$sql.= " ON formulars.budget_id=budget.id";
$sql.= " LEFT JOIN budget_addresses";
$sql.= " ON budget_addresses.id=(SELECT Id FROM budget_addresses WHERE budget_id=budget.id ORDER BY -Id LIMIT 1)";
$sql.= " LEFT JOIN settlements b_settlements";
$sql.= " ON budget_addresses.settlement_id=b_settlements.id";
$sql.= " LEFT JOIN areas b_areas";
$sql.= " ON b_settlements.area_id=b_areas.id";
$sql.= " LEFT JOIN regions b_regions";
$sql.= " ON b_areas.region_id=b_regions.id";
$sql.= " LEFT JOIN repeaters";
$sql.= " ON formulars.repeater_id=repeaters.id";
$sql.= " LEFT JOIN settlements rsettlements";
$sql.= " ON repeaters.settlement_id=rsettlements.id";
$sql.= " LEFT JOIN areas rareas";
$sql.= " ON rsettlements.area_id=rareas.id";
$sql.= " LEFT JOIN regions rregions";
$sql.= " ON rareas.region_id=rregions.id";

$sql.= " WHERE formulars.id=$id";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 
$bts_id = $row['bts_id'];
$repeater_id = $row['repeater_id'];
$bts_number = $row['bts_number'];
$projector_user_id = $row['projector_user_id'];
$fud_user_id = $row['fud_user_id'];
$to_lotus_date = $row['to_lotus_date'];
$outside_id = $row['outside_id'];

// ��������� ��������
$info1 = array (
   '������������� �� ��������������' => NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
  ,'������������� �� ���������� ��������' => $row['agreement_person']
  ,'������������� �� �������������' => $row['build_person']
);
$info2 = array (
   '��������� �����������' => $row['project_organization']
  ,'������������ �����������' => $row['build_organization']
);
$info3 = array (
   '���� ������������' => $row['inspect_date']
  ,'���� �������� ���' => $row['create_date']
  ,'���� ������� ���' => $row['to_lotus_date']
  ,'���� ������� ���' => $row['signed_date']
);
$info4 = array (
   '����������' => $row['notes']
);
$link1=(empty($row['form_1bs_link'])? "" : "<a href='".$row['form_1bs_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link2=(empty($row['agreem_link'])? "" : "<a href='".$row['agreem_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link3=(empty($row['form_rrl_link'])? "" : "<a href='".$row['form_rrl_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link4=(empty($row['fud_lotus_link'])? "" : "<a href='".$row['fud_lotus_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$info5 = array (
   '�������� ����� "1��"' => $link1
  ,'�������� ���� ������������' => $link2
  ,'�������� ����� ���' => $link3
);
$info11 = array (
   '�������� ���' => $link4
);
$info6 = array (
   '��� ���' => $row['formular_type']
  ,'ID �������' => $outside_id
  ,'��� �������' => $row['budget_year']
  ,'��� �������' => $row['budget_type']
  ,'��������' => $row['budget_source']
  ,'����� �������' => FormatAddress($row['b_type'],$row['b_settlement'],$row['b_street_type'],$row['b_street_name'],$row['b_house_type'],$row['b_house_number'],$row['b_area'],$row['b_region'])
);
if (!empty($row['bts_id'])) {
  $info12 = array (
    $row['site_type'] => $row['bts_number']
    ,'�����' => FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])
  );
}
if (!empty($row['repeater_id'])) {
  $info12 = array (
     '�������' => $row['repeater_number']
    ,'�����' => FormatAddress($row['rtype'],$row['rsettlement'],$row['rstreet_type'],$row['rstreet_name'],$row['rhouse_type'],$row['rhouse_number'],$row['rarea'],$row['rregion'])   
  );
}

// ���. ������
$sql = "SELECT";
$sql.= " action_date";
$sql.= ",action_time";
$sql.= ",action";
$sql.= ",formular_actions.department";
$sql.= ",notes";
$sql.= ",name";
$sql.= ",surname";
$sql.= ",middle_name";
$sql.= " FROM formular_actions";
$sql.= " LEFT JOIN users";
$sql.= " ON formular_actions.user_id=users.id";
$sql.= " WHERE formular_id=$id AND formular_actions.department='�����'";
$sql.= " ORDER BY formular_actions.Id";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  
  switch ($row['action']) {
    case 'sign': $action = '���������'; $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
      break;
    case 'decline': $action = '���������'; $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
      break;  
    case 'accept': $action = '�����������'; $icon = "<img src='pics/accept_pic.png' width='16' height='16'>";
      break;  
    case 'fixed': $action = '����������'; $icon = "<img src='pics/fixed_pic.png' width='16' height='16'>";
      break; 
    case 'skip': $action = '���������'; $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
      break;
    default: $action = '';     
    }
    
  $info = array(
     '����' => $row['action_date'].' '.$row['action_time']
    ,'��������' => $icon.' '.$row['department'].' '.$action.' '.NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
    ,'����������' => $row['notes']
  );
  
  $info7[] = $info;
  $d1_action = $action;
}

$sql = "SELECT";
$sql.= " action_date";
$sql.= ",action_time";
$sql.= ",action";
$sql.= ",formular_actions.department";
$sql.= ",notes";
$sql.= ",name";
$sql.= ",surname";
$sql.= ",middle_name";
$sql.= ",user_id";
$sql.= " FROM formular_actions";
$sql.= " LEFT JOIN users";
$sql.= " ON formular_actions.user_id=users.id";
$sql.= " WHERE formular_id=$id AND formular_actions.department='������'";
$sql.= " ORDER BY formular_actions.Id";    
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  
  switch ($row['action']) {
    case 'sign': $action = '���������'; $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
      break;
    case 'decline': $action = '���������'; $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
      break;  
    case 'accept': $action = '�����������'; $icon = "<img src='pics/accept_pic.png' width='16' height='16'>";
      break;  
    case 'fixed': $action = '����������'; $icon = "<img src='pics/fixed_pic.png' width='16' height='16'>";
      break;
    case 'skip': $action = '���������'; $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
      break;  
    default: $action = '';      
  }
    
  $info = array(
     '����' => $row['action_date'].' '.$row['action_time']
    ,'��������' => $icon.' '.$row['department'].' '.$action.' '.NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
    ,'����������' => $row['notes']
  );
  
  $info8[] = $info;
  $d2_action = $action;
  
  if ($user_id == $row['user_id'] && $action == '�����������') $accept_by_me = true;
  $d2_user_id = $row['user_id'];
  $d2[$row['user_id']][] = $action;
  
}
$sql = "SELECT";
$sql.= " action_date";
$sql.= ",action_time";
$sql.= ",action";
$sql.= ",formular_actions.department";
$sql.= ",notes";
$sql.= ",name";
$sql.= ",surname";
$sql.= ",middle_name";
$sql.= " FROM formular_actions";
$sql.= " LEFT JOIN users";
$sql.= " ON formular_actions.user_id=users.id";
$sql.= " WHERE formular_id=$id AND formular_actions.department='����'";
$sql.= " ORDER BY formular_actions.Id";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  
  switch ($row['action']) {
    case 'sign': $action = '���������'; $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
      break;
    case 'decline': $action = '���������'; $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
      break;  
    case 'accept': $action = '�����������'; $icon = "<img src='pics/accept_pic.png' width='16' height='16'>";
      break;  
    case 'fixed': $action = '����������'; $icon = "<img src='pics/fixed_pic.png' width='16' height='16'>";
      break; 
    case 'skip': $action = '���������'; $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
      break;   
    default: $action = '';    
    }
    
  $info = array(
     '����' => $row['action_date'].' '.$row['action_time']
    ,'��������' => $icon.' '.$row['department'].' '.$action.' '.NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
    ,'����������' => $row['notes']
  );
  
  $info9[] = $info;
  $d3_action = $action;
}
$sql = "SELECT";
$sql.= " action_date";
$sql.= ",action_time";
$sql.= ",action";
$sql.= ",formular_actions.department";
$sql.= ",notes";
$sql.= ",name";
$sql.= ",surname";
$sql.= ",middle_name";
$sql.= " FROM formular_actions";
$sql.= " LEFT JOIN users";
$sql.= " ON formular_actions.user_id=users.id";
$sql.= " WHERE formular_id=$id AND formular_actions.department='����'";
$sql.= " ORDER BY formular_actions.Id";
$query = mysql_query($sql) or die(mysql_error());
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  
  switch ($row['action']) {
    case 'sign': $action = '���������'; $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
      break;
    case 'decline': $action = '���������'; $icon = "<img src='pics/decline_pic.png' width='16' height='16'>";
      break;  
    case 'accept': $action = '�����������'; $icon = "<img src='pics/accept_pic.png' width='16' height='16'>";
      break;  
    case 'fixed': $action = '����������'; $icon = "<img src='pics/fixed_pic.png' width='16' height='16'>";
      break; 
    case 'skip': $action = '���������'; $icon = "<img src='pics/skip_pic.jpg' width='16' height='16'>";
      break;   
    case 'lotus': $action = '������� � Lotus'; $icon = "<img src='pics/signed_pic.png' width='16' height='16'>";
      break;    
    default: $action = '';     
    }
    
  $info = array(
     '����' => $row['action_date'].' '.$row['action_time']
    ,'��������' => $icon.' '.$row['department'].' '.$action.' '.NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
    ,'����������' => $row['notes']
  );
  
  $info10[] = $info;
  $d4_action = $action;
}

// ���� ������ ������ ��������
if ($fm == 'w' && ($projector_user_id == $user_id || $fud_user_id == $user_id) ) {
  $info=array (
     '������������� ������ ���' => "index.php?f=19&id=$id"
  );
  ActionBlock($info);
}

// ������ ������������
if ($function == '�������') {
  if ($department == '�����') {
    if (empty($d1_action)) $display_sign = true;
  }
  if ($department == '������') {
    if ($d2_action == '�����������') $display_sign = true;
  }
  if ($department == '����') {
    if ($d3_action == '�����������') $display_sign = true;
  }
  if ($department == '����') {
    if ($d4_action == '�����������') $display_sign = true;
  }
}
//////////////////////////////////////////////////////////////////////
if ($function == '������������' || $function == '�������') {
  if ($department == '������' && $function == '������������') {
    if (($d1_action=='���������' || $d1_action=='���������') && (!$accept_by_me)
       ) $display_areem = true;
  }
  if ($department == '����') {
    if ($d1_action=='���������'
          && (empty($d3_action) || $d3_action=='����������')
       ) $display_areem = true;
  }
  if ($department == '����') {
    if ( ($d1_action=='���������' || $d1_action=='���������') && ($d2_action=='���������' || $d2_action=='���������') &&  ($d3_action=='���������' || $d3_action=='���������') && (empty($d4_action) || $d4_action=='����������') && (!empty($bts_number) || !empty($repeater_id))) $display_areem = true;
  }
}
///////////////////////////////////////////////////////////////////////////////
if ($function == '������ ���' || $function == '������ ���������') {
  $flag = 0;
  if (isset($d2))
  foreach ($d2 as $key => $value) {
    if ($d2[$key][count($d2[$key])-1] == '���������') $flag = 1;     
  }

  if ($d1_action=='���������' || $flag == 1 || $d3_action=='���������' || $d4_action=='���������') $display_fixed= true;
}
//////////////////////////////////////////////////////////////////////////////
if ($function == '������ ���') {
  if (($d1_action=='���������' || $d1_action=='���������') && 
      ($d2_action=='���������' || $d2_action=='���������') &&  
      ($d3_action=='���������' || $d3_action=='���������') && empty($bts_number) && empty($repeater_id)) $display_number= true;
      
  if ($d4_action=='���������' && empty($to_lotus_date)) $display_lotus = true;  
  
  if ($d4_action=='���������') $display_fixed= true;  
}
//////////////////////////////////////////////////////////////////////////////
if ($display_sign) {
  $info=array (
     "��������� <img src='pics/signed_pic.png' width='18' height='18'>" => "index.php?f=23&id=$id&sign"
    ,"��������� <img src='pics/decline_pic.png' width='18' height='18'>" => "index.php?f=23&id=$id&decline"
  );
  ActionBlock($info);
}
if ($display_areem) {
  $info=array (
     "����������� <img src='pics/signed_pic.png' width='18' height='18'>" => "index.php?f=23&id=$id&accept"
    ,"��������� <img src='pics/decline_pic.png' width='18' height='18'>" => "index.php?f=23&id=$id&decline"
  );
  ActionBlock($info);
}
if ($display_fixed) {
  $info=array (
     "���������� <img src='pics/fixed_pic.png' width='18' height='18'>" => "index.php?f=23&id=$id&fixed"
  );
  ActionBlock($info);
}
if ($display_number) {
  $info=array (
     "��������� �����" => "index.php?f=4&ff=$section_index&id=$id&obj=bts_number"
  );
  ActionBlock($info);
}
if ($display_lotus) {
  $info=array (
     "��������� � Lotus" => "formular_to_word.php?id=$id"
  );
  ActionBlock($info);
}
if (!empty($outside_id) && isset($admin) ) {
  $info=array (
     "�������� ID �������" => "redirect.php?f=20&id=".$id."&oidremove"
  );
  ActionBlock($info);
}


// ������ ������ �������� ���. ����������
if ($bts_id>0) {
  $info=array (
     '������ ������� �������' => "redirect.php?f=17&id=".$bts_id
  );
}  
if ($repeater_id>0) {
  $info=array (
     '������ ��������' => "redirect.php?f=30&id=".$repeater_id
  );
} 
AdInfoBlock($info);

// ����� ��������� ����������
echo "<div>";
echo "  <div id='info_left_indent'>"; 
InfoBlock('bts_info_block',$info=array($info6,$info12)); 
InfoBlock('bts_info_block',$info=array($info1,$info2,$info3,$info4));
InfoBlock('bts_info_block',$info=array($info5,$info11));
echo "  </div>";
echo "  <div id='info_right_indent'>";  
InfoBlock('bts_ad_info_block',$info7);
InfoBlock('bts_ad_info_block',$info8);
InfoBlock('bts_ad_info_block',$info9);
InfoBlock('bts_ad_info_block',$info10);
echo "  </div>";
echo "</div>";
?>