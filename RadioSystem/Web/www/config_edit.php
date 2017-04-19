<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$id=$_GET['id'];

if ($id>0 && !isset($_GET['del'])) {  // UPDATE
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';
}

// основной запрос
$data = array (
   'cupboard_2g_count' => $_POST['cupboard_2g_count']
  ,'plan_gsm_config_id' => $_POST['plan_gsm_config_id']
  ,'install_gsm_config_id' => $_POST['install_gsm_config_id']
  ,'work_gsm_config_id' => $_POST['work_gsm_config_id']
  ,'plan_dcs_config_id' => $_POST['plan_dcs_config_id']
  ,'install_dcs_config_id' => $_POST['install_dcs_config_id']
  ,'work_dcs_config_id' => $_POST['work_dcs_config_id']
  ,'cupboard_3g_count' => $_POST['cupboard_3g_count']
  ,'plan_umts_config_id' => $_POST['plan_umts_config_id']
  ,'work_umts_config_id' => $_POST['work_umts_config_id']
  ,'plan_umts9_config_id' => $_POST['plan_umts9_config_id']
  ,'work_umts9_config_id' => $_POST['work_umts9_config_id']
  ,'plan_lte_config_id' => $_POST['plan_lte_config_id']
  ,'work_lte_config_id' => $_POST['work_lte_config_id']
  ,'cupboard_4g_count' => $_POST['cupboard_4g_count']
);

$id = MySQLAction($data,'bts',$id,$edit_type,true);
?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 