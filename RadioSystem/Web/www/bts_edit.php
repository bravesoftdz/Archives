<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$id=$_GET['id'];
$longitudel_s=$_POST['s_grad']." ".$_POST['s_min']." ".$_POST['s_sec'];
$longitudel_d=$_POST['d_grad']." ".$_POST['d_min']." ".$_POST['d_sec'];

if ($id>0 && !isset($_GET['del'])) {  // UPDATE
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';
}

// основной запрос
$data = array (
   'bts_number' => $_POST['bts_number']
  ,'site_type' => $_POST['site_type']
  ,'settlement_id' => $_POST['settlement_id']
  ,'street_type' => $_POST['street_type']
  ,'street_name' => $_POST['street_name']
  ,'house_type' => $_POST['house_type']
  ,'house_number' => $_POST['house_number']
  ,'place_owner' => $_POST['place_owner']
  ,'cooperative' => $_POST['cooperative']
  ,'construction_2g_type_id' => $_POST['construction_2g_type_id']
  ,'model_type_2g' => $_POST['model_type_2g']
  ,'container_type' => $_POST['container_type']
  ,'construction_3g_type_id' => $_POST['construction_3g_type_id']
  ,'model_type_3g' => $_POST['model_type_3g']
  ,'construction_4g_type_id' => $_POST['construction_4g_type_id']
  ,'model_type_4g' => $_POST['model_type_4g']
  ,'power_cupboard_count' => $_POST['power_cupboard_count']
  ,'power_type_id' => $_POST['power_type_id']
  ,'battery_capacity' => $_POST['battery_capacity']
  ,'longitudel_s' => $longitudel_s
  ,'longitudel_d' => $longitudel_d
  ,'notes' => $_POST['notes']
);

$id = MySQLAction($data,'bts',$id,$edit_type,true);
?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 
                                                                                                                                                                                                                                                                                                