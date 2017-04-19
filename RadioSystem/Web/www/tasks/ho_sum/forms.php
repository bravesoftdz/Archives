<?php
// входные параметры

// основной запрос
$sql = "SELECT *";
$sql.= " FROM tasks";
$sql.= " WHERE id=".$_GET['id'];
$query=mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// формируем элементы
$link=(empty($row['file_link'])? "" : "<a href='".$row['file_link']."' title='скачать' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>" );
$info0=array (
   'дата последнего выполнения' => $row['last_date']
  ,'ссылка на файл' => $link
);

$info[] = $info1 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file1'
  ,'required' => true
);
$info[] = $info2 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file2'
);
$info[] = $info3 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file3'
);  
$info[] = $info3 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file4'
);  
$info[] = $info3 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file5'
);  
$info[] = $info3 = array (
  'el_type' => 'file'
  ,'id' => 'select_field'
  ,'name' => 'input_file6'
);  
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'2g', 'display'=>'2G файлы NSN_HO_BC...')
  ,array ('value'=>'3g', 'display'=>'3G файлы HO Ajustments...')
);
$info[] = array (
  'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'file_type'
  ,'required' => true 
  ,'list' => $list
);
// блок списка кнопок действий

// вывод элементов интерфейса
echo "<form action='tasks/".$_GET['alias']."/process.php?alias=".$_GET['alias']."&id=".$_GET['id']."' method='post' id='task_params' enctype='multipart/form-data'>";
echo "<p><b>".$row['task_name']."</b></p><br>";

echo "<div id='info_left_indent'>"; 
echo "заполните параметры:&nbsp;&nbsp;&nbsp;<p>";
FieldEdit($info[6]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[0]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[1]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[2]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[3]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[4]);
echo "&nbsp;&nbsp;&nbsp;";
FieldEdit($info[5]);
echo "&nbsp;&nbsp;&nbsp;</p>";
echo "<p><input type='submit' value='выполнить'></p>";
echo "</form>";
echo "</div>";

echo "<div id='info_right_indent'>"; 
InfoBlock('bts_ad_info_block',$info=array($info0));
echo "</div>";
?>