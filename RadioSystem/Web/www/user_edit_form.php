<?php
// ������� ���������
$id=$_GET['id'];

// �������� ������
$sql = "SELECT";
$sql.= " *";
$sql.= " FROM users";
$sql.= " WHERE id=$id";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

$sql = "SELECT";
$sql.= " Id";
$sql.= ",object_access";
$sql.= ",access_type";
$sql.= " FROM users_access";
$sql.= " WHERE user_id=$id";
$query2 = mysql_query($sql) or die(mysql_error());

// ��������� ��������
$info[] = $info1 = array (
   'field' => '���'
  ,'value' => PrvFill('name',$row['name'])
  ,'el_type' => 'text'
  ,'id' => 'select_field'
  ,'name' => 'name'
);
$info[] = $info1 = array (
   'field' => '��������'
  ,'value' => PrvFill('middle_name',$row['middle_name'])
  ,'el_type' => 'text'
  ,'id' => 'select_field'
  ,'name' => 'middle_name'
);
$info[] = $info1 = array (
   'field' => '�������'
  ,'value' => PrvFill('surname',$row['surname'])
  ,'el_type' => 'text'
  ,'id' => 'select_field'
  ,'name' => 'surname'
  ,'required' => true
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$info[] = $info1 = array (
   'field' => '�����'
  ,'value' => PrvFill('login',$row['login'])
  ,'el_type' => 'text'
  ,'id' => 'select_field_medium'
  ,'name' => 'login'
  ,'required' => true
);
$info[] = $info1 = array (
   'field' => '������'
  ,'value' => PrvFill('password',$row['password'])
  ,'el_type' => 'text'
  ,'id' => 'select_field_medium'
  ,'name' => 'password'
  ,'required' => true
);
$info[] = $info1 = array (
  'el_type' => 'break'
);
$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'�����', 'display'=>'�����')
 ,array ('value'=>'������', 'display'=>'������')
 ,array ('value'=>'����', 'display'=>'����')
 ,array ('value'=>'����', 'display'=>'����')
);
$info[] = $info1 = array (
   'field' => '�������������'
  ,'value' => PrvFill('department',$row['department'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'department'
  ,'list' => $list
);
$list = array (
  array ('value'=>'', 'display'=>'')
 ,array ('value'=>'������ ���', 'display'=>'������ ���')
 ,array ('value'=>'������ ������������', 'display'=>'������ ������������')
 ,array ('value'=>'������������', 'display'=>'������������')
 ,array ('value'=>'�������', 'display'=>'�������')
 ,array ('value'=>'������ ���', 'display'=>'������ ���')
 ,array ('value'=>'������ ���������', 'display'=>'������ ���������')
 ,array ('value'=>'������� ���������� ������', 'display'=>'������� ���������� ������')
 ,array ('value'=>'������� ����� ����� � ������������', 'display'=>'������� ����� ����� � ������������')
);
$info[] = $info1 = array (
   'field' => '�����������'
  ,'value' => PrvFill('function',$row['function'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'function'
  ,'list' => $list
);
// ���� ������ ������ ��������

// ����� ��������� ����������
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='user_edit.php?id=$id' method='post' id='user_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>���������</button></p>";
echo "</div>";
echo "<div id='add_indent'>";
echo "<table id='additional_table'>";
echo "<tr>";
echo "<td id='ad_td' style='text-align:center;'>������</td>";
echo "<td id='ad_td' style='text-align:center;'>������</td>";
echo "<td id='ad_td' style='text-align:center;'>������</td>";
echo "</tr>";

$s=0;
if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'formular managment') {$find = true; break;} else {$find = false;}
}
echo "<tr>";
echo "<td id='ad_td'>�������� ����������<input type='text' value='formular managment' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";

if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'bts managment') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>�������� ������� �������<input type='text' value='bts managment' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";

///////////////// �������� ���������
if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'repeater managment') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>�������� ���������<input type='text' value='repeater managment' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";
////////////////////////////////////////////////////////////////////////////////
if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'budget') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>������<input type='text' value='budget' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";
////////////////////////////////////////////////////////////////////////////////
if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'switches') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>�������� ���������<input type='text' value='switches' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";
////////////////////////////////////////////////////////////////////////////////
if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'statistics') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>����������<input type='text' value='statistics' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='r'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";

if (mysql_num_rows($query2)>0) mysql_data_seek($query2,0);
for ($i=0; $i<mysql_num_rows($query2); $i++) {
  $row2 = mysql_fetch_array($query2); 
  if ($row2[1] == 'administration') {$find = true; break;} else {$find = false;}
}
$s++;
echo "<tr>";
echo "<td id='ad_td'>�������������<input type='text' value='administration' name='object_access_$s' hidden></td>";
if ($row2[2] == 'r' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'></td>";
if ($row2[2] == 'w' && ($find)) {$checked = 'checked';} else {$checked = '';}
echo "<td id='ad_td' style='text-align:center;'><input type='checkbox' $checked name='access_type_$s' value='w'><input type='text' value='".(($find)? $row2[0] : '')."' hidden name='Id_$s'></td>";
echo "</tr>";

echo "</table>";
echo "</div>";
echo "</form>";

?>