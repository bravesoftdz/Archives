<?php
// ������� ���������
$id=$_GET['id'];

// �������� ������
$sql = "SELECT";
$sql.= " formulars.bts_id";
$sql.= ",users.surname";
$sql.= ",users.name";
$sql.= ",users.middle_name";
$sql.= ",projector_user_id";
$sql.= ",form_1bs_link";
$sql.= ",agreem_link";
$sql.= ",form_rrl_link";
$sql.= ",formulars.type as formular_type";
$sql.= ",bts.site_type";
$sql.= ",bts_number";
$sql.= ",settlements.type";
$sql.= ",settlement";
$sql.= ",area";
$sql.= ",region";
$sql.= ",street_type";
$sql.= ",street_name";
$sql.= ",house_type";
$sql.= ",house_number";
$sql.= ",fud_lotus_link";
$sql.= " FROM formulars";
$sql.= " LEFT JOIN users";
$sql.= " ON formulars.projector_user_id=users.id";
$sql.= " LEFT JOIN bts";
$sql.= " ON formulars.bts_id=bts.id";
$sql.= " LEFT JOIN settlements";
$sql.= " ON bts.settlement_id=settlements.id";
$sql.= " LEFT JOIN areas";
$sql.= " ON settlements.area_id=areas.id";
$sql.= " LEFT JOIN regions";
$sql.= " ON areas.region_id=regions.id";
$sql.= " WHERE formulars.id=$id";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);  

// ��������� ��������
$link1=(empty($row['form_1bs_link'])? "" : "<a href='".$row['form_1bs_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link2=(empty($row['agreem_link'])? "" : "<a href='".$row['agreem_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link3=(empty($row['form_rrl_link'])? "" : "<a href='".$row['form_rrl_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$link4=(empty($row['fud_lotus_link'])? "" : "<a href='".$row['fud_lotus_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );

$info1 = array (
   '�������� ���' => $link4
);
$info2 = array (
   '�������� ����� "1��"' => $link1
  ,'�������� ���� ������������' => $link2
  ,'�������� ����� ���' => $link3
);

$info4 = array (
   '��� ���' => $row['formular_type']
  ,$row['site_type'] => $row['bts_number']
  ,'�����' => FormatAddress($row['type'],$row['settlement'],$row['street_type'],$row['street_name'],$row['house_type'],$row['house_number'],$row['area'],$row['region'])
);

$info3 = array (
   '������������� �� ��������������' => NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])
);

// ���� ������ ������ ��������

// ����� ��������� ����������
InfoBlock('bts_info_block',$info=array($info4,$info3));
InfoBlock('bts_info_block',$info=array($info1,$info2));
echo "<form action='formular_lotus.php?id=$id' method='post' id='formular_lotus_form'>";
echo "<p><button type='submit'>�������� ��� ���������� � Lotus</button></p>";
echo "</form>";
?>