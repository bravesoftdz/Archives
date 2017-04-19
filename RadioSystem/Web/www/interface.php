<?php
function InfoBlock($el_id,$info,$label='',$table=array()) { // ����������� ���� ����
  $temp = $table;
  for ($i=0; $i<count($temp[0]); $i++) {$temp[0][$i]='';}
  for ($i=0; $i<count($temp); $i++) {$temp[$i][0]='';}
  
  if (!CheckEmptyValues($info) || !CheckEmptyValues($temp) ) { // ���� �� ������ ��������, �� ���������
    echo "<div id='$el_id'>";
    
    if (!empty($label)) echo "<b>$label</b>$sw<br>";  // label  ���������
    
    for ($i=0;$i<count($info);$i++) {
      if ($s>0 && CheckEmptyValues(array($info[$i]))==false) echo "<br>"; // ������ ������� ����� 1-�� � ����� ������
      foreach ($info[$i] as $key => $value) {
        if (strlen($key)>0) $key="$key:";
        if (strlen($value)>0) {
          echo "<b>$key</b> <i>$value</i><br>";
          $s++;
        }            
      }
    }    
    if (count($table)>0) {    // ��� �������
      if (!CheckEmptyValues($temp)) {
        echo "<br><table id='additional_table'>";
        for ($i=0; $i<count($table); $i++) {
          if (!CheckEmptyValues($temp[$i],1) || $i == 0) {
            echo "<tr>";
            for ($j=0 ;$j<count($table[$i]); $j++) {
              echo "<td id='ad_td'>";
              $start_style="<i>"; $end_style="</i>";
              if ($i==0) {$start_style="<b>"; $end_style="</b>";}
              if ($j==0 && $el_id!='bts_ad_info_block') {$start_style="<b>"; $end_style="</b>";}
              echo $start_style;
              echo $table[$i][$j];
              echo $end_style;
              echo "</td>";
            }
            echo "</tr>";
          }
        }
        echo "</table>";
      }
    }
    
    echo "</div>";
  }
}

function ActionBlock($info) { // ������ ������ �������� ��������������
  echo "<div id='actions_list'>";
  foreach ($info as $key => $value) {
    
    if ($key=="�������� ID �������") {
      $onclick = "onclick='confirmDelete(&#039;$value&#039;,&#039;&#039;);'";
      $value = "#";
    }
    
    echo "<a href='$value' id='button_ed' $onclick><div id='text_in_button_parent'><div id='text_in_button_child'>$key</div></div></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
  }
  echo "</div>";
}

function AdInfoBlock($info) { // ������ ������ �������� ���. ����������
  echo "<div id='info_list'>";
  foreach ($info as $key => $value) {
    echo "<a href='$value' id='button_info'><div id='text_in_button_parent'><div id='text_in_button_child'>$key</div></div></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
  }
  echo "</div>";
}

function FieldName($info) { // �������� ����
  foreach ($info as $key => $value) {
    if ($key == 'field') {echo "<div name='label_".$info['name']."'>$value</div>"; $field_exist = true;}
    if ($key == 'el_type' && $value == 'break' && !$field_exist) {
      echo "<div>&nbsp;</div>";
    } 
  }  
}

function FieldEdit($info) { // �������� ����
  foreach ($info as $key => $value) {
    if ($key == 'field') $field = $value;
    if ($key == 'el_type') $el_type = $value;
    if ($key == 'id') $id = $value;
    if ($key == 'name') $name = $value;
    if ($key == 'list') $list = $value;
    if ($key == 'value') $fvalue = $value;
    if ($key == 'required' && $value == true) $required = 'required';
    if ($key == 'disabled' && $value == true) {$disabled = 'disabled';}
    if ($key == 'hidden' && $value == true) {$hidden = 'hidden';}
    if ($key == 'start_line' && $value == true) $start_line=true;
    if ($key == 'end_line' && $value == true) $end_line=true;
    if ($key == 'ad_edit') $ad_edit=$value;
    if ($key == 'ad_search') $ad_search=$value;
    if ($key == 'ad_delete') $ad_delete=$value;
    if ($key == 'pattern') $pattern = "pattern='$value'";
    if ($key == 'show_field') $show_field = true;
    if ($key == 'onclick') $onclick = "onclick='$value'";
  } 
  if (isset($end_line)) {} else {echo "<div>";}
  
  // ������� ����
  if ($show_field == true) {
    echo "<div id='label'>$field</div>";
  }
  
  // ��� select
  if ($el_type == 'select') {
    echo "<select size='1' id='$id' name='$name' $required $disabled>";
    for ($i=0;$i<count($list);$i++) {
      foreach ($list[$i] as $key => $value) {
        if ($key == 'value') $ovalue = $value;
        if ($key == 'display') $display = $value;
      }
      if ($ovalue == $fvalue) {$selected = 'selected';} else {$selected = '';}
      echo "<option $selected value='$ovalue'>$display</option>";  
    }  
    echo "</select>";
  }
  
  // ��� text
  if ($el_type == 'text') {
    echo "<input type='text' value='$fvalue' id='$id' name='$name' $required $disabled $hidden $pattern>";
  }
  
  // ��� textarea
  if ($el_type == 'textarea') {
    echo "<textarea id='$id' name='$name' $required $disabled>$fvalue</textarea>";
  }
  
  // ��� break
  if ($el_type == 'break') {
    echo "&nbsp;";
  }
  
  // ��� date
  if ($el_type == 'date') {
    echo "<input type='date' value='$fvalue' id='$id' name='$name' $required $disabled $pattern>";
  }
  
  // ��� link
  if ($el_type == 'link' && empty($fvalue)==false) {
    echo "<a href='$fvalue' title='�������' target='_blank' type='application/pdf' download style='line-height:2.3;'><img src='pics/download_pic.jpg' width='16' height='16'></a>";  
  }
  
  // ��� file
  if ($el_type == 'file') {
    echo "<input type='file' id='$id' name='$name' $required $disabled $pattern>";  
  }
  
  // ��� checkbox
  if ($el_type == 'checkbox') {
    if ($fvalue==1) {$checked='checked';} else {$checked='';}
    echo "<input type='checkbox' value='$fvalue' id='$id' name='$name' $onclick $checked $required $disabled>";  
  }
  
  // ���. ��������������
  if (isset($ad_edit)) echo "&nbsp;<a href='#' title='�������������' onclick='$ad_edit'><img src='pics/edit_pic.jpg' width='16' height='16'></a>";

  // ���. �����
  if (isset($ad_search)) echo "&nbsp;<a href='#' title='�����' onclick='$ad_search'><img src='pics/search_pic.png' width='16' height='16'></a>";
 
  // ���. ��������
  if (isset($ad_delete)) echo "&nbsp;<a href='#' title='�������' onclick='$ad_delete'><img src='pics/delete_pic.png' width='16' height='16'></a>";
 
  // ��������� ������� ����� ���� disabled
  if (isset($disabled)) echo "<input type='text' value='$fvalue' id='$id' name='$name' hidden $required>";
  
  if (isset($start_line)) {} else {echo "</div>";}
}
?>