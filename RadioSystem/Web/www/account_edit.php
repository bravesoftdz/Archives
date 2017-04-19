<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$last_index=count($_SESSION['sections'])-2;
$link=$_SESSION['sections'][$last_index]['link'];

// основной запрос
$data = array (
   'login' => $_POST['login']
  ,'password' => $_POST['password']
);

$id = MySQLAction($data,'users',$_SESSION['user_id'],'update',false);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 