<?php
// входные параметры

// основной запрос
$sql = "SELECT * FROM tasks"; 
$sql.= $sort; 
$query=mysql_query($sql) or die(mysql_error());

// формируем элементы

// блок списка кнопок действий

// вывод элементов интерфейса

?>