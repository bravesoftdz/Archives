<?php
include_once('config.php');
include_once('functions.php');
session_start();

$id=$_GET['id'];

if ($id>0 && isset($_GET['del'])==false) {  // UPDATE
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';
}
if ($id==0) { // INSERT
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='insert';
}
$data = array (
  'technology_generation' => $_POST['technology_generation']
 ,'budget_type_2g' => $_POST['budget_type_2g']
 ,'budget_number_2g' => $_POST['budget_number_2g']
 ,'budget_source_2g' => $_POST['budget_source_2g']
 ,'budget_type_3g' => $_POST['budget_type_3g']
 ,'budget_number_3g' => $_POST['budget_number_3g']
 ,'budget_source_3g' => $_POST['budget_source_3g']
 ,'existing_object' => $_POST['existing_object']
 ,'bts_id' => $_POST['bts_id']
 ,'demontation_bts_id' => $_POST['demontation_bts_id']
 ,'outside_id' => $_POST['outside_id']
 ,'site_type' => $_POST['site_type']
 ,'cooperative' => $_POST['cooperative']
 ,'budget_year' => $_POST['budget_year']
 ,'budget_month' => $_POST['budget_month']
 ,'construction_2g_type_id' => $_POST['construction_2g_type_id']
 ,'construction_3g_type_id' => $_POST['construction_3g_type_id']
 ,'model_type_2g' => $_POST['model_type_2g']
 ,'model_type_3g' => $_POST['model_type_3g']
 ,'gsm_config_id' => $_POST['gsm_config_id']
 ,'dcs_config_id' => $_POST['dcs_config_id']
 ,'umts_config_id' => $_POST['umts_config_id']
 ,'transport_type' => $_POST['transport_type']
 ,'transport_technology' => $_POST['transport_technology']
 ,'bsc_id' => $_POST['bsc_id']
 ,'lac_2g' => $_POST['lac_2g']
 ,'rnc_id' => $_POST['rnc_id']
 ,'lac_3g' => $_POST['lac_3g']
 ,'equipment_delivered' => $_POST['equipment_delivered']
 ,'notes' => $_POST['notes']
);

if (isset($_GET['del'])) {  // DELETE
$link="index.php?f=11";
$edit_type='delete';
}

$id = MySQLAction($data,'budget',$id,$edit_type,true);

// ADDITIONAL EDIT
$fields = array ('Id','budget_id','settlement_id','street_type','street_name','house_type','house_number','doc_date','doc_link');
SlaveTableUpdate($_POST,'budget_addresses','budget_id',$id,$fields,true);
?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 