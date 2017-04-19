<?php
// входные параметры
$id=$_GET['id'];
$function = $_SESSION['function'];
$is_all = true;
if ($function == 'отметка разрешения БелГИЭ') {
    $is_belgie = true;
    $is_all = false;
}
if ($function == 'отметка Актов ввода в эксплуатацию') {
    $is_act = true;
    $is_all = false;
}   

// основной запрос
$sql = "select";
$sql.= " s.id";
$sql.= ",case when plan_gsm_config_id>0 or plan_dcs_config_id>0 then 1 end as is_2g";
$sql.= ",case when TO_DAYS(belgei_2g)>0 then belgei_2g end as belgei_2g_date";
$sql.= ",case when belgei_2g is not null then 1 end as belgei_2g_got";
$sql.= ",case when TO_DAYS(act_2g)>0 then act_2g end as act_2g_date"; 
$sql.= ",case when act_2g is not null then 1 end as act_2g_got"; 
$sql.= ",case when TO_DAYS(gsm)>0 then gsm end as gsm_date"; 
$sql.= ",case when gsm is not null then 1 end as gsm_on";
$sql.= ",case when TO_DAYS(dcs)>0 then dcs end as dcs_date";
$sql.= ",case when dcs is not null then 1 end as dcs_on";
$sql.= ",case when plan_umts_config_id>0 then 1 end as is_3g";
$sql.= ",case when TO_DAYS(belgei_3g)>0 then belgei_3g end as belgei_3g_date";
$sql.= ",case when belgei_3g is not null then 1 end as belgei_3g_got";
$sql.= ",case when TO_DAYS(act_3g)>0 then act_3g end as act_3g_date";
$sql.= ",case when act_3g is not null then 1 end as act_3g_got";
$sql.= ",case when TO_DAYS(umts2100)>0 then umts2100 end as umts2100_date";
$sql.= ",case when umts2100 is not null then 1 end as umts2100_on";
$sql.= ",case when plan_umts9_config_id>0 then 1 end as is_3g9";
$sql.= ",case when TO_DAYS(belgei_3g9)>0 then belgei_3g9 end as belgei_3g9_date";
$sql.= ",case when belgei_3g9 is not null then 1 end as belgei_3g9_got";
$sql.= ",case when TO_DAYS(act_3g9)>0 then act_3g9 end as act_3g9_date";
$sql.= ",case when act_3g9 is not null then 1 end as act_3g9_got";
$sql.= ",case when TO_DAYS(umts900)>0 then umts900 end as umts900_date";
$sql.= ",case when umts900 is not null then 1 end as umts900_on";
$sql.= ",case when plan_lte_config_id>0 then 1 end as is_4g";
$sql.= ",case when TO_DAYS(lte)>0 then lte end as lte_date";
$sql.= ",case when lte is not null then 1 end as lte_on";
$sql.= ",case when TO_DAYS(stat)>0 then stat end as stat_date";
$sql.= ",case when stat is not null then 1 end as stat_got";
$sql.= ",case when TO_DAYS(uninstall)>0 then uninstall end as uninstall_date";
$sql.= ",case when uninstall is not null then 1 end as uninstall_got";
$sql.= ",is_on";
$sql.= " from bts";
$sql.= " left join switchings s on bts.id=s.bts_id";
$sql.= " where bts.id='$id'";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// формируем элементы
if ($row['is_2g']) {
  $info[] = $info1 = array(
      'field' => '<b>2G</b>'
      , 'el_type' => 'break'
  );
  if ($is_all || $is_belgie) {
      /////////////////// belgei_2g ////////////////////////////////////////////
      $belgei_2g_got = PrvFill('belgei_2g_got', $row['belgei_2g_got']);
      $info[] = $info1 = array(
          'value' => $belgei_2g_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'belgei_2g_got'
          , 'start_line' => true
      );
      $belgei_2g_date = PrvFill('belgei_2g_date', $row['belgei_2g_date']);
      $info[] = $info1 = array(
          'field' => 'Разрешение БелГИЭ 2G'
          , 'value' => $belgei_2g_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'belgei_2g_date'
          , 'end_line' => true
      );
  }
  if ($is_all || $is_act) {
      /////////////////// act_2g ///////////////////////////////////////////////
      $act_2g_got = PrvFill('act_2g_got', $row['act_2g_got']);
      $info[] = $info1 = array(
          'value' => $act_2g_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'act_2g_got'
          , 'start_line' => true
      );
      $act_2g_date = PrvFill('act_2g_date', $row['act_2g_date']);
      $info[] = $info1 = array(
          'field' => 'Акт ввода в эксплуатацию 2G'
          , 'value' => $act_2g_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'act_2g_date'
          , 'end_line' => true
      );
  }
  if ($is_all) {
      /////////////////// gsm //////////////////////////////////////////////////
      $gsm_on = PrvFill('gsm_on', $row['gsm_on']);
      $info[] = $info1 = array(
          'value' => $gsm_on
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'gsm_on'
          , 'start_line' => true
      );
      $gsm_date = PrvFill('gsm_date', $row['gsm_date']);
      $info[] = $info1 = array(
          'field' => 'Включение GSM'
          , 'value' => $gsm_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'gsm_date'
          , 'end_line' => true
      );
      /////////////////// dcs //////////////////////////////////////////////////
      $dcs_on = PrvFill('dcs_on', $row['dcs_on']);
      $info[] = $info1 = array(
          'value' => $dcs_on
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'dcs_on'
          , 'start_line' => true
      );
      $dcs_date = PrvFill('dcs_date', $row['dcs_date']);
      $info[] = $info1 = array(
          'field' => 'Включение DCS'
          , 'value' => $dcs_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'dcs_date'
          , 'end_line' => true
      );
  }
}
if ($row['is_3g']) {
  $info[] = $info1 = array(
      'field' => '<b>3G</b>'
      , 'el_type' => 'break'
  );
  if ($is_all || $is_belgie) {
      /////////////////// belgei_3g ////////////////////////////////////////////
      $belgei_3g_got = PrvFill('belgei_3g_got', $row['belgei_3g_got']);
      $info[] = $info1 = array(
          'value' => $belgei_3g_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'belgei_3g_got'
          , 'start_line' => true
      );
      $belgei_3g_date = PrvFill('belgei_3g_date', $row['belgei_3g_date']);
      $info[] = $info1 = array(
          'field' => 'Разрешение БелГИЭ 3G'
          , 'value' => $belgei_3g_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'belgei_3g_date'
          , 'end_line' => true
      );
  }
  if ($is_all || $is_act) {
      /////////////////// act_3g ///////////////////////////////////////////////
      $act_3g_got = PrvFill('act_3g_got', $row['act_3g_got']);
      $info[] = $info1 = array(
          'value' => $act_3g_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'act_3g_got'
          , 'start_line' => true
      );
      $act_3g_date = PrvFill('act_3g_date', $row['act_3g_date']);
      $info[] = $info1 = array(
          'field' => 'Акт ввода в эксплуатацию 3G'
          , 'value' => $act_3g_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'act_3g_date'
          , 'end_line' => true
      );
  }
  if ($is_all) {
      /////////////////// umts 2100 ////////////////////////////////////////////
      $umts2100_on = PrvFill('umts2100_on', $row['umts2100_on']);
        $info[] = $info1 = array(
          'value' => $umts2100_on
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'umts2100_on'
          , 'start_line' => true
      );
      $umts2100_date = PrvFill('umts2100_date', $row['umts2100_date']);
      $info[] = $info1 = array(
          'field' => 'Включение UMTS 2100'
          , 'value' => $umts2100_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'umts2100_date'
          , 'end_line' => true
      );
  }
}

