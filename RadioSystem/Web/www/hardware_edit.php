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
  ,'bts_id'
  ,'equipment'
  ,'quantity'
);
SlaveTableUpdate($_POST,'hardware','bts_id',$id,$fields,true);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 