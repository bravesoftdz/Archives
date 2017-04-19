<?php session_start(); ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1251" />
        <title>БД Отдел развития радиоподсистемы</title>
        <link rel="stylesheet" href="styles.css">
            <script type="text/javascript" src="flot/jquery.js"></script>
            <script type="text/javascript" src="flot/jquery.flot.js"></script>
            <script type="text/javascript" src="flot/jquery.flot.time.js"></script>
            <script type="text/javascript" src="flot/jquery.flot.selection.js"></script>
            <script type="text/javascript" src="scripts.js"></script>
    </head>
    <body>

        <?php
        include_once('config.php');
        include_once('functions.php');
        include_once('interface.php');

        $user_id = $_SESSION['user_id'];
        if ($user_id > 0) {  // запрос на список прав пользователя
            $sql = "SELECT * FROM users_access WHERE user_id=$user_id";
            $query_access = mysql_query($sql) or die(mysql_error());
            for ($i = 0; $i < mysql_num_rows($query_access); $i++) {
                $row = mysql_fetch_array($query_access);
                if ($row['object_access'] == 'formular managment') {
                    $fm = $row['access_type'];
                }
                if ($row['object_access'] == 'bts managment') {
                    $bm = $row['access_type'];
                }
                if ($row['object_access'] == 'repeater managment') {
                    $rm = $row['access_type'];
                }
                if ($row['object_access'] == 'statistics') {
                    $st = $row['access_type'];
                }
                if ($row['object_access'] == 'budget') {
                    $bg = $row['access_type'];
                }
                if ($row['object_access'] == 'administration') {
                    $admin = $row['access_type'];
                }
                if ($row['object_access'] == 'switches') {
                    $sw = $row['access_type'];
                }
            }
        }

// ШАПКА  /////////////////////////////////////////////////
        echo "<div id='header'>";
        echo "<h1><img src='pics/logo2011.gif' align='center'> Отдел развития радиоподсистемы</h1>";
// блок отображения аутенфикации
        if ($user_id > 0) {
            echo "<div id='log_info'>" . $_SESSION['user_name'] . "<br>" . $_SESSION['user_middle_name'] . "<br>" . $_SESSION['user_surname'] . "<br><b>[" . $_SESSION['user_login'] . "]</b><br><a href='logout.php'>выйти</a></div>";
        }
        echo "</div>";
///////////////////////////////////////////////////////////
// ЛЕВОЕ ПОЛЕ МЕНЮ  ///////////////////////////////////////
        echo "<div id='sidebar'>";
        if (isset($user_id)) {
            if (isset($fm)) {
                echo "<a href='index.php?f=1' id='button'><div id='text_in_button_child'>Менеджер Формуляров</div></a>";
            }
            if (isset($bm)) {
                echo "<a href='index.php?f=2' id='button'><div id='text_in_button_child'>Менеджер Базовых Станции</div></a>";
            }
            if (isset($rm)) {
                echo "<a href='index.php?f=28' id='button'><div id='text_in_button_child'>Менеджер Репитеров</div></a>";
            }
            if (isset($bg)) {
                echo "<a href='index.php?f=11' id='button'><div id='text_in_button_child'>Бюджет</div></a>";
            }
            if (isset($sw)) {
                echo "<a href='index.php?f=34' id='button'><div id='text_in_button_child'>Менеджер Включений</div></a>";
            }
            if (isset($st)) {
                echo "<a href='index.php?f=10' id='button'><div id='text_in_button_child'>Статистика</div></a>";
            }
            if ($user_id > 0) {
                echo "<a href='index.php?f=26' id='button'><div id='text_in_button_child'>Кабинет Пользователя</div></a>";
            }
            if (isset($admin)) {
                echo "<a href='index.php?f=14' id='button'><div id='text_in_button_child'>Администратор</div></a>";
            }
        }
        echo "</div>";
///////////////////////////////////////////////////////////
// КОНТЕНТ  ///////////////////////////////////////////////  
        echo "<div id='content'>";

// блок ввода авторизации
        if ($user_id == 0) {
            include('login_form.php');
        }

