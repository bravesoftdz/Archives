<?php
include_once('config.php');
include_once('functions.php');
session_start();

$form_index=$_GET['ff'];

// бюджет
if ($_GET['obj']=='budget') {  
  if ($_GET['offset']>0) {$offset=$_GET['offset'];} else {$offset=4;}
  
  $_SESSION['sections'][$form_index]['form']['technology_generation']=$_SESSION['sections'][$form_index+2]['form']['select'];
  $_SESSION['sections'][$form_index]['form']['budget_year']=$_SESSION['sections'][$form_index+1]['form']['select'];
  
  if ($_SESSION['sections'][$form_index]['form']['technology_generation']=='2g') {
    $_SESSION['sections'][$form_index]['form']['budget_type_2g']=$_SESSION['sections'][$form_index+3]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_number_2g']=$_SESSION['sections'][$form_index+4]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_type_3g']='';
    $_SESSION['sections'][$form_index]['form']['budget_number_3g']='';
  }
  
  if ($_SESSION['sections'][$form_index]['form']['technology_generation']=='3g')  {
    $_SESSION['sections'][$form_index]['form']['budget_type_3g']=$_SESSION['sections'][$form_index+3]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_number_3g']=$_SESSION['sections'][$form_index+4]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_type_2g']='';
    $_SESSION['sections'][$form_index]['form']['budget_number_2g']='';
  }
  
  if ($_SESSION['sections'][$form_index]['form']['technology_generation']=='2g/3g') {
    $_SESSION['sections'][$form_index]['form']['budget_type_2g']=$_SESSION['sections'][$form_index+3]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_number_2g']=$_SESSION['sections'][$form_index+4]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_type_3g']=$_SESSION['sections'][$form_index+5]['form']['select'];
    $_SESSION['sections'][$form_index]['form']['budget_number_3g']=$_SESSION['sections'][$form_index+6]['form']['select'];
  }
  
  $link=$_SESSION['sections'][$form_index]['link'];
}

// населЄнный пункт
if ($_GET['obj']=='settlement') {
  if (isset($_GET['i'])) $elem_i = "_".$_GET['i']; 
  $_SESSION['sections'][$form_index]['form']['settlement_id'.$elem_i]=$_POST['select'];
  $link=$_SESSION['sections'][$form_index]['link']; 
}

// загрузка и ссылка на документ бюджет
if ($_GET['obj']=='doc_link') { 
  $uploaddir = 'files/agreement_lists/';
  $uploadfile = $uploaddir.uniqid()."_".basename($_FILES['select']['name']);
  move_uploaded_file($_FILES['select']['tmp_name'], $uploadfile);
  $_SESSION['sections'][$form_index]['form']['doc_link_'.$_GET['i']]=$uploadfile;
  $link=$_SESSION['sections'][$form_index]['link']; 
}

// загрузка и ссылка на документ формул€р
if ($_GET['obj']=='form_1bs_link' || $_GET['obj']=='agreem_link' || $_GET['obj']=='form_rrl_link') { 
  if ($_GET['obj']=='form_1bs_link') $uploaddir = 'files/form_1bs/';
  if ($_GET['obj']=='agreem_link') $uploaddir = 'files/form_agreement/';
  if ($_GET['obj']=='form_rrl_link') $uploaddir = 'files/form_rrl/';
  $uploadfile = $uploaddir.uniqid()."_".basename($_FILES['select']['name']);
  move_uploaded_file($_FILES['select']['tmp_name'], $uploadfile);
  $_SESSION['sections'][$form_index]['form'][$_GET['obj']]=$uploadfile;
  $link=$_SESSION['sections'][$form_index]['link']; 
}

// выбор номера Ѕ—
if ($_GET['obj']=='bts_number') {
  $sql = "SELECT bts_id FROM formulars WHERE id=".$_GET['id'];
  $query=mysql_query($sql) or die(mysql_error());
  $row = mysql_fetch_array($query);
  
  $sql = "UPDATE bts SET bts_number='".$_POST['select']."' WHERE id=".$row[0];
  $query=mysql_query($sql) or die(mysql_error());
  
  $link=$_SESSION['sections'][$form_index]['link']; 
}


?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script> 
                                                              