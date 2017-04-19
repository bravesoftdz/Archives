<?php
// входные параметры
$id=$_GET['id'];

// основной запрос

// формируем элементы
$info[] = $info1 = array (
 'field' => 'Примечания'
,'value' => ''
,'el_type' => 'textarea'
,'id' => 'note_edit'
,'name' => 'notes'
,'show_field' => 'true'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<div id='left_indent'>";
if (isset($_GET['sign'])) {echo "<h2>Подписать</h2>"; $action='sign';}
if (isset($_GET['accept'])) {echo "<h2>Согласовать</h2>"; $action='accept';}
if (isset($_GET['decline'])) {echo "<h2>Отклонить</h2>"; $action='decline';}
if (isset($_GET['fixed'])) {echo "<h2>Исправлено</h2>"; $action='fixed';}

echo "<form action='formular_sign.php?id=$id&$action' method='post' id='bts_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>применить</button></p>";
echo "</form>";
echo "</div>";

?>