<?php
if (isset($_GET['update']) ) $update = '&update';

/////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isset($_GET['step1']) ) {  // шаг 1 - загрузка файла
  // входные параметры
  
  $sql="SHOW TABLES";
  $query=mysql_query($sql) or die(mysql_error());
  $list = array (array ('value'=>'', 'display'=>'') );
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    if (stripos($row[0],'user')===false ) $list[] = array ('value'=>$row[0], 'display'=>$row[0]);
  }
  $info[] = $info1 = array (
     'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'import_table'
    ,'list' => $list
    ,'start_line' => true
    ,'end_line' => true
    ,'required' => true
  );

  // вывод элементов интерфейса 
  echo "<form action='index.php?f=15$update&step2' method='post' id='import_params'>";
  echo "выберите таблицу дл€ импорта:&nbsp;&nbsp;&nbsp;";
  FieldEdit($info[0]);
  echo "&nbsp;&nbsp;&nbsp;";
  echo "<input type='submit' value='выбрать'>";
  echo "</form>";
}
////////////////////////////////////////////////////////////////////////////////////////////////////
if (isset($_GET['step2']) ) {  // шаг 2 - загружаем файл

  $_SESSION['import_table']=$_POST['import_table'];
  $sql = 'SHOW COLUMNS FROM '.$_POST['import_table'];
  $query=mysql_query($sql) or die(mysql_error());
  for ($i=0; $i<mysql_num_rows($query); $i++ ) {
    $row = mysql_fetch_array($query);
    $line.= $row[0].';';  
  }
  $file = "files/temp/import_template_$user_id.csv";
  file_put_contents($file, $line);
  
  // формируем элементы
  $info[] = $info1 = array (
     'el_type' => 'file'
    ,'id' => 'select_field'
    ,'name' => 'import_file'
    ,'start_line' => true
    ,'end_line' => true
    ,'required' => true
  );
  
  // вывод элементов интерфейса 
  echo "<form action='index.php?f=15$update&step3' method='post' id='import_params' enctype='multipart/form-data'>";
  echo "выберите файл импорта:&nbsp;&nbsp;&nbsp;";
  FieldEdit($info[0]);
  echo "&nbsp;&nbsp;&nbsp;";
  echo "<input type='submit' value='загрузить'>";
  echo "</form>";
  echo "<p>";
  echo "cкачать шаблон:&nbsp;&nbsp;&nbsp;<a href='$file' type='text/csv' download><img src='pics/download_pic.jpg' width='16' height='16'></a>";
  echo "</p>";
}
///////////////////////////////////////////////////////////////////////////////////////////////////
if (isset($_GET['step3']) ) {  // шаг 3 - выбираем соотношение полей
  
  // входные параметры
  if (!empty($_FILES['import_file']) ) {
    unset($_SESSION['csv']);
    if (($handle = fopen($_FILES['import_file']['tmp_name'], "r")) !== FALSE) {
      while (($csv_row = fgetcsv($handle, 0, ";")) !== FALSE) {
        $_SESSION['csv'][] = $csv_row; 
      }
    }
    fclose($handle);
  }
  
  // settlement
  $csv=$_SESSION['csv'];
  for ($i=0; $i<count($csv[0]); $i++) {
    if ($csv[0][$i] == 'settlement_id') {
      for ($j=1; $j<count($csv); $j++) {
        $full_set = explode(";",$csv[$j][$i]);
        if (!is_numeric($full_set[0]) ) {
          $sql = "SELECT settlements.Id FROM settlements,areas WHERE settlements.area_id=areas.id AND settlement = '$full_set[2]' AND area = '$full_set[1]'";
          $query = mysql_query($sql) or die(mysql_error());
          $row = mysql_fetch_array($query);
          if (!empty($row[0]) ) {
            $_SESSION['csv'][$j][$i] = $row[0];
            $csv[$j][$i] = $row[0];
          } else {
            $_SESSION['csv'][$j][$i] = 'не найден';
            $csv[$j][$i] = 'не найден';
          }
        }
      }  
    }
  }
  
  $sql = "SHOW COLUMNS FROM ".$_SESSION['import_table'];
  $query = mysql_query($sql) or die(mysql_error());
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    $fields[] = $row[0];
  }
  
  $sql = "SHOW TABLES";
  $query = mysql_query($sql) or die(mysql_error());
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    $tables[] = $row[0];
  }
  
  // вывод элементов интерфейса 
  echo "<form action='index.php?f=15$update&step4' method='post' id='import_params'>";
  echo "<table id='result_table'>";
  
  for ($i=0; $i<count($csv[0]); $i++) {
    
    $value=PrvFill("import_field_$i",$csv[0][$i]); // выбор подход€щего значени€ из списка и цвета
    $selected_num = -1;
    for ($j=0; $j<count($fields); $j++) {
      if ($value == $fields[$j]) {$selected_num = $j;}
    }
    if ($selected_num == -1) {$warning = "style='background: #ffd0e0;'";} else {$warning = "";}

    $lw=substr($value,strripos($value,'_')+1,strlen($value) ); // выбор св€занной таблицы, если текущее id
    $rest=substr($value,0,strripos($value,'_'));
    if ($lw == 'id') {
      $sql = "SHOW TABLES LIKE '%$rest%'";
      $query = mysql_query($sql) or die(mysql_error());
      $row = mysql_fetch_array($query);
      $value = PrvFill("adtable_import_$i",$row[0]);
      $adtbl_selected_num = -1;
      for ($j=0; $j<count($tables); $j++) {
        if ($value == $tables[$j]) {$adtbl_selected_num = $j;}
      }
      if ($adtbl_selected_num == -1) {$warning = "style='background: #ffd0e0;'";} else {$warning = "";}

      if (!empty($value)) { // выбор доп. пол€
        $sql="SHOW COLUMNS FROM $value";
        $query=mysql_query($sql) or die(mysql_error());
        $value=PrvFill("adfield_import_$i","");
        $adfld_selected_num = -1;
        $adflds = array();
        for ($j=0; $j<mysql_num_rows($query); $j++) {
          $row = mysql_fetch_array($query);
          $adflds[] = $row[0];
          if ($value==$row[0]) {$adfld_selected_num = $j;}
        }
        if ($adfld_selected_num == -1) {$warning = "style='background: #ffd0e0;'";} else {$warning = "";}   
      }
    }
    
    echo "<tr $warning>";
    echo "<td id='rs_td'><a name='$i'></a><b>&nbsp;".$csv[0][$i]."</b>&nbsp;";
    
    $value = PrvFill("ext_key","");
    if ($value == $csv[0][$i]) {$checked = 'checked';} else {$checked = '';}
    if (isset($update)) echo "<input type='radio' name='ext_key' value='".$csv[0][$i]."' required $checked>ключ"; 
    
    echo "<br><select id='text_field_medium' name='import_field_$i' onchange='ad_edit(&#039;redirect.php?f=15$update&step=3&anchor=$i&#039;,&#039;import_params&#039;);'>";
    echo "<option></option>";
    
    for ($j=0; $j<count($fields); $j++) {
      if ($j == $selected_num) {$selected = 'selected';} else {$selected = '';}
      echo "<option $selected>$fields[$j]</option>";
    }
    echo "</select>";
    
    if ($lw == 'id') {
      echo "<br><select id='text_field_medium' name='adtable_import_$i' onchange='ad_edit(&#039;redirect.php?f=15$update&step=3&anchor=$i&#039;,&#039;import_params&#039;);'>";
      echo "<option></option>";
      for ($j=0; $j<count($tables); $j++) {
        if ($j == $adtbl_selected_num) {$selected = 'selected';} else {$selected = '';}
        echo "<option $selected>$tables[$j]</option>";
      }
      echo "</select>";
      
      if ($adtbl_selected_num > -1) { 
        echo "<br><select id='text_field_medium' name='adfield_import_$i' required onchange='ad_edit(&#039;redirect.php?f=15$update&step=3&anchor=$i&#039;,&#039;import_params&#039;);'>";
        echo "<option></option>";
        for ($j=0; $j<count($adflds); $j++) {
          if ($j == $adfld_selected_num) {$selected='selected';} else {$selected='';}
          echo "<option $selected>$adflds[$j]</option>";
        }
        echo "</select>";
      }  
    }
    
    echo "</td>";
    
    for ($j=1; $j<11; $j++) {
      echo "<td id='rs_td'>".$csv[$j][$i]."</td>";
    }
    echo "<td id='rs_td'>...</td>";
    echo "</tr>";
  }
  echo "</table>";
  echo "<p><input type='submit' value='применить'></p>";
  echo "</form>"; 
}
///////////////////////////////////////////////////////////////////////////////////////////////////
if (isset($_GET['step4']) ) {  // шаг 4 - проверка корректности
  // входные параметры
  $csv = $_SESSION['csv'];
  $table = $_SESSION['import_table'];
  
  if (!isset($_GET['update'])) unset($_SESSION['ext_key']);
  if (isset($_POST['ext_key']) && isset($_GET['update'])) $_SESSION['ext_key'] = $_POST['ext_key'];
  $ext_key = $_SESSION['ext_key'];
  if (!empty($ext_key)) $key = '?key='.$ext_key;
  
  if (isset($_POST["import_field_0"]) ) {
    $p = 0;
    for ($i=0; $i<count($csv[0]); $i++) {
      if(!empty($_POST["import_field_$i"]) ) {
      $import_params[$p]['field'] = $_POST["import_field_$i"];
      $import_params[$p]['col_num'] = $i;
      $import_params[$p]['adtable']=$_POST["adtable_import_$i"];
      $import_params[$p]['adfield']=$_POST["adfield_import_$i"];
      $p++;
      }
    }
    $_SESSION['$import_params'] = $import_params;
  }
  $import_params = $_SESSION['$import_params'];
  
  // вывод элементов интерфейса 
  echo "<form action='import.php$key' method='post' id='import_params'>";
  
  echo "<table id='result_table'>";
  // заголовки полей
  for ($i=0; $i<count($import_params); $i++) {
    echo "<tr>";
    echo "<td id='rs_td'><a name='$i'></a><b>";
    echo $import_params[$i]['field'];
    echo "</b></td>";
    $col_num = $import_params[$i]['col_num'];
    $field = $import_params[$i]['field'];
    $adfield = $import_params[$i]['adfield'];
    $adtable = $import_params[$i]['adtable'];
    
    // запрос на кол-во значений в поле
    $sql = "SELECT COUNT(DISTINCT $field) FROM $table";
    $query=mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $typical_volues = array ();
    if ($row[0]<13 && empty($adfield) ) {
      $sql = "SELECT DISTINCT $field FROM $table";
      $query=mysql_query($sql) or die(mysql_error());
      for ($j=0; $j<mysql_num_rows($query); $j++) {
        $row = mysql_fetch_array($query);
        $typical_volues[] = $row[0];
      }   
    }
    
    if (!empty($adfield) ) {   //запрос на список значений по id   
      $id_values = array ();
      $sql = "SELECT $adfield FROM $adtable $where GROUP BY $adfield";
      $query=mysql_query($sql) or die(mysql_error());
      for ($f=0; $f<mysql_num_rows($query); $f++) {
        $row = mysql_fetch_array($query);
        $id_values[] = (empty($row[0])? 'NULL' : $row[0]);
      }
    }  
    
    // значени€
    $values = array();  // массив сбора выведенных значений
    for ($j=1; $j<count($csv); $j++) {
      
      if (empty($csv[$j][$col_num]) ) $csv[$j][$col_num] = 'NULL';
      $warning = "";
      $edit_values_enabled = false;
      
      // рассчЄт значени€ из списка и цвет
      if (count($typical_volues)>0 && !in_array($csv[$j][$col_num], $values) ) {  //рассчЄт типовые значени€
        $value = PrvFill('select_value_'.$j.'_'.$col_num,$csv[$j][$col_num]);
        $selected_num = -1;
        if ($value == 'добавить значение') {$selected_num = -2;}
        for ($f=0; $f<count($typical_volues); $f++) {
          if (empty($typical_volues[$f]) ) $typical_volues[$f] = 'NULL';
          if ($value == $typical_volues[$f]) {$selected_num = $f;} 
        }
        if ($selected_num == -1 ) $warning = "style='background: #ffd0e0;'";  
      }
           
      if (!empty($adfield) ) {  // расчЄт значений из списка по id
        $value = PrvFill('select_value_'.$j.'_'.$col_num,$csv[$j][$col_num]);
        $selected_num = -1;
        if (!in_array($csv[$j][$col_num],$id_values,true) ) {
          $edit_values_enabled=true;
          $selected_num = array_search($value,$id_values,true);
          if ($selected_num === false) $selected_num = -1;
          if ($value == 'добавить значение') {$selected_num = -2;}
          if ($value == 'не заносить') {$selected_num = -3;}
          if ($selected_num == -1 ) $warning = "style='background: #ffd0e0;'";
        }  
      } 
      
      if (!in_array($csv[$j][$col_num], $values)) { // вывод €чеки
        echo "<td id='rs_td' $warning>&nbsp;";
        echo $csv[$j][$col_num];
      
        if (count($typical_volues)>0 ) {              // список типичных значений
          echo "<br><select id='select_field_medium' name='select_value_".$j."_".$col_num."' required onchange='ad_edit(&#039;redirect.php?f=15$update&step=4&anchor=$i&#039;,&#039;import_params&#039;);'>";
          echo "<option></option>";
          if ($selected_num == -2) {$selected = 'selected';} else {$selected = '';}
          echo "<option $selected>добавить значение</option>";
          echo "<optgroup label='типичные значени€'>";
          for ($f=0; $f<count($typical_volues); $f++) {
            if ($selected_num == $f) {$selected = 'selected';} else {$selected = '';}
            echo "<option $selected>$typical_volues[$f]</option>";
          }
          echo "</optgroup>";
          echo "</select>";
        }
        
        if ($edit_values_enabled) {              // список значений по id
          echo "<br><select id='select_field_medium' name='select_value_".$j."_".$col_num."' required onchange='ad_edit(&#039;redirect.php?f=15$update&step=4&anchor=$i&#039;,&#039;import_params&#039;);'>";
          echo "<option></option>";
          if ($selected_num == -2) {$selected = 'selected';} else {$selected = '';}
          echo "<option $selected>добавить значение</option>";
          if ($selected_num == -3) {$selected = 'selected';} else {$selected = '';}
          echo "<option $selected>не заносить</option>";
          echo "<optgroup label='существующие значени€'>";
          for ($f=0; $f<count($id_values); $f++) {
            if ($selected_num == $f) {$selected = 'selected';} else {$selected = '';}
            echo "<option $selected>$id_values[$f]</option>";  
          }
          echo "</optgroup>";
          echo "</select>";
        }
        
        echo "</td>";      
        $values[] = $csv[$j][$col_num];
      }    
    }
    echo "</tr>"; 
  }  
  
  echo "</table>";
  echo "<p><input type='submit' value='применить'></p>";
  echo "</form>";
}
////////////////////////////////////////////////////////////////////////////////////////////////////
?> 