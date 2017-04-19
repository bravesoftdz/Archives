<?php
include_once('config.php');
include_once('functions.php');
session_start();

$form_index=$_GET['ff'];

$_SESSION['sections'][$form_index]['form']['budget_id']=$_GET['id'];

$link=$_SESSION['sections'][$form_index]['link'];
?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 