<?php
if (isset($_GET['type'])==false) {
  // ���� ������ ������ ������ ���� ����������
  $info=array (
     '���������� ABIS' => "index.php?f=10&type=abis"
    ,'���������� TRAU' => "index.php?f=10&type=trau"
    ,'���������� Channel Elements' => "index.php?f=10&type=ce"
    ,'���������� RAN Cell' => "index.php?f=10&type=rancell"
    ,'���������� RAN RNC' => "index.php?f=10&type=ranrnc"
    ,'���������� PCU + Gb Interface' => "index.php?f=10&type=pcu"
  );
  AdInfoBlock($info);
}

////////////////////////////////////////////////////////////////////////////////
// ���������� TRAU
if ($_GET['type']=='trau')
  {
  $id=$_POST['bsc_id'];
  
  // ���� ����� ������ BSC
  $sql="SELECT Id,bsc_number FROM bsc ORDER BY bsc_number"; 
  $query=mysql_query($sql) or die(mysql_error());
  
  echo "<div>";
  echo "<form action='index.php?f=10&type=trau' method='post' id='stat_params'>�������� BSC:&nbsp;&nbsp;&nbsp;";
  echo "<select size='1' id='select_field_medium' name='bsc_id'>";
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row=mysql_fetch_array($query); 
    if ($row[0]==$id) {$selected='selected';} else {$selected='';}
    echo "<option $selected value='$row[0]'>$row[1]</option>";
    }
  echo "</select>&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";
  echo "</div>";
   
  if ($id>0)
    {
    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}
    
    $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, seizure_traffic, outgoing_available FROM statistics_trau WHERE bsc_id=$id $date_cond ORDER BY stat_date"; 
    $query=mysql_query($sql) or die(mysql_error());
    for ($i=0; $i<mysql_num_rows($query); $i++)
      {
      $row=mysql_fetch_array($query); 
      $points[]=array($row['stat_date'],$row['outgoing_available']);
      $points2[]=array($row['stat_date'],$row['seizure_traffic']);
      $points3[]=array($row['stat_date'],$row['outgoing_available']*0.92);
      }
 
    //������ � ����������� �������
    $graph = array(
      array
        (
          'color'=>'rgb(0, 204, 51)'
        , 'data'=>$points
        , 'label'=>'outgoing available'
        ),
      array
        (
          'color'=>'rgb(255, 255, 102)'
        , 'data'=>$points3
        , 'label'=>'line 92%'
        ),    
      array
        (
          'color'=>'rgb(255, 98, 0)'
        , 'data'=>$points2
        , 'label'=>'seizure traffic'
        )  
    );
     
    }
  }
  
