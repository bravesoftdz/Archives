<?php
include_once('config.php');
include_once('functions.php');
session_start();

date_default_timezone_set('Etc/GMT-3');

// входные параметры
$id=$_GET['id'];
$user_id = $_SESSION['user_id'];
$department = $_SESSION['department'];
$link='index.php?f=1';

// основной запрос
$data = array (
   'to_lotus_date' => date('Y-m-d')
  ,'fud_user_id' => $_SESSION['user_id']
);

$data2 = array (
   'formular_id' => $id
  ,'action_date' => date('Y-m-d')
  ,'action_time' => date('H:i:s')
  ,'user_id' => $_SESSION['user_id']
  ,'action' => 'lotus'
  ,'department' => $department
);

$id = MySQLAction($data,'formulars',$id,'update',false);
$id = MySQLAction($data2,'formular_actions',0,'insert',false);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 