// блок горизонтальной навигации по разделам
        if ($user_id > 0) {
            echo "<div id='navigation'><table border='0' cellpadding='0' cellspacing='0'><tr>";
            GetSection();
            for ($i = 0; $i < count($_SESSION['sections']); $i++) {
                $tx2 = "";
                if ($i > 0) {
                    $tx2 = "&nbsp;--&nbsp;";
                }
                $tx = $_SESSION['sections'][$i]['name'];
                echo "<td>$tx2</td><td><a href='" . $_SESSION['sections'][$i]['link'] . "'>$tx</a></td>";
            }
            echo "</tr><tr>";
            for ($i = 0; $i < count($_SESSION['sections']); $i++) {
                $tx2 = "";
                $tx = $_SESSION['sections'][$i]['display'];
                echo "<td>$tx2</td><td id='section_display_cell'>$tx</td>";
            }
            echo "</tr></table></div>";

            $section_index = count($_SESSION['sections']) - 1;

            // вывод форм

            if (($_GET['f'] == 1) && (isset($fm))) {
                include('formular_list_form.php');
            }
            if (($_GET['f'] == 2) && (isset($bm))) {
                include('bts_list_form.php');
            }
            if (($_GET['f'] == 17) && (isset($bm) || isset($fm) )) {
                include('bts_info_form.php');
            }
            if (($_GET['f'] == 3) && ( ($bm == 'w') || ($fm == 'w') )) {
                include('bts_edit_form.php');
            }
            if (($_GET['f'] == 4) && ( ($bm == 'w') || ($bg == 'w') || ($fm == 'w'))) {
                include('relations_edit_form.php');
            }
            if (($_GET['f'] == 5) && ( ($bm == 'w') || ($bg == 'w') || ($fm == 'w'))) {
                include('values_list_form.php');
            }
            if (($_GET['f'] == 6) && ( ($bm == 'w') || ($bg == 'w') || ($fm == 'w'))) {
                include('values_edit_form.php');
            }
            if (($_GET['f'] == 7) && ($bm == 'w' || $fm == 'w')) {
                include('config_edit_form.php');
            }
            if (($_GET['f'] == 8) && ($bm == 'w' || $fm == 'w')) {
                include('sectors_edit_form.php');
            }
            if (($_GET['f'] == 9) && ($bm == 'w' || $fm == 'w')) {
                include('transport_edit_form.php');
            }
            if (($_GET['f'] == 10) && (isset($st))) {
                include('statistics_form.php');
            }
            if (($_GET['f'] == 11) && (isset($bg))) {
                include('budget_list_form.php');
            }
            if (($_GET['f'] == 12) && (isset($bg))) {
                include('budget_info_form.php');
            }
            if (($_GET['f'] == 13) && ($bg == 'w')) {
                include('budget_edit_form.php');
            }
            if (($_GET['f'] == 14) && ($admin == 'w')) {
                include('admin_form.php');
            }
            if (($_GET['f'] == 15) && ($admin == 'w')) {
                include('import_form.php');
            }
            if (($_GET['f'] == 16) && (isset($bg) || isset($bm) || isset($fm))) {
                include('history_form.php');
            }
            if (($_GET['f'] == 18) && ($bm == 'w' || $fm == 'w')) {
                include('hardware_edit_form.php');
            }
            if (($_GET['f'] == 19) && ($fm == 'w')) {
                include('formular_edit_form.php');
            }
            if (($_GET['f'] == 20) && (isset($fm))) {
                include('formular_info_form.php');
            }
            if (($_GET['f'] == 21) && ($admin == 'w')) {
                include('users_list_form.php');
            }
            if (($_GET['f'] == 22) && ($admin == 'w')) {
                include('user_edit_form.php');
            }
            if (($_GET['f'] == 23) && (isset($fm))) {
                include('formular_sign_form.php');
            }
            if (($_GET['f'] == 24) && ($fm == 'w')) {
                include('formular_lotus_form.php');
            }
            if (($_GET['f'] == 25) && ($fm == 'w')) {
                include('adsearch_form.php');
            }
            if (($_GET['f'] == 26) && ($user_id > 0)) {
                include('account_info_form.php');
            }
            if (($_GET['f'] == 27) && ($user_id > 0)) {
                include('account_edit_form.php');
            }
            if ($_GET['f'] == 29) {
                include('tasks/' . $_GET['alias'] . '/forms.php');
            }
            if (($_GET['f'] == 28) && (isset($rm))) {
                include('repeater_list_form.php');
            }
            if (($_GET['f'] == 30) && (isset($rm) || isset($fm) )) {
                include('repeater_info_form.php');
            }
            if (($_GET['f'] == 31) && ( ($rm == 'w') || ($fm == 'w') )) {
                include('repeater_edit_form.php');
            }
            if (($_GET['f'] == 32) && ( ($rm == 'w') || ($fm == 'w') )) {
                include('repeater_sectors_edit_form.php');
            }
            if (($_GET['f'] == 33) && ( ($rm == 'w') || ($fm == 'w') )) {
                include('repeater_link_edit_form.php');
            }

            // Разделы по технологии MVC
            if ($_GET['f']>33) {

                require_once 'mvc/route.php';
                
                if ($_GET['f'] == 34) route::start('switchings', 'list');
                if ($_GET['f'] == 37) route::start('switchings', 'total');
            }

            //if (($_GET['f'] == 34) && (isset($sw))) {
            //    include('switch_list_form.php');
            //}
            //if (($_GET['f'] == 35) && (isset($sw))) {
            //    include('switch_info_form.php');
            //}
            //if (($_GET['f'] == 36) && ($sw == 'w')) {
            //    include('switch_edit_form.php');
            //}
        }

        echo "</div>";
        echo "</body>";
        echo "</html>";
        ?>
