<?php
// ������� ���������
$cat = $_GET['cat'];
$id = $_GET['id'];

// �������� ������
if ($cat == 'budget') {  // ������ �������
  $objects = array (
     'budget' => '������'
    ,'budget_addresses' => '����� �������'
  );
}

if ($cat == 'bts') {  // ������ ��
  $objects = array (
     'bts' => '��'
    ,'sectors' => '�������'
    ,'rrl' => '���'
    ,'hardware' => '���.������.'
  );
}

if ($cat == 'repeaters') {  // ������ �������
  $objects = array (
     'repeaters' => '�������'
    ,'repeater_sectors' => '������� ��������'
  );
}

foreach ($objects as $key => $value) {
  $fields[] = '"'.$key.'"';
}
$sql = "SELECT ";
$sql.= " act_date";
$sql.= ",act_time";
$sql.= ",surname";
$sql.= ",name";
$sql.= ",middle_name";
$sql.= ",action";
$sql.= ",changes";
$sql.= ",table_name";
$sql.= " FROM history"; 
$sql.= " LEFT JOIN users";
$sql.= " ON history.user_id=users.id";
$sql.= " WHERE table_name IN (".implode(',',$fields).") AND object_id=$id ORDER BY history.id DESC";

$query=mysql_query($sql) or die(mysql_error());

// ����� ��������� ����������
echo "<div id='main_content'>";
echo "<table id='additional_table'>";   // ������� �������
echo "<tr>";
echo "<td id='ad_td' style='text-align:center;'>����</td>";
echo "<td id='ad_td' style='text-align:center;'>�����</td>";
echo "<td id='ad_td' style='text-align:center;'>�������.</td>";
echo "<td id='ad_td' style='text-align:center;'>������</td>";
echo "<td id='ad_td' style='text-align:center;'>��������</td>";
echo "<td id='ad_td' style='text-align:center;'>���������</td>";
echo "</tr>";

for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row = mysql_fetch_array($query);
  echo "<tr>";
  echo "<td id='ad_td'>".$row['act_date']."</td>";
  echo "<td id='ad_td'>".$row['act_time']."</td>";
  $user = $row['surname']." ".(!empty($row['name'])? substr($row['name'],0,1).'.' : '').(!empty($row['middle_name'])? substr($row['middle_name'],0,1).'.' : '');
  echo "<td id='ad_td'>$user</td>";
  $object = $objects[$row['table_name']];
  echo "<td id='ad_td'>$object</td>";
  if ($row['action'] == 'insert') $action = "��������� ������";
  if ($row['action'] == 'update') $action = "�������� ������";
  if ($row['action'] == 'delete') $action = "������� ������";
  echo "<td id='ad_td'>$action</td>";
  echo "<td id='ad_td'>";
  $changes = explode(';',$row['changes']);
  for ($j=0; $j<count($changes); $j++) {
    echo trim($changes[$j]);
    if ($j+1 < count($changes) ) echo"<br>";
  }
  echo "</td>";
  echo "</tr>";
}

echo "</table>";
echo "</div>";
?> 