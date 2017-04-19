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
  echo "    <div>Выполняется расчёт...ждите</div>";
  echo "  <img src='../../pics/loading.gif' width='60' height='60'>";
  echo "  </div>";
  echo "</div>";
  $link="process.php?alias=".$_GET['alias']."&id=".$_GET['id']."&done";
  $_SESSION['file_type'] = $_POST['file_type'];
  
  // перенос файлов
  $i = 0;
  unset($_SESSION['file']);
  foreach ($_FILES as $key => $value) {
    $i++;
    if (!empty($_FILES['input_file'.$i]['tmp_name']) ) {  
      $uploaddir = '../../files/temp/';
      $uploadfile = $uploaddir.uniqid().".csv";
      move_uploaded_file($_FILES['input_file'.$i]['tmp_name'], $uploadfile);
      $_SESSION['file']['input_file'.$i]['tmp_name'] = $uploadfile;
    }
  }
}


// обработка данных - done
if (isset($_GET['done']) ) {
  $direction = array();
  $att = array();
  $link = $_SESSION['sections'][count($_SESSION['sections'])-1]['link'];
  if ($_SESSION['file_type']=='3g') {$bs1key=2; $bs2key=8; $attkey=13;}
  if ($_SESSION['file_type']=='2g') {$bs1key=4; $bs2key=7; $attkey=11;}

  for ($i=1; $i<7; $i++) {
    if (!empty($_SESSION['file']['input_file'.$i]['tmp_name']) ) {
      if (($handle = fopen($_SESSION['file']['input_file'.$i]['tmp_name'], "r")) !== FALSE) {
        while (($csv_row = fgetcsv($handle, 0, ";")) !== FALSE) {
      
          $key = array_search($csv_row[$bs1key].'::'.$csv_row[$bs2key],$direction); 
          if (!$key) $key = array_search($csv_row[$bs2key].'::'.$csv_row[$bs1key],$direction);
      
          if ($key) $att[$key]+= $csv_row[$attkey]; 
      
          if (!$key) {
            $direction[] = $csv_row[$bs1key].'::'.$csv_row[$bs2key];
            $att[] = $csv_row[$attkey];
          }  
        }
      }
      fclose($handle);
    }
  }

  // запись результата в файл
  $file = "/files/tasks/".$_GET['alias']."_".uniqid().".csv";
  $fp = fopen($path.$file, 'w');
  foreach($direction as $key => $value) {
    $line = explode("::", $value);
    $line[] = $att[$key];
    fputcsv($fp, $line, ';');
  }
  fclose($fp);
  
  // обновление БД
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