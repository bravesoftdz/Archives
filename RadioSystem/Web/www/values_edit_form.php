<?php 
$editlist=$_GET['obj'];
    
if ($editlist=='regions')
  {
  $table='regions';
  $field='region';
  $field_title='�������';
  $cond='';
  }
if ($editlist=='areas')
  {
  $table='areas';
  $field='area';
  $field_title='�����';
  $cond='';
  }  
if ($editlist=='settlements')
  {
  $table='settlements';
  $field='settlement';
  $field_title='��������� �����';
  $cond='';
  }   
if ($editlist=='construction_2g_types')
  {
  $table='construction_2g_types';
  $field='construction_type';
  $field_title='��� ������������������ 2G';
  }   
if ($editlist=='construction_3g_types')
  {
  $table='construction_3g_types';
  $field='construction_type';
  $field_title='��� ������������������ 3G';
  }   
if ($editlist=='construction_4g_types')
  {
  $table='construction_4g_types';
  $field='construction_type';
  $field_title='��� ������������������ 4G';
  }    
if ($editlist=='power_types')
  {
  $table='power_types';
  $field='power_type';
  $field_title='��� �������';
  }       
if ($editlist=='gsm_configs')
  {
  $table='gsm_configs';
  $field='gsm_config';
  $field_title='��� ������������ gsm';
  }      
if ($editlist=='dcs_configs')
  {
  $table='dcs_configs';
  $field='dcs_config';
  $field_title='��� ������������ dcs';
  }  
if ($editlist=='umts_configs')
  {
  $table='umts_configs';
  $field='umts_config';
  $field_title='��� ������������ umts';
  }    
if ($editlist=='lte_configs')
  {
  $table='lte_configs';
  $field='lte_config';
  $field_title='��� ������������ lte';
  }    
if ($editlist=='antenna_types')
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='��� �������';
  $cond='';
  }
if ($editlist=='build_organizations')
  {
  $table='build_organizations';
  $field='title';
  $field_title='������������ �����������';
  $cond='';
  }   
if ($editlist=='project_organizations')
  {
  $table='project_organizations';
  $field='title';
  $field_title='��������� �����������';
  $cond='';
  }   
if ($editlist=='agreement_persons')
  {
  $table='agreement_persons';
  $field='name';
  $field_title='������������ �� ��������';
  $cond='';
  }       
if ($editlist=='build_persons')
  {
  $table='build_persons';
  $field='name';
  $field_title='������������ �� �������������';
  $cond='';
  }   
if ($editlist=='repeater_types')
  {
  $table='repeater_types';
  $field='repeater_type';
  $field_title='��� ����������� ������������';
  }        
  
echo "<div id='object_edit'><div id='left_indent'>";
if ($editlist=='settlements') {echo "<div align='right'>���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>";$field='settlement,type';}
if ($editlist=='antenna_types') {echo "<div align='right'>���&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>";$field='antenna_type,tech_type';}
echo "<div align='right'>$field_title&nbsp;&nbsp;&nbsp;&nbsp;</div>";
echo "</div>";

echo "<div id='right_indent'>";
echo "<form action='values_edit.php?obj=$table&id=".$_GET['id']."' method='post'>";

if ($_GET['id']>0)
  {
  $sql="SELECT $field FROM $table WHERE id=".$_GET['id'];
  $query=mysql_query($sql) or die(mysql_error());
  $row = mysql_fetch_array($query);
  $value=$row[0];
  $caption="���������";
  }
  else
  {
  $caption="��������";
  }
  
if ($editlist=='settlements')
  {
  echo "<div><select size='1' id='select_field_small' name='type'>";
  if ($row[1]=='�����') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='�����'>�����</option>";
  if ($row[1]=='������') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='������'>������</option>";
  if ($row[1]=='����') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='����'>����</option>";
  if ($row[1]=='���������') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='���������'>���������</option>";
  if ($row[1]=='������') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='������'>������</option>";
  if ($row[1]=='�������') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='�������'>�������</option>";
  echo "</select></div>";
  } 
if ($editlist=='antenna_types')
  {
  echo "<div><select size='1' id='select_field_small' name='type' required>";
  if ($row[1]=='') {$selected='selected';} else {$selected='';}
  echo "<option $selected value=''></option>";
  if ($row[1]=='gsm') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='gsm'>gsm</option>";
  if ($row[1]=='dcs') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='dcs'>dcs</option>";
  if ($row[1]=='2g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='2g'>2g</option>";
  if ($row[1]=='3g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='3g'>3g</option>";
  if ($row[1]=='4g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='4g'>4g</option>";
  echo "</select></div>";
  }   
         
echo "<div><input type='text' value='$value' size='40' name='record'></div>";
echo "<p><button type='submit'>$caption</button></p>";
echo "</form></div></div>";
?>