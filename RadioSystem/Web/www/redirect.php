<?php
include_once('config.php');
include_once('functions.php');
session_start();

// данные предыдущей формы сохраняем в сессии
$last_index = count($_SESSION['sections']) - 1;                 
foreach ($_POST as $k => $v) {
    $_SESSION['sections'][$last_index]['form'][$k] = $v;
}

// обнуляем в сессии не переданные в post запросе контролы (для checkbox)
foreach ($_SESSION['sections'][$last_index]['form'] as $key => $value) {
  if (!isset($_POST[$key])) unset($_SESSION['sections'][$last_index]['form'][$key]);
}  
 

if ($_GET['f'] == '4') {  // редактор связанных списков
    if (isset($_GET['i']))
        $i = "&i=" . $_GET['i'];

    if ($_GET['obj'] == 'region') {  // область
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'] . $i;
        $_SESSION['display'] = $_SESSION['sections'][$last_index - 1]['display'];
    }

    if ($_GET['obj'] == 'area') {   // район
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'] . $i;
        $sql = "SELECT region FROM regions WHERE id=" . $_SESSION['sections'][$last_index]['form']['select'];
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        $_SESSION['display'] = $row[0];
    }

    if ($_GET['obj'] == 'settlement') {  // нас. пункт
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'] . $i;
        $sql = "SELECT area FROM areas WHERE id=" . $_SESSION['sections'][$last_index]['form']['select'];
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        $_SESSION['display'] = $row[0];
    }

    // год бюджета
    if ($_GET['obj'] == 'budget_year') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'];
    }
    // тип бюджета
    if ($_GET['obj'] == 'budget_type') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'];
    }

    // подтип бюджета 
    if ($_GET['obj'] == 'budget_type_g') {
        if ($_POST['select'] == '2g') {                       // 2g
            $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_type_2g";
        }
        if ($_POST['select'] == '3g') {                       //3g
            $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_type_3g";
        }
        if ($_POST['select'] == '2g/3g') {                    // 2g/3g
            $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_type_2g";
        }
        if (GetFromPrvForm('select', 2) == '2g/3g') {         // если 2g/3g , то после 2g перенаправляем на 3g
            $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_type_3g";
        }
        if (isset($tx) == false) {// направляем на сохранение
            $tx = "relations_edit.php?ff=" . $_GET['ff'] . "&obj=budget";
        }
    }
    // номер бюджета 2G
    if ($_GET['obj'] == 'budget_number_2g') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_number_2g";
    }
    // номер бюджета 3G
    if ($_GET['obj'] == 'budget_number_3g') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=budget_number_3g";
    }
    // ссылка на документ - загрузка документа
    if ($_GET['obj'] == 'doc_link') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=doc_link&i=" . $_GET['i'];
    }
    if ($_GET['obj'] == 'form_1bs_link' || $_GET['obj'] == 'agreem_link' || $_GET['obj'] == 'form_rrl_link') {
        $tx = "index.php?f=4&ff=" . $_GET['ff'] . "&obj=" . $_GET['obj'];
    }
}

if ($_GET['f'] == '5') {  // редактор списка значений
    if ($_GET['obj'] == 'regions') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=regions";
    }
    if ($_GET['obj'] == 'areas') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=areas";
    }
    if ($_GET['obj'] == 'settlements') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=settlements";
    }
    if ($_GET['obj'] == 'construction_2g_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=construction_2g_types";
    }
    if ($_GET['obj'] == 'construction_3g_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=construction_3g_types";
    }
    if ($_GET['obj'] == 'construction_4g_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=construction_4g_types";
    }
    if ($_GET['obj'] == 'power_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=power_types";
    }
    if ($_GET['obj'] == 'gsm_configs') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=gsm_configs";
    }
    if ($_GET['obj'] == 'dcs_configs') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=dcs_configs";
    }
    if ($_GET['obj'] == 'umts_configs') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=umts_configs";
    }
    if ($_GET['obj'] == 'umts9_configs') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=umts_configs";
    }
    if ($_GET['obj'] == 'lte_configs') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=lte_configs";
    }
    if ($_GET['obj'] == 'antenna_types_2g') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=antenna_types_2g";
    }
    if ($_GET['obj'] == 'antenna_types_3g') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=antenna_types_3g";
    }
    if ($_GET['obj'] == 'antenna_types_4g') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=antenna_types_4g";
    }
    if ($_GET['obj'] == 'antenna_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=antenna_types_2g";
    }
    if ($_GET['obj'] == 'repeater_types') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=repeater_types";
    }

    if ($_GET['obj'] == 'build_organizations') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=build_organizations";
    }
    if ($_GET['obj'] == 'project_organizations') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=project_organizations";
    }
    if ($_GET['obj'] == 'agreement_persons') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=agreement_persons";
    }
    if ($_GET['obj'] == 'build_persons') {
        $tx = "f=5&ff=" . $_GET['ff'] . "&obj=build_persons";
    }
    $tx = 'index.php?' . $tx;
    $_SESSION['display'] = $_SESSION['sections'][$last_index - 1]['display'];
}

