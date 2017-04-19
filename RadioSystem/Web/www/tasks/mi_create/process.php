<?php
set_time_limit(60*10);
ini_set("memory_limit", "256M"); 

$path = $_SERVER['DOCUMENT_ROOT'];
include_once($path.'/config.php');
include_once($path.'/functions.php');
session_start();


// анимация
if (!isset($_GET['done']) ) {
  echo "<div style='display: table; height: 80%; width: 100%;  text-align: center;'>";
  echo "  <div style='display: table-cell; vertical-align: middle;'>";
  echo "    <div>Создаётся слой...ждите</div>";
  echo "  <img src='../../pics/loading.gif' width='60' height='60'>";
  echo "  </div>";
  echo "</div>";
  $link="process.php?alias=".$_GET['alias']."&id=".$_GET['id']."&done";
  
  // перенос файлов
  $i = 0;
  foreach ($_FILES as $key => $value) {
    $i++;
    if (!empty($_FILES['input_file'.$i]['tmp_name']) ) {  
      $uploaddir = '../../files/temp/';
      $uploadfile = $uploaddir."mi_create_".uniqid().".csv";
      move_uploaded_file($_FILES['input_file'.$i]['tmp_name'], $uploadfile);
      $_SESSION['file']['input_file'.$i]['tmp_name'] = $uploadfile;
    }
  }
  $_SESSION['bts_field'] = 'bts:';
  $_SESSION['geo_field'] = 'geo:';
  $filcount = 0;
  for ($i=0;$i<$_SESSION['col_count'];$i++) {
    if ($_POST['geo_'.$i] == 'bts') {$_SESSION['bts_field'].= $i.':'; $filcount++;}
    if ($_POST['geo_'.$i] == 'geo') {$_SESSION['geo_field'].= $i.':'; $filcount++;}
  }
  if (($_SESSION['layer_type'] == 'point' && $filcount<1) || ($_SESSION['layer_type'] == 'line' && $filcount<2)) {
  echo "ошибка...некорректно заполнены параметры<br><a href='../../index.php?f=29&alias=".$_GET['alias']."&id=".$_GET['id']."'>назад</a>";
  exit;
  }
  
}


// обработка данных - done
if (isset($_GET['done']) ) {
  $link="../../index.php?f=29&alias=".$_GET['alias']."&id=".$_GET['id'];
  
  exec("$path/bats/mi_create.bat $path/".$_SESSION['file']['input_file'.$i]['tmp_name']." ".$_SESSION['bts_field']." ".$_SESSION['geo_field']." ".$_SESSION['layer_type']); 
    
  // обновление БД
  $file = str_replace(".csv", ".rar", $_SESSION['file']['input_file'.$i]['tmp_name']);
  $file = str_replace("temp", "tasks", $file);
  $data = array (
    'last_date' => date('Y-m-d H:i:s')
   ,'file_link' => $file
  );
  MySQLAction($data,'tasks',$_GET['id'],'update',true);
}  
  

?> 
<script type="text/javascript" src="../../flot/jquery.js"></script>

<script>
$(document).ready(function (){
  setTimeout(function () {
    var param = '<?php echo $link;?>';
    document.location.href=param;
  } , 1000)
});
</script> 