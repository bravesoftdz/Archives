<?php
// ������� ���������

// �������� ������
$sql = "SELECT *";
$sql.= " FROM tasks";
$sql.= " WHERE id=".$_GET['id'];
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// ��������� ��������
  // ������ ������� � �����������
$link = (empty($row['file_link'])? "" : "<a href='".$row['file_link']."' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$info0 = array (
   '���� ���������� ����������' => $row['last_date']
  ,'������ �� ����' => $link
);

  // ���������

// ���� ������ ������ ��������

// ����� ��������� ����������
$action = "tasks/".$_GET['alias']."/process.php?alias=".$_GET['alias']."&id=".$_GET['id'];
echo "<form action='$action' method='post' id='task_params' enctype='multipart/form-data'>";
echo "<p><b>".$row['task_name']."</b></p><br>";

echo "<div id='info_left_indent'>"; 
echo "</p><p><input type='submit' value='���������'></p>";
echo "</form>";
echo "</div>";

echo "<div id='info_right_indent'>"; 
InfoBlock('bts_ad_info_block',$info=array($info0));
echo "</div>";
?>