if ($_GET['f'] == '8') {  // редактор секторов
    $tx = $_SESSION['sections'][$last_index]['link'];
}

if ($_GET['f'] == '9') { // редактор транспорта  
    if (isset($_GET['add'])) {
        $sql = "SELECT Id FROM bts WHERE bts_number='" . $_POST['bts_number'] . "'";
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        if (mysql_num_rows($query) > 0) {
            AddInterfaceRow($last_index);
            $_SESSION['point_2_id'] = $row[0];
        }
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
    if (isset($_GET['del'])) {
        DeleteInterfaceRow($last_index, $_GET['rn']);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}

if ($_GET['f'] == '11') { // список бюджета
    if (isset($_GET['del'])) {
        $tx = "budget_edit.php?id=" . $_GET['id'] . "&del";
    }
    if (isset($_GET['del']) == false) {
        $tx = "index.php?f=11";
        if (isset($_GET['newsearch'])) {
            $tx = "index.php?f=11&newsearch";
        }
    }
}

if ($_GET['f'] == '12') {  // инфо строки бюджета
    $sql = "SELECT ";
    $sql = $sql . "CASE WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g) ";
    $sql = $sql . "      WHEN CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL AND CONCAT(budget_type_2g,'_',budget_number_2g) is NULL THEN CONCAT(budget_type_3g,'_',budget_number_3g) ";
    $sql = $sql . "      WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g,'<br>',budget_type_3g,'_',budget_number_3g) ";
    $sql = $sql . " END as budget_number FROM budget WHERE id=" . $_GET['id'];
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $_SESSION['budget_number'] = $row[0];
    $_SESSION['display'] = $row[0];
    $tx = "index.php?f=12&id=" . $_GET['id'];
}

if ($_GET['f'] == '13') { // редактор строки бюджета
    if (isset($_GET['del']) == false && isset($_GET['add']) == false) {
        $sql = "SELECT ";
        $sql = $sql . "CASE WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g) ";
        $sql = $sql . "      WHEN CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL AND CONCAT(budget_type_2g,'_',budget_number_2g) is NULL THEN CONCAT(budget_type_3g,'_',budget_number_3g) ";
        $sql = $sql . "      WHEN CONCAT(budget_type_2g,'_',budget_number_2g) is not NULL AND CONCAT(budget_type_3g,'_',budget_number_3g) is not NULL THEN CONCAT(budget_type_2g,'_',budget_number_2g,'<br>',budget_type_3g,'_',budget_number_3g) ";
        $sql = $sql . " END as budget_number FROM budget WHERE id=" . $_GET['id'];
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        $_SESSION['budget_number'] = $row[0];
        $tx = "index.php?f=13&id=" . $_GET['id'];

        if (!isset($_POST['existing_object'])) {
            $_SESSION['sections'][$last_index]['form']['existing_object'] = 0;
        } else {
            $_SESSION['sections'][$last_index]['form']['existing_object'] = 1;
        }
    }

    if (isset($_GET['del'])) {
        DeleteInterfaceRow($last_index, $_GET['rn']);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }

    if (isset($_GET['add'])) {
        AddInterfaceRow($last_index);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}

if ($_GET['f'] == '15') { // импорт данных
    $tx = "index.php?f=15" . (isset($_GET['update']) ? "&update" : "") . "&step" . $_GET['step'] . (!empty($_GET['anchor']) ? "#" . $_GET['anchor'] : "");
}

if ($_GET['f'] == '2') { // список бс
    $tx = "index.php?f=2";
}

if ($_GET['f'] == '17') { // инфо бс
    if (isset($_POST['bts_number'])) {
        $bts_number = $_POST['bts_number'];
        $sql = "SELECT Id FROM bts WHERE bts_number=" . StrOrNull($bts_number);
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        $id = $row['Id'];
    }
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        $sql = "SELECT bts_number FROM bts WHERE id=" . StrOrNull($id);
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query);
        $bts_number = $row['bts_number'];
    }
    if (!empty($id)) {
        $_SESSION['bts_number'] = $bts_number;
        $tx = "index.php?f=17&id=$id";
    } else {
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}

if ($_GET['f'] == '3') { // редактор бс
    $tx = "index.php?f=3&id=" . $_GET['id'];
}

if ($_GET['f'] == '18') { // редактор доп. оборудования бс
    if (isset($_GET['del'])) {
        DeleteInterfaceRow($last_index, $_GET['rn']);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }

    if (isset($_GET['add'])) {
        AddInterfaceRow($last_index);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}

if ($_GET['f'] == '20') { // инфо формуляр
    $tx = "index.php?f=20&id=" . $_GET['id'];
    $_SESSION['display'] = GetSmallFormularAddress($_GET['id']);

    // проверка на разрешение редактировать данные о БС
    $sql = "SELECT projector_user_id, to_lotus_date FROM formulars WHERE id=" . $_GET['id'];
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    if ($row[0] == $_SESSION['user_id'] && empty($row[1])) {
        $_SESSION['enable_to_edit'] = 1;
    } else {
        $_SESSION['enable_to_edit'] = 0;
    }

    // отвязка id бюджета
    if (isset($_GET['oidremove'])) {
        $sql = "UPDATE formulars SET budget_id=NULL WHERE id=" . $_GET['id'];
        $query = mysql_query($sql) or die(mysql_error());
    }
}

if ($_GET['f'] == '21') { // список пользователей
    if (isset($_GET['del'])) {
        $tx = "user_edit.php?id=" . $_GET['id'] . "&del";
    }
    if (isset($_GET['del']) == false) {
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}

if ($_GET['f'] == '1') { // список формуляров
    $tx = $_SESSION['sections'][$last_index]['link'];
}

if ($_GET['f'] == '25') { // дополнительный поиск
    $tx = "index.php?f=25&ff=" . $_GET['ff'] . "&object=budget";
}

if ($_GET['f'] == '28') { // список репиторов
    $tx = "index.php?f=28";
}
if ($_GET['f'] == '30') { // инфо репитер
    $tx = "index.php?f=30&id=" . $_GET['id'];
    $sql = "SELECT repeater_number FROM repeaters WHERE Id=" . StrOrNull($_GET['id']);
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $_SESSION['display'] = $row['repeater_number'];
}
if ($_GET['f'] == '32') { // редактор секторов репитера
    $tx = $_SESSION['sections'][$last_index]['link'];
}
if ($_GET['f'] == '34') { // список включений
    $tx = "index.php?f=34";
}
if ($_GET['f'] == '35') { // инфо включений
    $tx = "index.php?f=35&id=" . $_GET['id'];
    $id = $_GET['id'];
    $sql = "SELECT bts_number FROM bts WHERE id=" . StrOrNull($id);
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $bts_number = $row['bts_number'];
    $_SESSION['display'] = "БС" . $bts_number;
}
if ($_GET['f'] == '36') { // редактор включений
    $tx = "index.php?f=36&id=" . $_GET['id'];
    $id = $_GET['id'];
    $sql = "SELECT bts_number FROM bts WHERE id=" . StrOrNull($id);
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $bts_number = $row['bts_number'];
    $_SESSION['display'] = "БС" . $bts_number;
    if (isset($_GET['del'])) {
        DeleteInterfaceRow($last_index, $_GET['rn']);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
    if (isset($_GET['add'])) {
        AddInterfaceRow($last_index);
        $tx = $_SESSION['sections'][$last_index]['link'];
    }
}
?>
<script>
    var param = '<?php echo $tx; ?>';
    document.location.href = param</script> 