if ($row['is_3g9']) {
  $info[] = $info1 = array(
      'field' => '<b>UMTS 900</b>'
      , 'el_type' => 'break'
  );
  if ($is_all || $is_belgie) {
      /////////////////// belgei_3g9 ////////////////////////////////////////////
      $belgei_3g9_got = PrvFill('belgei_3g9_got', $row['belgei_3g9_got']);
      $info[] = $info1 = array(
          'value' => $belgei_3g9_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'belgei_3g9_got'
          , 'start_line' => true
      );
      $belgei_3g9_date = PrvFill('belgei_3g9_date', $row['belgei_3g9_date']);
      $info[] = $info1 = array(
          'field' => 'Разрешение БелГИЭ umts900'
          , 'value' => $belgei_3g9_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'belgei_3g9_date'
          , 'end_line' => true
      );
  }
  if ($is_all || $is_act) {
      /////////////////// act_3g9 ///////////////////////////////////////////////
      $act_3g9_got = PrvFill('act_3g9_got', $row['act_3g9_got']);
      $info[] = $info1 = array(
          'value' => $act_3g9_got
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'act_3g9_got'
          , 'start_line' => true
      );
      $act_3g9_date = PrvFill('act_3g9_date', $row['act_3g9_date']);
      $info[] = $info1 = array(
          'field' => 'Акт ввода в эксплуатацию UMTS900'
          , 'value' => $act_3g9_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'act_3g9_date'
          , 'end_line' => true
      );
  }
  if ($is_all) {
      /////////////////// umts 900 /////////////////////////////////////////////
      $umts900_on = PrvFill('umts900_on', $row['umts900_on']);
        $info[] = $info1 = array(
          'value' => $umts900_on
          , 'el_type' => 'checkbox'
          , 'id' => ''
          , 'name' => 'umts900_on'
          , 'start_line' => true
      );
      $umts900_date = PrvFill('umts900_date', $row['umts900_date']);
      $info[] = $info1 = array(
          'field' => 'Включение UMTS 900'
          , 'value' => $umts900_date
          , 'el_type' => 'date'
          , 'id' => 'date_field'
          , 'name' => 'umts900_date'
          , 'end_line' => true
      );
  }
}

