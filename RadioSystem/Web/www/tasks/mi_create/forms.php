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
if (!isset($_GET['step'])) {  // ��� 1
  $info[] = array (
     'el_type' => 'file'
    ,'field' => '����'
    ,'id' => 'select_field'
    ,'name' => 'input_file'
    ,'required' => true
    ,'show_field' => true
  );
  $list = array (
     array ('value'=>'', 'display'=>'')
    ,array ('value'=>'point', 'display'=>'�����')
    ,array ('value'=>'line', 'display'=>'�����')
  );
  $info[] = array (
     'field' => '��� ����'
    ,'value' => ''
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'layer_type'
    ,'list' => $list
    ,'required' => true
    ,'show_field' => true
  );
  $action = "index.php?f=29&alias=".$_GET['alias']."&id=".$_GET['id']."&step=2";  
}

if ($_GET['step']==2) {  // ��� 2
  if (!empty($_FILES['input_file']['tmp_name']) ) { // ���������� ����
    $uploaddir = 'files/temp/';
    $uploadfile = $uploaddir.uniqid().".csv";
    move_uploaded_file($_FILES['input_file']['tmp_name'], $uploadfile);
    $_SESSION['file']['input_file']['tmp_name'] = $uploadfile;
    
    if (($handle = fopen($_SESSION['file']['input_file']['tmp_name'], "r")) !== FALSE) {
      $i = 0; $j = 0;
      while (($csv_row = fgetcsv($handle, 0, ";")) !== FALSE) {
        $i++; 
        if ($i>1) break;
        foreach ($csv_row as $key => $value) {
          if ($j>16) break;
          $info[] = array (
             'field' => '���� csv'
            ,'el_type' => 'text'
            ,'value' => $value
            ,'id' => 'text_field_medium'
            ,'name' => 'field_'.$key
            ,'disabled' => true
            ,'start_line' => true
          );
          $list = array (
             array ('value'=>'', 'display'=>'')
            ,array ('value'=>'bts', 'display'=>'����� ��')
            ,array ('value'=>'geo', 'display'=>'����������')
          );
          $info[] = array (
             'el_type' => 'select'
            ,'id' => 'select_field_medium'
            ,'name' => 'geo_'.$key
            ,'end_line' => true
            ,'list' => $list
          );
          $j++;
        }
      }
    }
    $_SESSION['col_count'] = $j;
    fclose($handle);
  }
  $action = "tasks/".$_GET['alias']."/process.php?alias=".$_GET['alias']."&id=".$_GET['id'];
  if ($_POST['layer_type'] == 'point') {$_SESSION['layer_type'] = 'point';} else {$_SESSION['layer_type'] = 'line';}
}
// ���� ������ ������ ��������

// ����� ��������� ����������
echo "<form action='$action' method='post' id='task_params' enctype='multipart/form-data'>";
echo "<p><b>".$row['task_name']."</b></p><br>";

echo "<div id='info_left_indent'>"; 
echo "��������� ���������:<p>";
if ($_GET['step']==2) echo "���� ����������� ����������, �� ������ �������� ������ ���� �������";
foreach ($info as $key => $value) {
  FieldEdit($value);
  echo "<br>";
}
echo "</p><p><input type='submit' value='���������'></p>";
echo "</form>";
echo "</div>";

echo "<div id='info_right_indent'>"; 
InfoBlock('bts_ad_info_block',$info=array($info0));
echo "</div>";
?>