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
   'focl_2g' => (isset($_POST['focl_2g'])? 1 : '')
  ,'rent_2g' => (isset($_POST['rent_2g'])? 1 : '')
  ,'focl_3g' => (isset($_POST['focl_3g'])? 1 : '')
  ,'rent_3g' => (isset($_POST['rent_3g'])? 1 : '')
);

$id = MySQLAction($data,'bts',$id,$edit_type,true);

// ADDITIONAL EDIT
$fields = array (
   'Id'
  ,'bts_id_point1'
  ,'height_point1'
  ,'diam_point1'
  ,'azimuth_point1'
  ,'bts_id_point2'
  ,'height_point2'
  ,'diam_point2'
  ,'azimuth_point2'
  ,'fr_range'
  ,'equipment'
  ,'stream_work'
  ,'stream_total'
  ,'reserve'
);
SlaveTableUpdate($_POST,'rrl','bts_id_point1',$id,$fields,true);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 