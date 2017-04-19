<?php    
include_once('config.php');
include_once('functions.php');
session_start();        
        
// входные параметры
$id=$_GET['id'];
$bts_id=$_GET['bts_id'];
$function = $_SESSION['function'];
if ($function == 'отметка разрешени€ Ѕел√»Ё') $is_belgie = true;
if ($function == 'отметка јктов ввода в эксплуатацию') $is_act = true; 

$link=$_SESSION['sections'][count($_SESSION['sections'])-2]['link'];
                     
// провер€ем и создаЄм запись switchings
if (empty($_GET['id'])) {
  $sql = "INSERT INTO switchings SET bts_id='$bts_id'";
  $query = mysql_query($sql) or die(mysql_error());
  $id = mysql_insert_id(); 
}
// основной запрос    
function DateOrOn($date,$on,$val) { 
  if (strtotime($date)) return $date;
  else {
    if (isset($on)) return $val;
  }
}
if ($is_belgie) {
    $data = array (
       'bts_id' => $bts_id
      ,'belgei_2g' => DateOrOn($_POST['belgei_2g_date'],$_POST['belgei_2g_got'],'got')
      ,'belgei_3g' => DateOrOn($_POST['belgei_3g_date'],$_POST['belgei_3g_got'],'got')
      ,'belgei_3g9' => DateOrOn($_POST['belgei_3g9_date'],$_POST['belgei_3g9_got'],'got')
    );
}
else if ($is_act) {
    $data = array (
       'bts_id' => $bts_id
      ,'act_2g' => DateOrOn($_POST['act_2g_date'],$_POST['act_2g_got'],'got')
      ,'act_3g' => DateOrOn($_POST['act_3g_date'],$_POST['act_3g_got'],'got')
      ,'act_3g9' => DateOrOn($_POST['act_3g9_date'],$_POST['act_3g9_got'],'got')
    );
}
else {
    $data = array (
       'bts_id' => $bts_id
      ,'belgei_2g' => DateOrOn($_POST['belgei_2g_date'],$_POST['belgei_2g_got'],'got')
      ,'act_2g' => DateOrOn($_POST['act_2g_date'],$_POST['act_2g_got'],'got')
      ,'gsm' => DateOrOn($_POST['gsm_date'],$_POST['gsm_on'],'on')
      ,'dcs' => DateOrOn($_POST['dcs_date'],$_POST['dcs_on'],'got')
      ,'belgei_3g' => DateOrOn($_POST['belgei_3g_date'],$_POST['belgei_3g_got'],'got')
      ,'act_3g' => DateOrOn($_POST['act_3g_date'],$_POST['act_3g_got'],'got')
      ,'umts2100' => DateOrOn($_POST['umts2100_date'],$_POST['umts2100_on'],'on')
      ,'belgei_3g9' => DateOrOn($_POST['belgei_3g9_date'],$_POST['belgei_3g9_got'],'got')
      ,'act_3g9' => DateOrOn($_POST['act_3g9_date'],$_POST['act_3g9_got'],'got')
      ,'umts900' => DateOrOn($_POST['umts900_date'],$_POST['umts900_on'],'on')
      ,'lte' => DateOrOn($_POST['lte_date'],$_POST['lte_on'],'on')
      ,'stat' => DateOrOn($_POST['stat_date'],$_POST['stat_got'],'got')
      ,'uninstall' => DateOrOn($_POST['uninstall_date'],$_POST['uninstall_got'],'got')
      ,'is_on' => $_POST['is_on']
    );
}

$id = MySQLAction($data,'switchings',$id,'update',true);     

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 