////////////////////////////////////////////////////////////////////////////////
// ���������� Channel Elements
if ($_GET['type']=='ce')
  {
  // ���� ����� ������ �� � LCG
  $bts_number=$_POST['bts_number'];
  $sql="SELECT Id FROM bts WHERE bts_number=".StrOrNull($bts_number); 
  $query=mysql_query($sql) or die(mysql_error());
  $row=mysql_fetch_array($query);
  $id=$row[0];
  
  echo "<div>";
  echo "<form action='index.php?f=10&type=ce' method='post' id='stat_params'>������� ����� ��:&nbsp;&nbsp;&nbsp;";
  echo "<input type='text' size='4' name='bts_number' value='$bts_number'>&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";
  
  $sql = "SELECT IFNULL(p1.lcg,0) as lcg, vendor, cell_list FROM (SELECT lcg FROM statistics_ce"; 
  $sql.= " WHERE bts_id=".NumOrNull($id)." GROUP BY lcg) p1";
  $sql.= " LEFT JOIN statistics_ce p2";
  $sql.= " ON p2.id=(SELECT id FROM statistics_ce WHERE bts_id=".NumOrNull($id)." AND IFNULL(lcg,0)=IFNULL(p1.lcg,0) ORDER BY -id LIMIT 1)";
  
  $query=mysql_query($sql) or die(mysql_error());
  if (mysql_num_rows($query)>0)
    {
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;LCG:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_small' name='lcg' onchange='on_graph_select();'>";
    for ($i=0; $i<mysql_num_rows($query); $i++)
      {
      $row=mysql_fetch_array($query); 
      if ($i==0) {$first_lcg=$row[0]; $vendor=$row[1]; $cells=$row[2];}
      if ($row[0]==$_POST['lcg']) {$selected='selected';$was_selected=true; $vendor=$row[1]; $cells=$row[2];} else {$selected='';}
      echo "<option $selected value='$row[0]'>$row[0]</option>";
      }
    echo "</select>";
    }
  if ($was_selected) {$lcg=$_POST['lcg'];} else {$lcg=$first_lcg;}
  if ($lcg==0) {$lcg='lcg is NULL';} else {$lcg="lcg=".$lcg;}
  echo "&nbsp;&nbsp;&nbsp;$vendor&nbsp;&nbsp;&nbsp;$cells</div>";
  
  // ������ �����������
  $graph_list = array('��������� ��������','������','����������','rab_failestcs_ulce_cong','rab_failestcs_dlce_cong','rab_failestcs_voice_ce_cong','rab_failestcs_video_ce_cong','rab_failestps_ulce_cong','rab_failestps_dlce_cong','��������� huawei','��������� nsn');

  if (mysql_num_rows($query)>0)
    {
    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}
        
    // ��������� ��������
    if (($_POST['graph_type']=='��������� ��������') || isset($_POST['graph_type'])==false)
      {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, ce_availible_dl, ce_dl_max, ce_availible_ul, ce_ul_max, hardware_ce_availible, vendor FROM statistics_ce WHERE bts_id=$id AND $lcg $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['ce_availible_dl']);
        $points2[]=array($row['stat_date'],$row['ce_dl_max']);
        $points3[]=array($row['stat_date'],$row['ce_availible_ul']);
        $points4[]=array($row['stat_date'],$row['ce_ul_max']);
        $points5[]=array($row['stat_date'],$row['hardware_ce_availible']);
        }
      // ���� huawei - ��������� hardware_ce_availible �� ���� lcg
      /*if ($row['vendor']=='huawei') 
        {
        mysql_data_seek($query,0);
        $row=mysql_fetch_array($query); 
        $fd=$row['stat_date'];
        $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, sum(hardware_ce_availible) as hardware_ce_availible FROM statistics_ce WHERE bts_id=$id $date_cond GROUP BY stat_date"; 
        $query=mysql_query($sql) or die(mysql_error());
        array_splice ($points5,0);
        for ($i=0; $i<mysql_num_rows($query); $i++)
          {
          $row=mysql_fetch_array($query); 
          if ($row['stat_date']>=$fd)  {$points5[]=array($row['stat_date'],$row['hardware_ce_availible']);}
          } 
        } */
      
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>'ce availible dl'
          ),
        array
          (
          'color'=>'rgb(102, 255, 153)'
          , 'data'=>$points2
          , 'label'=>'ce dl max'
          ), 
        array
          (
            'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points3
          , 'label'=>'ce availible ul'
          ),  
        array
          (
            'color'=>'rgb(51, 204, 255)'
          , 'data'=>$points4
          , 'label'=>'ce ul max'
          ),  
        array
          (
            'color'=>'rgb(0, 0, 0)'
          , 'data'=>$points5
          , 'label'=>'hardware ce availible'
          )     
      );
      }
    // ������
    if ($_POST['graph_type']=='������')
      {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, IFNULL(ce_rj_dl_max,0) as ce_rj_dl_max, IFNULL(ce_rj_ul_max,0) as ce_rj_ul_max FROM statistics_ce WHERE bts_id=$id AND $lcg $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['ce_rj_dl_max']);
        $points2[]=array($row['stat_date'],$row['ce_rj_ul_max']);
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>'ce_rj_dl_max'
          ),
        array
          (
          'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points2
          , 'label'=>'ce_rj_ul_max'
          ), 

      );
      }  
    // ����������
    if ($_POST['graph_type']=='����������')
      {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, IF(vendor='nsn',(ce_ul_max-16)/IF(ce_availible_ul>hardware_ce_availible,ce_availible_ul,hardware_ce_availible)*100,ce_ul_max/IF(ce_availible_ul<hardware_ce_availible,ce_availible_ul,hardware_ce_availible)*100) as ul_utilization, IF(vendor='nsn',(ce_dl_max-16)/IF(ce_availible_dl<hardware_ce_availible,ce_availible_dl,hardware_ce_availible)*100,ce_dl_max/IF(ce_availible_dl>hardware_ce_availible,ce_availible_dl,hardware_ce_availible)*100) as dl_utilization FROM statistics_ce WHERE bts_id=$id AND $lcg $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['dl_utilization']);
        $points2[]=array($row['stat_date'],$row['ul_utilization']);
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>'dl utilization'
          ),
        array
          (
          'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points2
          , 'label'=>'ul utilization'
          ), 

      );
      }  
    // ��������� �������
    if (in_array($_POST['graph_type'],array('rab_failestcs_ulce_cong','rab_failestcs_dlce_cong','rab_failestcs_voice_ce_cong','rab_failestcs_video_ce_cong','rab_failestps_ulce_cong','rab_failestps_dlce_cong')))
      {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, ".$_POST['graph_type']." FROM statistics_ce WHERE bts_id=$id AND $lcg $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row[$_POST['graph_type']]);
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>$_POST['graph_type']
          )
      );
      }   
    // ��������� huawei � nsn
    if ($_POST['graph_type']=='��������� huawei' || $_POST['graph_type']=='��������� nsn')
      {
      if ($_POST['graph_type']=='��������� huawei') {$vendor='huawei';}
      if ($_POST['graph_type']=='��������� nsn') {$vendor='nsn';}
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, sum(ce_availible_dl) as ce_availible_dl, sum(ce_dl_max) as ce_dl_max, sum(ce_availible_ul) as ce_availible_ul, sum(ce_ul_max) as ce_ul_max, vendor FROM statistics_ce WHERE vendor='$vendor' $date_cond GROUP BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['ce_availible_dl']);
        $points2[]=array($row['stat_date'],$row['ce_dl_max']);
        $points3[]=array($row['stat_date'],$row['ce_availible_ul']);
        $points4[]=array($row['stat_date'],$row['ce_ul_max']);
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>'ce availible dl'
          ),
        array
          (
          'color'=>'rgb(102, 255, 153)'
          , 'data'=>$points2
          , 'label'=>'ce dl max'
          ), 
        array
          (
            'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points3
          , 'label'=>'ce availible ul'
          ),  
        array
          (
            'color'=>'rgb(51, 204, 255)'
          , 'data'=>$points4
          , 'label'=>'ce ul max'
          ),      
      );
      }       
      
    }
  }