if ($row['is_4g'] && $is_all) {
  $info[] = $info1 = array(
      'field' => '<b>4G</b>'
      , 'el_type' => 'break'
  );
  /////////////////// lte //////////////////////////////////////////////////////
  $lte_on = PrvFill('lte_on', $row['lte_on']);
    $info[] = $info1 = array(
      'value' => $lte_on
      , 'el_type' => 'checkbox'
      , 'id' => ''
      , 'name' => 'lte_on'
      , 'start_line' => true
  );
  $lte_date = PrvFill('lte_date', $row['lte_date']);
  $info[] = $info1 = array(
      'field' => 'Включение LTE 1800'
      , 'value' => $lte_date
      , 'el_type' => 'date'
      , 'id' => 'date_field'
      , 'name' => 'lte_date'
      , 'end_line' => true
  );
}

if ($is_all) {
    $info[] = $info1 = array(
        'el_type' => 'break'
    );
    /////////////////// stat ///////////////////////////////////////////////////
    $stat_got = PrvFill('stat_got', $row['stat_got']);
    $info[] = $info1 = array(
        'value' => $stat_got
        , 'el_type' => 'checkbox'
        , 'id' => ''
        , 'name' => 'stat_got'
        , 'start_line' => true
    );
    $stat_date = PrvFill('stat_date', $row['stat_date']);
    $info[] = $info1 = array(
        'field' => 'Наличие Статистики'
        , 'value' => $stat_date
        , 'el_type' => 'date'
        , 'id' => 'date_field'
        , 'name' => 'stat_date'
        , 'end_line' => true
    );
    /////////////////// uninstall //////////////////////////////////////////////
    $uninstall_got = PrvFill('uninstall_got', $row['uninstall_got']);
    $info[] = $info1 = array(
        'value' => $uninstall_got
        , 'el_type' => 'checkbox'
        , 'id' => ''
        , 'name' => 'uninstall_got'
        , 'start_line' => true
    );
    $uninstall_date = PrvFill('uninstall_date', $row['uninstall_date']);
    $info[] = $info1 = array(
        'field' => 'Демонтаж'
        , 'value' => $uninstall_date
        , 'el_type' => 'date'
        , 'id' => 'date_field'
        , 'name' => 'uninstall_date'
        , 'end_line' => true
    );
    
    $info[] = $info1 = array(
        'el_type' => 'break'
    );
    $is_on = PrvFill('is_on', $row['is_on']);
    $info[] = $info1 = array(
        'field' => 'БС включена'
        , 'value' => $is_on
        , 'el_type' => 'checkbox'
        , 'id' => ''
        , 'name' => 'is_on'
    );
}

// блок списка кнопок действий
// вывод элементов интерфейса
echo "<div id='left_indent'>";
for ($i = 0; $i < count($info); $i++) {
    FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='switch_edit.php?bts_id=$id&id=".$row['id']."' method='post' id='switch_edit_form'>";
for ($i = 0; $i < count($info); $i++) {
    FieldEdit($info[$i]);
}
echo "<p><button type='submit'>сохранить</button></p>";
echo "</form>";
echo "</div>";
?>