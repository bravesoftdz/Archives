<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$id=$_GET['id'];
$last_index=count($_SESSION['sections'])-1;

if ($id>0 && isset($_GET['del'])==false) {  // UPDATE
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';
}
if ($id==0) { // INSERT
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='insert';
}

// основной запрос
$data = array (
   'login' => $_POST['login']
  ,'password' => $_POST['password']
  ,'name' => $_POST['name']
  ,'middle_name' => $_POST['middle_name']
  ,'surname' => $_POST['surname']
  ,'department' => $_POST['department']
  ,'function' => $_POST['function']
);

if (isset($_GET['del'])) {  // DELETE
  $link=$_SESSION['sections'][$last_index]['link']; 
  $edit_type='delete';
}

$id = MySQLAction($data,'users',$id,$edit_type,false);

// ADDITIONAL EDIT
$fields = array (
   'Id'
  ,'user_id'
  ,'object_access'
  ,'access_type'
);

$s=0;
foreach ($_POST as $k => $v) {
  $i=substr($k,strripos($k,'_')+1,strlen($k) );
  $r=substr($k,0,strripos($k,'_')+1);
  if (is_numeric($i) && $r == 'object_access_') {
    if (isset($_POST["access_type_$i"])) {
      $post["object_access_$s"] = $_POST["object_access_$i"];
      $post["Id_$s"] = $_POST["Id_$i"];
      $post["access_type_$s"] = $_POST["access_type_$i"];
      $s++;
    } 
  }
}
SlaveTableUpdate($post,'users_access','user_id',$id,$fields,false);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 