<?php
include_once('config.php');
include_once('functions.php');
session_start();

date_default_timezone_set('Etc/GMT-3');

// входные параметры
$id=$_GET['id'];
if (isset($_GET['fud'])) {$fud_user_id=$_SESSION['user_id'];}

if ($id>0 && isset($_GET['del'])==false) {  // UPDATE
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';
}
if ($id==0) { // INSERT
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='insert';

if (!isset($_GET['rep']) && !isset($_GET['rfud'])) {   // если формуляр по бс - получаем id бс из бюджета
  $sql = "SELECT * FROM budget WHERE id=".$_POST['budget_id'];
  $query = mysql_query($sql) or die(mysql_error());
  $row = mysql_fetch_array($query); 
  $bts_id = $row['bts_id'];
  }
}

// основной запрос
$data = array (
   'budget_id' => $_POST['budget_id']
  ,'repeater_id' => $_POST['repeater_id']
  ,'type' => $_POST['type']
  ,'projector_user_id' => $_POST['projector_user_id']
  ,'agreem_person_id' => $_POST['agreem_person_id']
  ,'build_person_id' => $_POST['build_person_id']
  ,'project_organization_id' => $_POST['project_organization_id']
  ,'build_organization_id' => $_POST['build_organization_id']
  ,'create_date' => $_POST['create_date']
  ,'inspect_date' => $_POST['inspect_date']
  ,'notes' => $_POST['notes']
  ,'form_1bs_link' => $_POST['form_1bs_link']
  ,'fud_user_id' => $fud_user_id
  ,'agreem_link' => $_POST['agreem_link']
  ,'form_rrl_link' => $_POST['form_rrl_link']
);

if ($edit_type=='insert') {
  if (empty($bts_id) && !isset($_GET['rep']) && !isset($_GET['rfud'])) {
    $sql = "SELECT * FROM budget_addresses WHERE budget_id=".$_POST['budget_id']." ORDER BY Id DESC LIMIT 1";
    $query = mysql_query($sql) or die(mysql_error());
    $row2 = mysql_fetch_array($query); 
    
    $data2 = array (
       'bts_number' => ''
      ,'site_type' => $row['site_type']
      ,'settlement_id' => $row2['settlement_id']
      ,'street_type' => $row2['street_type']
      ,'street_name' => $row2['street_name']
      ,'house_type' => $row2['house_type']
      ,'house_number' => $row2['house_number']
      ,'cooperative' => $row['cooperative']
      ,'construction_2g_type_id' => $row['construction_2g_type_id']
      ,'construction_3g_type_id' => $row['construction_3g_type_id']
      ,'model_type_2g' => $row['model_type_2g']
      ,'model_type_3g' => $row['model_type_3g']
      ,'plan_gsm_config_id' => $row['gsm_config_id']
      ,'plan_dcs_config_id' => $row['dcs_config_id']
      ,'plan_umts_config_id' => $row['umts_config_id']
      ,'bsc_id' => $row['bsc_id']
      ,'lac_2g' => $row['lac_2g']
      ,'rnc_id' => $row['rnc_id']
      ,'lac_3g' => $row['lac_3g']
    ); 
    $bts_id = MySQLAction($data2,'bts',$id,'insert',true);  
  
    $data3['bts_id'] = $bts_id;
    MySQLAction($data3,'budget',$_POST['budget_id'],'update',false);
  }
  $data['bts_id'] = $bts_id;
}

$id = MySQLAction($data,'formulars',$id,$edit_type,true);

// если ФУД - пропускаем согласование ФПД
if (isset($_GET['fud']) || isset($_GET['rfud'])) {
  $data = array (
     'formular_id' => $id
    ,'action_date' => date('Y-m-d')
    ,'action_time' => date('H:i:s')
    ,'user_id' => $_SESSION['user_id']
    ,'action' => 'skip'
    ,'department' => 'ОСПСД'
  ); 
  $id = MySQLAction($data,'formular_actions',0,'insert',false);
  $data['department'] = 'ОЧПиОС'; 
  $id = MySQLAction($data,'formular_actions',0,'insert',false);
  $data['department'] = 'ОРТР'; 
  $id = MySQLAction($data,'formular_actions',0,'insert',false);
}

// если репитер - частично пропускаем согласование ФПД
if (isset($_GET['rep'])) {
  $data = array (
     'formular_id' => $id
    ,'action_date' => date('Y-m-d')
    ,'action_time' => date('H:i:s')
    ,'user_id' => $_SESSION['user_id']
    ,'action' => 'skip'
    ,'department' => 'ОРТР'
  ); 
  $id = MySQLAction($data,'formular_actions',0,'insert',false);
}


?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 