<?php
include_once('config.php');

if (isset($_POST['log']) && isset($_POST['pas']))
{
    $login = mysql_real_escape_string($_POST['log']);
    $password =$_POST['pas'];

    // делаем запрос к БД
    // и ищем юзера с таким логином и паролем

    $query = "SELECT id, name, middle_name, surname, login, function, department 
            FROM users
            WHERE login='{$login}' AND password='{$password}'
            LIMIT 1";
    $sql = mysql_query($query) or die(mysql_error());

    // если такой пользователь нашелся
    if (mysql_num_rows($sql) == 1) {
        // то мы ставим об этом метку в сессии (допустим мы будем ставить ID пользователя)

        $row = mysql_fetch_assoc($sql);
        $_SESSION['user_id'] = $row['id'];
        $_SESSION['user_name'] = $row['name'];
        $_SESSION['user_middle_name'] = $row['middle_name'];
        $_SESSION['user_surname'] = $row['surname'];
        $_SESSION['user_login'] = $row['login'];
        $_SESSION['function'] = $row['function'];
        $_SESSION['department'] = $row['department'];
        // не забываем, что для работы с сессионными данными, у нас в каждом скрипте должно присутствовать session_start();
    }
    
}
?>
<script>document.location.href="index.php"</script>