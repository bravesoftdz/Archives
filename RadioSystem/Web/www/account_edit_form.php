<?php
// входные параметры

// основной запрос
$sql = "SELECT";
$sql.= " *";
$sql.= " FROM users";
$sql.= " WHERE id=$user_id";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

// формируем элементы
$info[] = $info1 = array (
   'field' => 'Логин'
  ,'value' => $row['login']
  ,'el_type' => 'text'
  ,'id' => 'select_field'
  ,'name' => 'login'
);
$info[] = $info1 = array (
   'field' => 'Пароль'
  ,'value' => $row['password']
  ,'el_type' => 'text'
  ,'id' => 'select_field'
  ,'name' => 'password'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "Логин и пароль будут действительны при следующей авторизации.";
echo "<div id='main_content'>";
echo "  <div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "  </div>";
echo "<form action='account_edit.php' method='post' id='account_edit_form'>";
echo "  <div id='right_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "  <p><button type='submit'>сохранить</button></p>";
echo "  </div>";
echo "</form";

echo "</div>";
?>