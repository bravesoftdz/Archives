<?php
include_once('config.php');
include_once('functions.php');
session_start();

// входные параметры
$id=$_GET['id'];

$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
$edit_type='update';

// основной запрос
$data = array (
   'link_bts_id' => $_POST['link_bts_id']
  ,'link_type' => $_POST['link_type']
  ,'divider_type' => $_POST['divider_type']
  ,'incut_place' => $_POST['incut_place']
);

$id = MySQLAction($data,'repeaters',$id,$edit_type,true);

// ADDITIONAL EDIT
$fields = array (
   'Id'
  ,'num' 
  ,'repeater_link_id'
  ,'antenna_type_id'
  ,'height'
  ,'azimuth'
  ,'cable_type'
  ,'notes'
);
SlaveTableUpdate($_POST,'repeater_sectors','repeater_link_id',$id,$fields,true);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 
                                                                                                                                                                                                                                                                                                