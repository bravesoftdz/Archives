<?php
// ������� ���������

// �������� ������
$sql = "SELECT * FROM tasks"; 
$sql.= $sort; 
$query=mysql_query($sql) or die(mysql_error());

// ��������� ��������

// ���� ������ ������ ��������

// ����� ��������� ����������

?>