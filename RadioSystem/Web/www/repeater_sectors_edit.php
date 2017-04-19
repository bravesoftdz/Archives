<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$id=$_GET['id'];

$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];

// ADDITIONAL EDIT
$fields = array (
   'Id'
  ,'repeater_id'
  ,'num'
  ,'antenna_type_id'
  ,'height'
  ,'azimuth'
  ,'te_slope'
  ,'tm_slope'
  ,'cable_type'
  ,'cable_length'
  ,'notes'
);
SlaveTableUpdate($_POST,'repeater_sectors','repeater_id',$id,$fields,true);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 