<?php
// входные параметры

// основной запрос
$sql = "SELECT *";
$sql.= " FROM task_access";
$sql.= " LEFT JOIN tasks";
$sql.= " ON task_access.task_id=tasks.id";
$sql.= " WHERE user_id=$user_id";
$query=mysql_query($sql) or die(mysql_error());

// формируем элементы
$info1=array (
 'ФИО' => NameFormat('full fio',$_SESSION['user_surname'],$_SESSION['user_name'],$_SESSION['user_middle_name'])
,'логин' => $_SESSION['user_login']
,'подразделение' => $_SESSION['department']
);

// блок списка кнопок действий
$info=array (
  'Редактировать Логин, Пароль' => "index.php?f=27"
);
ActionBlock($info);

// вывод элементов интерфейса
echo "<div>";

echo "<div id='info_left_indent'>"; 
InfoBlock('bts_info_block',$info=array($info1));
echo "</div>";

if (mysql_num_rows($query)>0) {
  echo "<div id='info_right_indent'>";  
  echo "<div style='margin-left:40px'><p><b>Персональные инструменты:</b>";
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<p><a href='index.php?f=29&alias=".$row['alias']."&id=".$row[3]."'>".$row['task_name']."</a></p>";
  }  
  echo "</p></div></div>";
}  

echo "</div>";
?>