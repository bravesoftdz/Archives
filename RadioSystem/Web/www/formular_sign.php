<?php
include_once('config.php');
include_once('functions.php');
session_start();

date_default_timezone_set('Etc/GMT-3');

// входные параметры
$id=$_GET['id'];
$department = $_SESSION['department'];
if (isset($_GET['sign'])) $action = 'sign';
if (isset($_GET['decline'])) $action = 'decline';
if (isset($_GET['accept'])) $action = 'accept';
if (isset($_GET['fixed'])) {
  $action = 'fixed';
  $sql = "SELECT * FROM"; 
  $sql.= " (SELECT * FROM formular_actions WHERE formular_id=$id ORDER BY -id) p1";  
  $sql.= " GROUP BY department, user_id";
  $query=mysql_query($sql) or die(mysql_error());
}

if ($id>0) { // INSERT
$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='insert';
}

// основной запрос
$data = array (
   'formular_id' => $id
  ,'action_date' => date('Y-m-d')
  ,'action_time' => date('H:i:s')
  ,'user_id' => $_SESSION['user_id']
  ,'action' => $action
  ,'department' => $department
  ,'notes' => $_POST['notes']
);

if ($action != 'fixed') $id = MySQLAction($data,'formular_actions',0,$edit_type,false);
if ($action == 'fixed') {
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
     if ($row['action'] == 'decline') {
        $data['department'] = $row['department'];
        $id = MySQLAction($data,'formular_actions',0,$edit_type,false);
     } 
  }  
}  

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 