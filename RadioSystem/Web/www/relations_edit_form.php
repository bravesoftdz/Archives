<?php 

// ��������� �������

if ($_GET['obj']=='region') {   // ����� �������
  if (isset($_GET['i'])) {$link_i = "&i=".$_GET['i']; $elem_i = "_".$_GET['i'];}
  
  $label="�������� �������";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=area".$link_i; // ��������� ����
  
  $sql="SELECT region,Id FROM regions ORDER BY region";
  $query=mysql_query($sql) or die(mysql_error());
  $list[] = array ('value'=>'', 'display'=>'');
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    $list[] = array ('value'=>$row[1], 'display'=>$row[0]);
  }
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('region_id'.$elem_i,1))
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=regions&#039;,&#039;relations_edit&#039;);"
  );
}
  
if ($_GET['obj']=='area')  {    //�����
  if (isset($_GET['i'])) {$link_i = "&i=".$_GET['i']; $elem_i = "_".$_GET['i'];}

  $label="�������� �����";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=settlement".$link_i; // ��������� ����
  
  $sql="SELECT area,Id FROM areas WHERE region_id=".GetFromPrvForm('select',1)." ORDER BY area";
  $query=mysql_query($sql) or die(mysql_error());
  $list[] = array ('value'=>'', 'display'=>'');
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    $list[] = array ('value'=>$row[1], 'display'=>$row[0]);
  }
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('area_id'.$elem_i,2))
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=areas&#039;,&#039;relations_edit&#039;);"
  );
}  
        
if ($_GET['obj']=='settlement')  {    //��������� �����
  if (isset($_GET['i'])) {$link_i = "&i=".$_GET['i']; $elem_i = "_".$_GET['i'];}

  $label="�������� ��������� �����";  // ���������
  $action="relations_edit.php?ff=".$_GET['ff']."&obj=settlement".$link_i; // ��������� ����
  
  $sql="SELECT CONCAT(type,' ',settlement) as settlement,Id FROM settlements WHERE area_id=".GetFromPrvForm('select',1)." ORDER BY settlement";
  $query=mysql_query($sql) or die(mysql_error());
  $list[] = array ('value'=>'', 'display'=>'');
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    $list[] = array ('value'=>$row[1], 'display'=>$row[0]);
  }
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('settlement_id'.$elem_i,3))
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=settlements&#039;,&#039;relations_edit&#039;);"
  );  
}

if ($_GET['obj']=='budget_year') {   // ����� ���� �������
  $label="�������� ���";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_type"; // ��������� ����
  
  $list = array (
    array ('value'=>'', 'display'=>'')
  ); 
  for ($i=date(Y)-3; $i<date(Y)+4; $i++) {
    $list[] = array ('value' => $i, 'display' => $i);
  }  
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('budget_year',1))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='budget_type') {   // ����� ���� �������
  $label="�������� ���";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_type_g"; // ��������� ����
  
  $list = array (
    array ('value'=>'', 'display'=>'')
   ,array ('value'=>'2g', 'display'=>'2g')
   ,array ('value'=>'3g', 'display'=>'3g')
   ,array ('value'=>'2g/3g', 'display'=>'2g/3g')
  ); 
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('technology_generation',2))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='budget_type_2g') {   // ����� ���� ������� 2G
  $label="�������� ��� 2G";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_number_2g"; // ��������� ����
  
  $list = array (
    array ('value'=>'', 'display'=>'')
   ,array ('value'=>'������', 'display'=>'������')
   ,array ('value'=>'������', 'display'=>'������')
   ,array ('value'=>'���������', 'display'=>'���������')
   ,array ('value'=>'��������-������', 'display'=>'��������-������')
   ,array ('value'=>'�����������', 'display'=>'�����������')
  ); 
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('budget_type_2g',3))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='budget_number_2g') {   // ����� ������ ������� 2G
  $label="�������� ����� 2G";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_type_g"; // ��������� ����
  
  $list = BudgetFreeNumbers('2g',GetFromPrvForm('select',3),GetFromPrvForm('select',1),GetFromPrvForm('budget_number_2g',4));
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('budget_number_2g',4))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='budget_type_3g') {   // ����� ���� ������� 3G
  $label="�������� ��� 3G";  // ���������
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_number_3g"; // ��������� ����
  if (GetFromPrvForm('select',3)=='2g/3g') $offset=5; else $offset=3;
  
  $list = array (
    array ('value'=>'', 'display'=>'')
   ,array ('value'=>'������', 'display'=>'������')
   ,array ('value'=>'������', 'display'=>'������')
   ,array ('value'=>'���������', 'display'=>'���������')
   ,array ('value'=>'��������-������', 'display'=>'��������-������')
   ,array ('value'=>'�����������', 'display'=>'�����������')
  ); 
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('budget_type_3g',$offset))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='budget_number_3g') {   // ����� ������ ������� 3G
  $label="�������� ����� 3G";  // ���������
  if (GetFromPrvForm('select',4)=='2g/3g') $offset=6; else $offset=4;
  $action="redirect.php?f=4&ff=".$_GET['ff']."&obj=budget_type_g"; // ��������� ����
  
  $list = BudgetFreeNumbers('3g',GetFromPrvForm('select',$offset-1),GetFromPrvForm('select',$offset-3),GetFromPrvForm('budget_number_3g',$offset));
  $info[] = $info1 = array (
     'value' => PrvFill('select',GetFromPrvForm('budget_number_3g',$offset))
    ,'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

if ($_GET['obj']=='doc_link') {   // �������� ��������� ������
  $label="�������� �����";  // ���������
  $action="relations_edit.php?ff=".$_GET['ff']."&obj=doc_link&i=".$_GET['i']; // ��������� ����
  $bt_label="���������";
  $enctype="enctype='multipart/form-data'";
  $info[] = $info1 = array (
     'el_type' => 'file'
    ,'id' => 'select_field'
    ,'name' => 'select'
    ,'required' => true
  );
}

if ($_GET['obj']=='form_1bs_link' || $_GET['obj']=='agreem_link' || $_GET['obj']=='form_rrl_link') {   // �������� ��������� ��������
  $label="�������� �����";  // ���������
  $action="relations_edit.php?ff=".$_GET['ff']."&obj=".$_GET['obj']; // ��������� ����
  $bt_label="���������";
  $enctype="enctype='multipart/form-data'";
  $info[] = $info1 = array (
     'el_type' => 'file'
    ,'id' => 'select_field'
    ,'name' => 'select'
    ,'required' => true
  );
}

if ($_GET['obj']=='bts_number') {   // ����� ������ ��
  $label="�������� ����� ��";  // ���������
  $action="relations_edit.php?ff=".$_GET['ff']."&id=".$_GET['id']."&obj=bts_number"; // ��������� ����
  
  $list = BtsFreeNumbers();
  $info[] = $info1 = array (
     'el_type' => 'select'
    ,'id' => 'select_field_medium'
    ,'name' => 'select'
    ,'list' => $list
    ,'required' => true
  );
}

// ����� ��������
echo "  <div id='left_indent'>";
echo "    <div align='right'>$label:&nbsp&nbsp&nbsp;</div>";
echo "  </div>";
echo "  <div id='right_indent'>";
echo "    <form $enctype action='$action' method='post' id='relations_edit'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "    <p><button type='submit'>".($bt_label? $bt_label : '�������')."</button></p></form>";
echo "  </div>";
?>