<?php
// ������� ���������
$id=$_GET['id'];

// �������� ������

// ��������� ��������
$info[] = $info1 = array (
 'field' => '����������'
,'value' => ''
,'el_type' => 'textarea'
,'id' => 'note_edit'
,'name' => 'notes'
,'show_field' => 'true'
);

// ���� ������ ������ ��������

// ����� ��������� ����������
echo "<div id='left_indent'>";
if (isset($_GET['sign'])) {echo "<h2>���������</h2>"; $action='sign';}
if (isset($_GET['accept'])) {echo "<h2>�����������</h2>"; $action='accept';}
if (isset($_GET['decline'])) {echo "<h2>���������</h2>"; $action='decline';}
if (isset($_GET['fixed'])) {echo "<h2>����������</h2>"; $action='fixed';}

echo "<form action='formular_sign.php?id=$id&$action' method='post' id='bts_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>���������</button></p>";
echo "</form>";
echo "</div>";

?>