////////////////////////////////////////////////////////////////////////////////
// ���������� RAN Cell
if ($_GET['type']=='rancell')
  {
  // ���� ����� ������ �� � cell
  $bts_number=$_POST['bts_number'];
  $sql="SELECT Id FROM bts WHERE bts_number=".StrOrNull($bts_number); 
  $query=mysql_query($sql) or die(mysql_error());
  $row=mysql_fetch_array($query);
  $id=$row[0];
  
  echo "<div>";
  echo "<form action='index.php?f=10&type=rancell' method='post' id='stat_params'>������� ����� ��:&nbsp;&nbsp;&nbsp;";
  echo "<input type='text' size='4' name='bts_number' value='$bts_number'>&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";
  $sql="SELECT cell FROM statistics_ran_cell WHERE bts_id=".NumOrNull($id)." GROUP BY cell";
  $query=mysql_query($sql) or die(mysql_error());
  if (mysql_num_rows($query)>0)
    {
    
    // ����� ����
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;cell:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_small' name='cell' onchange='on_graph_select();'>";
    for ($i=0; $i<mysql_num_rows($query); $i++)
      {
      $row=mysql_fetch_array($query); 
      if ($i==0) {$first_cell=$row[0];}
      if ($row[0]==$_POST['cell']) {$selected='selected';$was_selected=true;} else {$selected='';}
      echo "<option $selected value='$row[0]'>$row[0]</option>";
      }
    echo "</select>";
    
    // ������� ����� �� ���� cell
    if (in_array($_POST['graph_type'],array('voice_volume_bh','voice_volume_day','voice_data_volume_ul_day','voice_data_volume_dl_day','video_voice_volume_bh','video_data_volume_ul_day','video_data_volume_dl_day','ps_r99_volume_ul_day','ps_r99_volume_dl_day','ps_r99_volume_total_day','ps_hspa_volume_ul_day','ps_hspa_volume_dl_day','ps_hspa_volume_total_day','ps_voice_video_ul_day','ps_voice_video_dl_day','ps_voice_video_total_day','ps_data_volume_ul_day','ps_data_volume_dl_day','ps_data_volume_total_day')))
      {
      if ($_POST['cell_sum']==1) {$checked='checked';} else {$checked='';}
      echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����� �� ���� cell:&nbsp;&nbsp;&nbsp;<input type='checkbox' name='cell_sum' $checked value='1' onclick='on_graph_select();'>";
      if ($checked=='checked') {$cell_sum=true;}
      }
          
    }
  if ($was_selected) {$cell=$_POST['cell'];} else {$cell=$first_cell;}
  echo "</div>";
    
  if (mysql_num_rows($query)>0)
    {
    // ������ �����������
    $sql="SHOW COLUMNS FROM statistics_ran_cell";
    $query=mysql_query($sql) or die(mysql_error());
    for ($i=0; $i<mysql_num_rows($query); $i++)
      {
      $row=mysql_fetch_array($query); 
      if ($i==4) {$graph_list[]='group_start_RRC';}
      if ($i==8) {$graph_list[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list[]='group_start_PS';}
      if ($i==59) {$graph_list[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list[]='group_start_REJECTS';}
      
      if ($i==4) {$first_field=$row[0];}
      if ($i>3) {$graph_list[]=$row[0];}
      
      if ($i==7) {$graph_list[]='group_end';}
      if ($i==21) {$graph_list[]='group_end';}
      if ($i==58) {$graph_list[]='group_end';}
      if ($i==64) {$graph_list[]='group_end';}
      if ($i==76) {$graph_list[]='group_end';}
      if ($i==85) {$graph_list[]='group_end';}
      
      // ������ �������� 2
      if ($i==1) {$graph_list2[]='';}
      if ($i==1) {$first_field2='';}
      
      if ($i==4) {$graph_list2[]='group_start_RRC';}
      if ($i==8) {$graph_list2[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list2[]='group_start_PS';}
      if ($i==59) {$graph_list2[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list2[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list2[]='group_start_REJECTS';}
      
      if ($i>3) {$graph_list2[]=$row[0];}
      
      if ($i==7) {$graph_list2[]='group_end';}
      if ($i==21) {$graph_list2[]='group_end';}
      if ($i==58) {$graph_list2[]='group_end';}
      if ($i==64) {$graph_list2[]='group_end';}
      if ($i==76) {$graph_list2[]='group_end';}
      if ($i==85) {$graph_list2[]='group_end';}
      
      // ������ �������� 3
      if ($i==1) {$graph_list3[]='';}
      if ($i==1) {$first_field3='';}
      
      if ($i==4) {$graph_list3[]='group_start_RRC';}
      if ($i==8) {$graph_list3[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list3[]='group_start_PS';}
      if ($i==59) {$graph_list3[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list3[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list3[]='group_start_REJECTS';}
      
      if ($i>3) {$graph_list3[]=$row[0];}
      
      if ($i==7) {$graph_list3[]='group_end';}
      if ($i==21) {$graph_list3[]='group_end';}
      if ($i==58) {$graph_list3[]='group_end';}
      if ($i==64) {$graph_list3[]='group_end';}
      if ($i==76) {$graph_list3[]='group_end';}
      if ($i==85) {$graph_list3[]='group_end';}
      }
    
    // ����������� �������
    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}
     
    if (true)  
      { 
      // ������
      if (isset($_POST['graph_type'])==false) {$graph_type=$first_field;} else {$graph_type=$_POST['graph_type'];}
      if (isset($_POST['graph_type_2'])==false) {$graph_type2=$first_field2;} else {$graph_type2=$_POST['graph_type_2'];}
      if (isset($_POST['graph_type_3'])==false) {$graph_type3=$first_field3;} else {$graph_type3=$_POST['graph_type_3'];}
      $f1=$graph_type;
      if (strlen($graph_type2)>0) {$f2=",".$graph_type2;}
      if (strlen($graph_type3)>0) {$f3=",".$graph_type3;}
      $cell="AND cell=$cell";
      // ������, ���� ����� �� �����
      if ($cell_sum)  
        {
        $f1="sum($graph_type) as $graph_type";
        if (strlen($graph_type2)>0) {$f2=",".$graph_type2;}
        if (strlen($graph_type3)>0) {$f3=",".$graph_type3;}
        $cell="";
        $groupby="GROUP BY bts_id, stat_date";
        }
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, $f1 $f2 $f3 FROM statistics_ran_cell WHERE bts_id=$id $cell $date_cond $groupby ORDER BY stat_date";
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row[$graph_type]);
        if (strlen($graph_type2)>0) {$points2[]=array($row['stat_date'],$row[$graph_type2]);}
        if (strlen($graph_type3)>0) {$points3[]=array($row['stat_date'],$row[$graph_type3]);}
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>$graph_type
          ),
        array
          (
          'color'=>'rgb(255, 51, 51)'
          , 'data'=>$points2
          , 'label'=>$graph_type2
          , 'yaxis'=>2
          ),  
        array
          (
          'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points3
          , 'label'=>$graph_type3
          , 'yaxis'=>3
          )  
        );
      } 
       
    }
         
  }  
////////////////////////////////////////////////////////////////////////////////
///           ���������� ABIS                                             //////
if ($_GET['type']=='abis') {

  // ������� ������
  $bts_number=$_POST['bts_number'];
  $sql="SELECT Id FROM bts WHERE bts_number=".StrOrNull($bts_number); 
  $query=mysql_query($sql) or die(mysql_error());
  $row=mysql_fetch_array($query);
  $bts_id=$row[0];

  // ������ �����������
  $graph_list = array('�������� ������� Abis','������','������������� ��������');
  
  // ����� ���������  
  echo "<div>";
  echo "<form action='index.php?f=10&type=abis' method='post' id='stat_params'>";
  echo "������� ����� ��:&nbsp;&nbsp;&nbsp;";
  echo "<input type='text' size='4' name='bts_number' value='$bts_number'>";
  echo "&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";

  $sql = "SELECT btsm FROM statistics_abis WHERE bts_id=".NumOrNull($bts_id)." GROUP BY bts_id, btsm"; 
  $query=mysql_query($sql) or die(mysql_error());

  if (mysql_num_rows($query)>0) {
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;btsm:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_small' name='btsm' onchange='on_graph_select();'>";
    for ($i=0; $i<mysql_num_rows($query); $i++) {
      $row=mysql_fetch_array($query); 
      if ($i==0) {$first_btsm=$row[0];}
      if ($row[0]==$_POST['btsm']) {$selected='selected'; $was_selected=true;} else {$selected='';}
      echo "<option $selected value='$row[0]'>$row[0]</option>";
    }
    echo "</select>";
    echo "</div>";
  
    if ($was_selected) {$btsm=$_POST['btsm'];} else {$btsm=$first_btsm;}
    if ($btsm==0) {$btsm='btsm is NULL';} else {$btsm="btsm=".$btsm;}

    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}

    // �������� ������� Abis
    if (($_POST['graph_type']=='�������� ������� Abis') || isset($_POST['graph_type'])==false) {

      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, avg_available_ch_per_hour, avg_busy_ch_per_hour, um_avg_available_ch_per_hour FROM statistics_abis WHERE bts_id=$bts_id AND $btsm $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++) {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['avg_available_ch_per_hour']);
        $points2[]=array($row['stat_date'],$row['avg_available_ch_per_hour']*0.85);
        $points3[]=array($row['stat_date'],$row['avg_busy_ch_per_hour']);
        $points4[]=array($row['stat_date'],$row['um_avg_available_ch_per_hour']);
      }
      
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(0, 0, 0)'
          ,'data'=>$points
          ,'label'=>'avg available channels per hour'
        )
       ,array (
           'color'=>'rgb(255, 50, 0)'
          ,'data'=>$points2
          ,'label'=>'85% avg available channels per hour'
        ) 
       ,array (
           'color'=>'rgb(100, 220, 50)'
          ,'data'=>$points3
          ,'label'=>'avg_busy_ch_per_hour'
        )  
       ,array (
           'color'=>'rgb(51, 204, 255)'
          ,'data'=>$points4
          ,'label'=>'um_avg_available_ch_per_hour'
        )  
      );
    } 
    
    // ������ Abis
    if ($_POST['graph_type']=='������') {

      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, decline FROM statistics_abis WHERE bts_id=$bts_id AND $btsm $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++) {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['decline']);
      }
      
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(255, 51, 51)'
          ,'data'=>$points
          ,'label'=>'declines'
        )  
      );
    }
    
    // ������������� ������� Abis
    if ($_POST['graph_type']=='������������� ��������') {

      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, traffic_distribution_1_TCH_CS, traffic_distribution_1_TCH_PS, traffic_distribution_2_TCH_PS, traffic_distribution_3_TCH_PS, traffic_distribution_4_TCH_PS, traffic_distribution_5_TCH_PS FROM statistics_abis WHERE bts_id=$bts_id AND $btsm $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++) {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['traffic_distribution_1_TCH_CS']);
        $points2[]=array($row['stat_date'],$row['traffic_distribution_1_TCH_PS']);
        $points3[]=array($row['stat_date'],$row['traffic_distribution_2_TCH_PS']);
        $points4[]=array($row['stat_date'],$row['traffic_distribution_3_TCH_PS']);
        $points5[]=array($row['stat_date'],$row['traffic_distribution_4_TCH_PS']);
        $points6[]=array($row['stat_date'],$row['traffic_distribution_5_TCH_PS']);
      }
      
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(0, 204, 0)'
          ,'data'=>$points
          ,'label'=>'traffic_distribution_1_TCH_CS'
        )
       ,array (
           'color'=>'rgb(204, 102, 0)'
          ,'data'=>$points2
          ,'label'=>'traffic_distribution_1_TCH_PS'
        ) 
       ,array (
           'color'=>'rgb(255, 204, 51)'
          ,'data'=>$points3
          ,'label'=>'traffic_distribution_2_TCH_PS'
        )  
       ,array (
           'color'=>'rgb(102, 0, 255)'
          ,'data'=>$points4
          ,'label'=>'traffic_distribution_3_TCH_PS'
        )
       ,array (
           'color'=>'rgb(255, 51, 204)'
          ,'data'=>$points5
          ,'label'=>'traffic_distribution_4_TCH_PS'
        )
       ,array (
           'color'=>'rgb(0, 0, 0)'
          ,'data'=>$points6
          ,'label'=>'traffic_distribution_5_TCH_PS'
        )       
      );   
    }
    
        
  }
}
////////////////////////////////////////////////////////////////////////////////
//  ���������� PCU + Gb Interface
if ($_GET['type']=='pcu') {
  
  // ������� ������
  $id=$_POST['bsc_id'];
  
  // ������ �����������
  $graph_list = array('�������� ������� PCU','������� �� Gb-interface','�������� �� Gb-interface');

  // ����� ���������
  echo "<div>";
  echo "<form action='index.php?f=10&type=pcu' method='post' id='stat_params'>";
  
    // ����� BSC
  echo "�������� BSC:&nbsp;&nbsp;&nbsp;";
  $sql="SELECT Id,bsc_number FROM bsc ORDER BY bsc_number"; 
  $query=mysql_query($sql) or die(mysql_error());
  echo "<select size='1' id='select_field_medium' name='bsc_id'>";
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row=mysql_fetch_array($query); 
    if ($row[0]==$id) {$selected='selected';} else {$selected='';}
    echo "<option $selected value='$row[0]'>$row[1]</option>";
    }
  echo "</select>&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";
  
  if ($id>0) {
    // ����� PCU
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PCU:&nbsp;&nbsp;&nbsp;<select size='1' id='select_field_small' name='pcu' onchange='on_graph_select();'>";
    $sql = "SELECT IFNULL(pcu_number,0) FROM statistics_pcu WHERE bsc_id=".NumOrNull($id)." GROUP BY pcu_number"; 
    $query=mysql_query($sql) or die(mysql_error());
    for ($i=0; $i<mysql_num_rows($query); $i++) {
      $row=mysql_fetch_array($query); 
      if ($i==0) {$first_pcu=$row[0];}
      if ($row[0]==$_POST['pcu']) {$selected='selected'; $was_selected=true;} else {$selected='';}
      echo "<option $selected value='$row[0]'>$row[0]</option>";
    }
    echo "</select>";
    
    // ������� ����� �� ���� PCU
    if ($_POST['cell_pcu']==1 || !$was_selected ) {$checked='checked';} else {$checked='';}
    echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����� �� ���� PCU:&nbsp;&nbsp;&nbsp;<input type='checkbox' name='cell_pcu' $checked value='1' onclick='on_graph_select();'>";
    if ($checked=='checked') {$pcu_sum=true;}
     
  }
  echo "</div>";
  
  if ($id>0) {
    // ��������� �������
    if ($was_selected) {$pcu=$_POST['pcu'];} else {$pcu=$first_pcu;}
    if ($pcu==0) {$pcu='AND pcu_number is NULL';} else {$pcu="AND pcu_number=".$pcu;}

    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}
  
    // �������� ������� PCU
    if (($_POST['graph_type']=='�������� ������� PCU') || isset($_POST['graph_type'])==false) {

    if ($pcu_sum) {// ������, ���� ����� �� ����� 
      $f="sum(avg_pdt_hour_load_avg) as avg_pdt_hour_load_avg, sum(avg_pdt_hour_load_max) as avg_pdt_hour_load_max, sum(max_pdt_hour_load_avg) as max_pdt_hour_load_avg, sum(max_pdt_hour_load_max) as max_pdt_hour_load_max";
      $pcu="";
      $groupby="GROUP BY bsc_id, stat_date";
    } else {
      $f="avg_pdt_hour_load_avg, avg_pdt_hour_load_max, max_pdt_hour_load_avg, max_pdt_hour_load_max";
    }
        
    $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, $f FROM statistics_pcu WHERE bsc_id=$id $pcu $date_cond $groupby ORDER BY stat_date"; 
    $query=mysql_query($sql) or die(mysql_error());
    for ($i=0; $i<mysql_num_rows($query); $i++) {
      $row=mysql_fetch_array($query); 
      $points[]=array($row['stat_date'],$row['avg_pdt_hour_load_avg']);
      $points2[]=array($row['stat_date'],$row['avg_pdt_hour_load_max']);
      $points3[]=array($row['stat_date'],$row['max_pdt_hour_load_avg']);
      $points4[]=array($row['stat_date'],$row['max_pdt_hour_load_max']);
    }
      
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(0, 0, 0)'
          ,'data'=>$points
          ,'label'=>'avg load in day'
        )
       ,array (
           'color'=>'rgb(255, 50, 0)'
          ,'data'=>$points2
          ,'label'=>'avg load in BH'
        ) 
       ,array (
           'color'=>'rgb(100, 220, 50)'
          ,'data'=>$points3
          ,'label'=>'max load in day'
        )  
       ,array (
           'color'=>'rgb(51, 204, 255)'
          ,'data'=>$points4
          ,'label'=>'max load in BH'
        )  
      );
    } 

    // ������� �� Gb-interface
    if ($_POST['graph_type']=='������� �� Gb-interface') {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, uplink_total_mb, uplink_user_mb, downlink_user_mb, downlink_total_mb FROM statistics_gb WHERE bsc_id=$id $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++) {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['uplink_total_mb']);
        $points2[]=array($row['stat_date'],$row['uplink_user_mb']);
        $points3[]=array($row['stat_date'],$row['downlink_total_mb']);
        $points4[]=array($row['stat_date'],$row['downlink_user_mb']);
      }  
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(0, 0, 0)'
          ,'data'=>$points
          ,'label'=>'uplink total mb'
        )
       ,array (
           'color'=>'rgb(255, 50, 0)'
          ,'data'=>$points2
          ,'label'=>'uplink user mb'
        ) 
       ,array (
           'color'=>'rgb(100, 220, 50)'
          ,'data'=>$points3
          ,'label'=>'downlink total mb'
        )  
       ,array (
           'color'=>'rgb(51, 204, 255)'
          ,'data'=>$points4
          ,'label'=>'downlink user mb'
        )  
      );  
    }
    // �������� �� Gb-interface
    if ($_POST['graph_type']=='�������� �� Gb-interface') {
      $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, peak_hour_traffic_ul, peak_hour_traffic_dl FROM statistics_gb WHERE bsc_id=$id $date_cond ORDER BY stat_date"; 
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++) {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row['peak_hour_traffic_ul']);
        $points2[]=array($row['stat_date'],$row['peak_hour_traffic_dl']);
      }  
      //������ � ����������� �������
      $graph = array (
        array (
           'color'=>'rgb(0, 0, 0)'
          ,'data'=>$points
          ,'label'=>'peak hour traffic ul Mbit/s'
        )
       ,array (
           'color'=>'rgb(255, 50, 0)'
          ,'data'=>$points2
          ,'label'=>'peak hour traffic dl Mbit/s'
        ) 
      );     
    }  
  }
}
////////////////////////////////////////////////////////////////////////////////
//           RAN RNC
if ($_GET['type']=='ranrnc')
  {
  // ������� ������
  $id=$_POST['rnc_id'];
  
  echo "<div>";
  echo "<form action='index.php?f=10&type=ranrnc' method='post' id='stat_params'>";
  
  // ����� RNC
  echo "�������� RNC:&nbsp;&nbsp;&nbsp;";
  $sql="SELECT Id,rnc_number FROM rnc ORDER BY rnc_number"; 
  $query=mysql_query($sql) or die(mysql_error());
  echo "<select size='1' id='select_field_medium' name='rnc_id'>";
  for ($i=0; $i<mysql_num_rows($query); $i++)
    {
    $row=mysql_fetch_array($query); 
    if ($row[0]==$id) {$selected='selected';} else {$selected='';}
    echo "<option $selected value='$row[0]'>$row[1]</option>";
    }
  echo "</select>&nbsp;&nbsp;&nbsp;<button type='submit'>�������</button>";
  echo "</div>";
    
  if ($id>0)
    {
    // ������ �����������
    $sql="SHOW COLUMNS FROM statistics_ran_rnc";
    $query=mysql_query($sql) or die(mysql_error());
    for ($i=0; $i<mysql_num_rows($query); $i++)
      {
      $row=mysql_fetch_array($query); 
      if ($i==4) {$graph_list[]='group_start_RRC';}
      if ($i==8) {$graph_list[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list[]='group_start_PS';}
      if ($i==59) {$graph_list[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list[]='group_start_REJECTS';}
      
      if ($i==4) {$first_field=$row[0];}
      if ($i>3) {$graph_list[]=$row[0];}
      
      if ($i==7) {$graph_list[]='group_end';}
      if ($i==21) {$graph_list[]='group_end';}
      if ($i==58) {$graph_list[]='group_end';}
      if ($i==64) {$graph_list[]='group_end';}
      if ($i==76) {$graph_list[]='group_end';}
      if ($i==85) {$graph_list[]='group_end';}
      
      // ������ �������� 2
      if ($i==1) {$graph_list2[]='';}
      if ($i==1) {$first_field2='';}
      
      if ($i==4) {$graph_list2[]='group_start_RRC';}
      if ($i==8) {$graph_list2[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list2[]='group_start_PS';}
      if ($i==59) {$graph_list2[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list2[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list2[]='group_start_REJECTS';}
      
      if ($i>3) {$graph_list2[]=$row[0];}
      
      if ($i==7) {$graph_list2[]='group_end';}
      if ($i==21) {$graph_list2[]='group_end';}
      if ($i==58) {$graph_list2[]='group_end';}
      if ($i==64) {$graph_list2[]='group_end';}
      if ($i==76) {$graph_list2[]='group_end';}
      if ($i==85) {$graph_list2[]='group_end';}
      
      // ������ �������� 3
      if ($i==1) {$graph_list3[]='';}
      if ($i==1) {$first_field3='';}
      
      if ($i==4) {$graph_list3[]='group_start_RRC';}
      if ($i==8) {$graph_list3[]='group_start_VOICE&VIDEO';}
      if ($i==22) {$graph_list3[]='group_start_PS';}
      if ($i==59) {$graph_list3[]='group_start_RETRANSSMITIONS';}
      if ($i==65) {$graph_list3[]='group_start_UTILIZATIONS';}
      if ($i==77) {$graph_list3[]='group_start_REJECTS';}
      
      if ($i>3) {$graph_list3[]=$row[0];}
      
      if ($i==7) {$graph_list3[]='group_end';}
      if ($i==21) {$graph_list3[]='group_end';}
      if ($i==58) {$graph_list3[]='group_end';}
      if ($i==64) {$graph_list3[]='group_end';}
      if ($i==76) {$graph_list3[]='group_end';}
      if ($i==85) {$graph_list3[]='group_end';}
      }
    
    // ����������� �������
    if (($_POST['period']=='��������� ���') || isset($_POST['period'])==false) {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 365';}
    if ($_POST['period']=='��������� 6 �������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 180';}
    if ($_POST['period']=='��������� 3 ������') {$date_cond='AND TO_DAYS(NOW())-TO_DAYS(stat_date) <= 90';}
    if ($_POST['period']=='���� ������') {$date_cond='';}
     
    if (true)  
      { 
      // ������
      if (isset($_POST['graph_type'])==false) {$graph_type=$first_field;} else {$graph_type=$_POST['graph_type'];}
      if (isset($_POST['graph_type_2'])==false) {$graph_type2=$first_field2;} else {$graph_type2=$_POST['graph_type_2'];}
      if (isset($_POST['graph_type_3'])==false) {$graph_type3=$first_field3;} else {$graph_type3=$_POST['graph_type_3'];}
      $f1=$graph_type;
      if (strlen($graph_type2)>0) {$f2=",".$graph_type2;}
      if (strlen($graph_type3)>0) {$f3=",".$graph_type3;}

     $sql="SELECT UNIX_TIMESTAMP(stat_date)*1000 as stat_date, $f1 $f2 $f3 FROM statistics_ran_rnc WHERE rnc_id=$id $date_cond ORDER BY stat_date";
      $query=mysql_query($sql) or die(mysql_error());
      for ($i=0; $i<mysql_num_rows($query); $i++)
        {
        $row=mysql_fetch_array($query); 
        $points[]=array($row['stat_date'],$row[$graph_type]);
        if (strlen($graph_type2)>0) {$points2[]=array($row['stat_date'],$row[$graph_type2]);}
        if (strlen($graph_type3)>0) {$points3[]=array($row['stat_date'],$row[$graph_type3]);}
        }
      //������ � ����������� �������
      $graph = array(
        array
          (
          'color'=>'rgb(0, 204, 0)'
          , 'data'=>$points
          , 'label'=>$graph_type
          ),
        array
          (
          'color'=>'rgb(255, 51, 51)'
          , 'data'=>$points2
          , 'label'=>$graph_type2
          , 'yaxis'=>2
          ),  
        array
          (
          'color'=>'rgb(0, 0, 255)'
          , 'data'=>$points3
          , 'label'=>$graph_type3
          , 'yaxis'=>3
          )  
        );
      } 
       
    }
         
  }  
////////////////////////////////////////////////////////////////////////////////
// ��������� �������
if (isset($graph))
  {
  ?>
  <script type="text/javascript">
    $(function() 
      {
      
      var options = 
        {
			  legend: {show: true, noColumns: 1, position: "nw"},
			  series: {lines: {show: true}},
			  yaxis:  {ticks: 10,position: "left"},
        y2axis: {ticks: 10,position: "right"},
        y3axis: {ticks: 10,position: "right"},
        xaxis:  {mode: "time", timeformat: "%d.%m.%Y"}, 
			  selection: {mode: "xy"},	
        grid: {hoverable: true, clickable: true}
        };

		  var startData = <?php echo json_encode($graph);?>;
      
      var plot = $.plot("#placeholder",startData, options);

		  // Create the overview plot
      var overview = $.plot("#overview", startData, 
        {
			  legend: {show: false},
			  series: {lines: {show: true, lineWidth: 1},shadowSize: 0},
			  xaxis: {ticks: 2, mode: "time", timeformat: "%d.%m.%y"},
			  yaxis: {ticks: 3},
        y2axis: {ticks: 3,position: "right"},
        y3axis: {ticks: 3,position: "right"},
			  grid: {color: "#999"},
			  selection: {mode: "xy"}
		    });

		  // now connect the two
      $("#placeholder").bind("plotselected", function (event, ranges)   
      {
      // clamp the zooming to prevent eternal zoom
      if (ranges.xaxis.to - ranges.xaxis.from < 0.00001) 
        {
			  ranges.xaxis.to = ranges.xaxis.from + 0.00001;
			  }

			if (ranges.yaxis.to - ranges.yaxis.from < 0.00001) 
        {
				ranges.yaxis.to = ranges.yaxis.from + 0.00001;
			  }

			// do the zooming
      plot = $.plot("#placeholder", startData,
				$.extend
          (true, {}, options, 
            {
					  xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to },
					  yaxis: { min: ranges.yaxis.from, max: ranges.yaxis.to }
				    })
			   );

			// don't fire event on the overview to prevent eternal loop
      overview.setSelection(ranges, true);
		  });

		  $("#overview").bind("plotselected", function (event, ranges) {
			plot.setSelection(ranges);});
      
      /////////////////////////////////////////////////////////////////
      // ���������
      $("<div id='tooltip'></div>").css({
      width: "150px",
			position: "absolute",
			display: "none",
			border: "1px solid #fdd",
			padding: "2px",
			"background-color": "#fee",
			opacity: 0.80
		  }).appendTo("body");

		  $("#placeholder").bind("plothover", function (event, pos, item) {

      if (item) {
					var x = item.datapoint[0].toFixed(2),
						y = item.datapoint[1].toFixed(2);
            
          var theDate = new Date();
          theDate.setTime(x);
          dateString = theDate.toLocaleDateString();

					$("#tooltip").html(item.series.label + ": " + dateString + " = " + y)
						.css({top: item.pageY+5, left: item.pageX+5})
						.fadeIn(200);
			} else {
					$("#tooltip").hide();
				}

		  });
      ////////////////////////////////////////////////////////////////
      });
  </script>  
  <?php
  echo "<div class='demo-container'>";
	echo "<div id='placeholder' class='demo-placeholder'></div>";
	echo "<div id='overview' class='demo-placeholder'></div>";
  // ����� �������
  echo "<div id='graph_options'>&nbsp;����� �������:<br><select size='1' id='select_field_medium' name='period' onchange='on_graph_select();'>";
  if ($_POST['period']=='��������� ���') {$selected='selected';} else {$selected='';}
  echo "<option $selected>��������� ���</option>";
  if ($_POST['period']=='��������� 6 �������') {$selected='selected';} else {$selected='';}
  echo "<option $selected>��������� 6 �������</option>";
  if ($_POST['period']=='��������� 3 ������') {$selected='selected';} else {$selected='';}
  echo "<option $selected>��������� 3 ������</option>";
  if ($_POST['period']=='���� ������') {$selected='selected';} else {$selected='';}
  echo "<option $selected>���� ������</option>";
  echo "</select></div>";
  
  // ������ ����������� 1
  if (count($graph_list)>0)
    {
    echo "<div id='graph_options'>&nbsp;����� �������:<br><select size='1' id='select_field_medium' name='graph_type' onchange='on_graph_select();'>";
    for ($i=0; $i<count($graph_list); $i++)
      {
      if (stripos($graph_list[$i],'group_start')===0) echo "<optgroup label='".substr($graph_list[$i],12)."'>";
      if (stripos($graph_list[$i],'group')===false)
        {
        if ($_POST['graph_type']==$graph_list[$i]) {$selected='selected';} else {$selected='';}
        echo "<option $selected value='".$graph_list[$i]."'>".$graph_list[$i]."</option>";
        }
      if (stripos($graph_list[$i],'group_end')===0) echo "</optgroup>";
      }
    
    echo "</select></div>";
    }
  // ������ ����������� 2
  if (count($graph_list2)>0)
    {
    echo "<div id='graph_options'>&nbsp;����� ������� 2:<br><select size='1' id='select_field_medium' name='graph_type_2' onchange='on_graph_select();'>";
    for ($i=0; $i<count($graph_list2); $i++)
      {
      if (stripos($graph_list2[$i],'group_start')===0) echo "<optgroup label='".substr($graph_list2[$i],12)."'>";
      if (stripos($graph_list2[$i],'group')===false)
        {
        if ($_POST['graph_type_2']==$graph_list2[$i]) {$selected='selected';} else {$selected='';}
        echo "<option $selected value='".$graph_list2[$i]."'>".$graph_list2[$i]."</option>";
        }
      if (stripos($graph_list2[$i],'group_end')===0) echo "</optgroup>";
      }
    
    echo "</select></div>";
    }
  // ������ ����������� 3
  if (count($graph_list3)>0)
    {
    echo "<div id='graph_options'>&nbsp;����� ������� 3:<br><select size='1' id='select_field_medium' name='graph_type_3' onchange='on_graph_select();'>";
    for ($i=0; $i<count($graph_list3); $i++)
      {
      if (stripos($graph_list3[$i],'group_start')===0) echo "<optgroup label='".substr($graph_list3[$i],12)."'>";
      if (stripos($graph_list3[$i],'group')===false)
        {
        if ($_POST['graph_type_3']==$graph_list3[$i]) {$selected='selected';} else {$selected='';}
        echo "<option $selected value='".$graph_list3[$i]."'>".$graph_list3[$i]."</option>";
        }
      if (stripos($graph_list3[$i],'group_end')===0) echo "</optgroup>";
      }
    
    echo "</select></div>";
    }    
    
	echo "</div>";
  }  
  
  if (isset($_GET['type'])) echo "</form>";  
?> 