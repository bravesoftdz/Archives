<?php

// входные параметры
$id=$_GET['id'];

// основной запрос
$sql = "select";
$sql.= " s.id";
$sql.= ",case when plan_gsm_config_id>0 or plan_dcs_config_id>0 then 1 end as is_2g";
$sql.= ",case when TO_DAYS(belgei_2g)>0 then belgei_2g end as belgei_2g_date";
$sql.= ",case when belgei_2g is not null then 'да' end as belgei_2g_got";
$sql.= ",case when TO_DAYS(act_2g)>0 then act_2g end as act_2g_date"; 
$sql.= ",case when act_2g is not null then 'да' end as act_2g_got"; 
$sql.= ",case when TO_DAYS(gsm)>0 then gsm end as gsm_date"; 
$sql.= ",case when gsm is not null then 'да' end as gsm_on";
$sql.= ",case when TO_DAYS(dcs)>0 then dcs end as dcs_date";
$sql.= ",case when dcs is not null then 'да' end as dcs_on";
$sql.= ",case when plan_umts_config_id>0 or plan_umts9_config_id>0 then 1 end as is_3g";
$sql.= ",case when TO_DAYS(belgei_3g)>0 then belgei_3g end as belgei_3g_date";
$sql.= ",case when belgei_3g is not null then 'да' end as belgei_3g_got";
$sql.= ",case when TO_DAYS(act_3g)>0 then act_3g end as act_3g_date";
$sql.= ",case when act_3g is not null then 'да' end as act_3g_got";
$sql.= ",case when TO_DAYS(umts2100)>0 then umts2100 end as umts2100_date";
$sql.= ",case when umts2100 is not null then 'да' end as umts2100_on";
$sql.= ",case when TO_DAYS(belgei_3g9)>0 then belgei_3g9 end as belgei_3g9_date";
$sql.= ",case when belgei_3g9 is not null then 'да' end as belgei_3g9_got";
$sql.= ",case when TO_DAYS(act_3g9)>0 then act_3g9 end as act_3g9_date";
$sql.= ",case when act_3g9 is not null then 'да' end as act_3g9_got";
$sql.= ",case when TO_DAYS(umts900)>0 then umts900 end as umts900_date";
$sql.= ",case when umts900 is not null then 'да' end as umts900_on";
$sql.= ",case when plan_lte_config_id>0 then 1 end as is_4g";
$sql.= ",case when TO_DAYS(lte)>0 then lte end as lte_date";
$sql.= ",case when lte is not null then 'да' end as lte_on";
$sql.= ",case when TO_DAYS(stat)>0 then stat end as stat_date";
$sql.= ",case when stat is not null then 'да' end as stat_got";
$sql.= ",case when TO_DAYS(uninstall)>0 then uninstall end as uninstall_date";
$sql.= ",case when uninstall is not null then 'да' end as uninstall_got";
$sql.= ",is_on";
$sql.= " from bts";
$sql.= " left join switchings s on bts.id=s.bts_id";
$sql.= " where bts.id='$id'";
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query);

// формируем элементы
echo "<table id='result_table'>";
echo "<tr>";
echo "<td id='rs_td'>";
echo "дата";
echo "</td>";
echo "<td id='rs_td'>";
echo "категория";
echo "</td>";
echo "<td id='rs_td'>";
echo "действие";
echo "</td>";
echo "<td id='rs_td'>";
echo "наличие";
echo "</td>";
echo "</tr>";

if ($row['is_2g']) {
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['belgei_2g_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Разрешение БелГИЭ 2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['belgei_2g_got'];
    echo "</td>";
    echo "</tr>";

    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['act_2g_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Акт ввода в эксплуатацию 2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['act_2g_got'];
    echo "</td>";
    echo "</tr>";
    
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['gsm_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Включение GSM";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['gsm_on'];
    echo "</td>";
    echo "</tr>";
    
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['dcs_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "2G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Включение DCS";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['dsc_on'];
    echo "</td>";
    echo "</tr>";
}

if ($row['is_3g']) {
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['belgei_3g_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "3G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Разрешение БелГИЭ 3G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['belgei_3g_got'];
    echo "</td>";
    echo "</tr>";

    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['act_3g_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "3G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Акт ввода в эксплуатацию 3G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['act_3g_got'];
    echo "</td>";
    echo "</tr>";
    
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['umts2100_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "3G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Включение UMTS 2100";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['umts2100_on'];
    echo "</td>";
    echo "</tr>";
    
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['belgei_3g9_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "UMTS900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Разрешение БелГИЭ umts900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['belgei_3g9_got'];
    echo "</td>";
    echo "</tr>";

    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['act_3g9_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "UMTS900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Акт ввода в эксплуатацию umts900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['act_3g9_got'];
    echo "</td>";
    echo "</tr>";    
    
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['umts900_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "UMTS900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Включение UMTS 900";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['umts900_on'];
    echo "</td>";
    echo "</tr>";
}
if ($row['is_4g']) {
    echo "<tr>";
    echo "<td id='rs_td'>";
    echo $row['lte_date'];
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "4G";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo "Включение LTE";
    echo "</td>";
    echo "<td id='rs_td'>";
    echo $row['lte_on'];
    echo "</td>";
    echo "</tr>";
}
echo "<tr>";
echo "<td id='rs_td'>";
echo $row['stat_date'];
echo "</td>";
echo "<td id='rs_td'>";
echo "Stat";
echo "</td>";
echo "<td id='rs_td'>";
echo "Наличие статистики";
echo "</td>";
echo "<td id='rs_td'>";
echo $row['stat_got'];
echo "</td>";
echo "</tr>";

echo "<tr>";
echo "<td id='rs_td'>";
echo $row['uninstall_date'];
echo "</td>";
echo "<td id='rs_td'>";
echo "Stat";
echo "</td>";
echo "<td id='rs_td'>";
echo "Демонтаж";
echo "</td>";
echo "<td id='rs_td'>";
echo $row['uninstall_got'];
echo "</td>";
echo "</tr>";

echo "</table>"
?>