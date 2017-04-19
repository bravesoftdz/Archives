<?php

function GetFullAddress($bts_number) { // �� ������ �� �������� ������ �����
    $sql = "SELECT settlement,type,street_type,street_name,house_type,house_number,area,region FROM settlements,bts,areas,regions WHERE areas.region_id=regions.id AND settlements.area_id=areas.id AND settlements.id=bts.settlement_id AND bts_number='$bts_number'";
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    if (strlen($row['settlement']) > 0) {
        $set_type = $row['type'];
        if ($row['type'] == '�����') {
            $set_type = "�.";
        }
        if ($row['type'] == '����') {
            $set_type = "�.";
        }
        $address = $set_type . " " . $row['settlement'] . ",";
        if (strlen($row['street_type']) > 0) {
            $address = $address . " " . $row['street_type'];
        }
        if (strlen($row['street_name']) > 0) {
            $address = $address . " " . $row['street_name'] . ",";
        }
        if (strlen($row['house_type']) > 0) {
            $address = $address . " " . $row['house_type'];
        }
        if (strlen($row['house_number']) > 0) {
            $address = $address . " " . $row['house_number'] . ",";
        }
        $address = $address . " " . $row['area'] . " �-�";
        $address = $address . ", " . $row['region'] . " ���.";
    }
    return $address;
}

function FormatAddress($set_type, $settlement, $street_type, $street_name, $house_type, $house_number, $area, $region) { // ����������� ������ � ���� ������
    if (strlen($settlement) > 0) {
        if ($set_type == '�����') {
            $set_type = "�.";
        }
        if ($set_type == '����') {
            $set_type = "�.";
        }
        $address = $set_type . " " . $settlement;
    }
    if (strlen($street_type) > 0) {
        $address = $address . ", " . $street_type;
    }
    if (strlen($street_name) > 0) {
        $address = $address . " " . $street_name;
    }
    if (strlen($house_type) > 0) {
        $address = $address . ", " . $house_type;
    }
    if (strlen($house_number) > 0) {
        $address = $address . " " . $house_number;
    }
    if (strlen($settlement) > 0) {
        if (!empty($area))
            $address = $address . ", " . $area . " �-�";
        if (!empty($region))
            $address = $address . ", " . $region . " ���.";
    }
    return $address;
}

function GetSmallAddress($bts_number) { // �� ������ �� �������� ����������� �����
    $sql = "SELECT settlement,type,street_type,street_name,house_type,house_number,area,region FROM settlements,bts,areas,regions WHERE areas.region_id=regions.id AND settlements.area_id=areas.id AND settlements.id=bts.settlement_id AND bts_number='$bts_number'";
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    if (strlen($row['settlement']) > 0) {
        $address = $row['settlement'] . ",";
        if (strlen($row['street_name']) > 0) {
            $address = $address . " " . $row['street_name'] . ",";
        }
        if (strlen($row['house_number']) > 0) {
            $address = $address . " " . $row['house_number'] . ",";
        }
        $address = $address . " " . $row['area'] . " �-�";
    }
    return $address;
}

function GetSmallFormularAddress($id) { // �� id ��������� �������� ����������� �����
    $sql = "SELECT settlement,settlements.type,street_type,street_name,house_type,house_number,area,region ";
    $sql.="FROM settlements,bts,areas,regions,formulars WHERE formulars.bts_id=bts.id AND areas.region_id=regions.id AND settlements.area_id=areas.id AND settlements.id=bts.settlement_id AND formulars.id='$id'";
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    if (strlen($row['settlement']) > 0) {
        $address = $row['settlement'];
        if (strlen($row['street_name']) > 0) {
            $address.=", " . $row['street_name'];
        }
        if (strlen($row['house_number']) > 0) {
            $address.=", " . $row['house_number'];
        }
    }
    return $address;
}

function NumOrNull($tx) {  // ��� sql �������� �����, �� ������ ��������� ��������� NULL
    if (strlen($tx) == 0) {
        $tx = "NULL";
    }
    return $tx;
}

function StrOrNull($tx) {  // ��� sql �������� ������, �� ������ �������� ��������� NULL
    if (strlen($tx) == 0) {
        $tx = "NULL";
    } else {
        $tx = addslashes($tx);
        $tx = '"' . $tx . '"';
    }
    return $tx;
}

function DateOrNull($tx) {  // ��� sql �������� ����, �� ������ �������� ��������� NULL
    if (strlen($tx) == 0) {
        $tx = "NULL";
    } else {
        $tx = substr($tx, 6, 4) . substr($tx, 3, 2) . substr($tx, 0, 2);
        $tx = '"' . $tx . '"';
    }
    return $tx;
}

function set_array_type($value) {
    if (count($value) > 0)
        return $value;
    else
        return array();
}

function MyGeoToDisplay($tx) {  // �������������� ��������� �� ���� � ������ ��� ������
    $longitudel = $tx;
    $tx = str_split($longitudel);
    $s = 0;
    $j = 0;
    for ($i = 0; $i <= count($tx); $i++) {
        $j++;
        $tx2[$j] = $tx[$i];
        if (($tx[$i] == ' ') && ($s == 1)) {
            $tx2[$j] = '&#039;';
            $s++;
            $j++;
            $tx2[$j] = " ";
        }
        if (($tx[$i] == ' ') && ($s == 0)) {
            $tx2[$j] = '&#176;';
            $s++;
            $j++;
            $tx2[$j] = " ";
        }
        if (($i == count($tx)) && ($s == 2)) {
            $tx2[$j] = '&#034;';
        }
    }
    $longitudel = implode($tx2);
    return $longitudel;
}

function MyGeoToDecDisplay($tx) { // �������������� ��������� �� ���� � ���������� ������ ��� ������
    $longitudel = explode(' ', $tx);
    $longitudel_dec = $longitudel[0] + $longitudel[1] / 60 + $longitudel[2] / 60 / 60;
    return $longitudel_dec;
}

// init_zero_section, GetSection: ���������� ��������� ������
function init_zero_section($sec_num, $zero_section) {
    if (isset($zero_section['form'])) {
        if ($sec_num == $zero_section['id']) {
            foreach ($zero_section['form'] as $k => $v) {
                $nullsection[$k] = $v;
            }
        }
    }
    return set_array_type($nullsection);
}

function GetSection() { // �������� �������������� ���������
    $last_index = count($_SESSION['sections']) - 1;

    if (isset($_GET['f']) == false) {
        if (isset($_SESSION['sections'])) {
            array_splice($_SESSION['sections'], 0);
        }
    }
    if ($_GET['f'] == 1) {
        // ���������� �������� ����� 0-�� ������
        if (isset($_SESSION['sections'][0]['form'])) {
            foreach ($_SESSION['sections'][0]['form'] as $k => $v) {
                $nullsection[$k] = $v;
            }
        }
        array_splice($_SESSION['sections'], 0);
        $name = '�������� ����������';
    }
    if ($_GET['f'] == 2) {
        // ���������� �������� ����� 0-�� ������
        if (isset($_SESSION['sections'][0]['form'])) {
            foreach ($_SESSION['sections'][0]['form'] as $k => $v) {
                $nullsection[$k] = $v;
            }
        }
        array_splice($_SESSION['sections'], 0);
        $name = '�������� ������� �������';
    }

    if ($_GET['f'] == 3) {
        $name = '�������� ����� ������ ��';
        if (!empty($_SESSION['bts_number']))
            $display = '��' . $_SESSION['bts_number'];
    }
    if ($_GET['f'] == 4) {
        if ($_GET['obj'] == 'region') {
            $name = '����� O������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'area') {
            $name = '����� ������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'settlement') {
            $name = '����� ���������� ������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'budget_year') {
            $name = '����� ���� �������';
            $display = $_SESSION['budget_number'];
        }
        if ($_GET['obj'] == 'budget_type') {
            $name = '����� ���� �������';
            $display = GetFromPrvForm('select', 0);
        }
        if ($_GET['obj'] == 'budget_type_2g') {
            $name = '����� ����<br>������� 2G';
            $display = GetFromPrvForm('select', 0);
        }
        if ($_GET['obj'] == 'budget_number_2g') {
            $name = '����� ������<br>������� 2G';
            $display = GetFromPrvForm('select', 0);
        }
        if ($_GET['obj'] == 'budget_type_3g') {
            $name = '����� ����<br>������� 3G';
            $display = GetFromPrvForm('select', 0);
        }
        if ($_GET['obj'] == 'budget_number_3g') {
            $name = '����� ������<br>������� 3G';
            $display = GetFromPrvForm('select', 0);
        }
        if ($_GET['obj'] == 'doc_link') {
            $name = '�������� ���������';
            $display = $_SESSION['sections'][$last_index - 1]['display'];
        }
        if ($_GET['obj'] == 'form_1bs_link' || $_GET['obj'] == 'agreem_link' || $_GET['obj'] == 'form_rrl_link') {
            $name = '�������� ���������';
            $display = $_SESSION['sections'][$last_index - 1]['display'];
        }
        if ($_GET['obj'] == 'bts_number') {
            $name = '����� ������ �C';
            $display = GetFromPrvForm('select', 0);
        }
    }
    if ($_GET['f'] == 5) {
        if ($_GET['obj'] == 'regions') {
            $name = '������ ��������';
        }
        if ($_GET['obj'] == 'areas') {
            $name = '������ �������';
        }
        if ($_GET['obj'] == 'settlements') {
            $name = '������ ��������� �������';
        }
        if ($_GET['obj'] == 'construction_2g_types') {
            $name = '������ ������������������ 2G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'construction_3g_types') {
            $name = '������ ������������������ 3G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'construction_4g_types') {
            $name = '������ ������������������ 4G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'power_types') {
            $name = '������ ����� �������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'gsm_configs') {
            $name = '������ ����� ������������ GSM';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'dcs_configs') {
            $name = '������ ����� ������������ DCS';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'umts_configs') {
            $name = '������ ����� ������������ UMTS';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'lte_configs') {
            $name = '������ ����� ������������ LTE';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'antenna_types_2g') {
            $name = '������ ����� ������ 2G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'antenna_types_3g') {
            $name = '������ ����� ������ 3G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'antenna_types_4g') {
            $name = '������ ����� ������ 4G';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'agreement_persons') {
            $name = '������ �����. �� ��������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'build_persons') {
            $name = '������ �����. �� �������������';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'build_organizations') {
            $name = '������ ������������ ���.';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'project_organizations') {
            $name = '������ ��������� ���.';
            $display = $_SESSION['display'];
        }
        if ($_GET['obj'] == 'repeater_types') {
            $name = '������ ����� ���������';
            $display = $_SESSION['display'];
        }
    }
    if ($_GET['f'] == 6) {
        $name = '�������� ������';
    }
    if ($_GET['f'] == 7) {
        $name = '�������� ������������ ��';
        if (!empty($_SESSION['bts_number'])) {
            $display = '��' . $_SESSION['bts_number'];
        } else {
            $display = '';
        }
    }
    if ($_GET['f'] == 8) {
        $name = '�������� ��������';
        if (!empty($_SESSION['bts_number'])) {
            $display = '��' . $_SESSION['bts_number'];
        } else {
            $display = '';
        }
    }
    if ($_GET['f'] == 9) {
        $name = '�������� ����������';
        if (!empty($_SESSION['bts_number'])) {
            $display = '��' . $_SESSION['bts_number'];
        } else {
            $display = '';
        }
    }
    if ($_GET['f'] == 10) {
        if (isset($_GET['type']) == false) {
            array_splice($_SESSION['sections'], 0);
            $name = '����������';
        }
        if ($_GET['type'] == 'trau') {
            $name = '�������� ���������� TRAU';
        }
        if ($_GET['type'] == 'ce') {
            $name = '�������� ���������� Channel Elements';
        }
        if ($_GET['type'] == 'rancell') {
            $name = '�������� ���������� RAN Cell';
        }
        if ($_GET['type'] == 'abis') {
            $name = '�������� ���������� ABIS';
        }
        if ($_GET['type'] == 'pcu') {
            $name = '�������� ���������� PCU';
        }
        if ($_GET['type'] == 'ranrnc') {
            $name = '�������� ���������� RAN RNC';
        }
    }
    if ($_GET['f'] == 11) {
        // ���������� �������� ����� 0-�� ������
        if (isset($_SESSION['sections'][0]['form'])) {
            foreach ($_SESSION['sections'][0]['form'] as $k => $v) {
                $nullsection[$k] = $v;
            }
        }
        array_splice($_SESSION['sections'], 0);
        $name = '������ �������';
    }
    if ($_GET['f'] == 12) {
        $name = '������ �������';
        $display = $_SESSION['budget_number'];
    }
    if ($_GET['f'] == 13) {
        $name = '�������� �������';
        $display = $_SESSION['budget_number'];
    }

    if ($_GET['f'] == 14) {
        array_splice($_SESSION['sections'], 0);
        $name = '�������������';
    }
    if ($_GET['f'] == 15) {
        if (isset($_GET['step1']) && !isset($_GET['update']))
            $name = '������ ������';
        if (isset($_GET['step1']) && isset($_GET['update']))
            $name = 'Update ������';
        if (isset($_GET['step2'])) {
            $name = '�������� �����';
            $display = $_POST['import_table'];
        }
        if (isset($_GET['step3'])) {
            $name = '����������� �����';
        }
        if (isset($_GET['step4']))
            $name = '�������� ������������';
    }
    if ($_GET['f'] == 16) {
        $name = '������� ���������';
        $display = $_SESSION['sections'][$last_index - 1]['display'];
    }
    if ($_GET['f'] == 17) {     // ���� � ��
        $name = '������� �������';
        if (!empty($_SESSION['bts_number'])) {
            $display = '��' . $_SESSION['bts_number'];
        } else {
            $display = '';
        }
    }
    if ($_GET['f'] == 18) {     // �������� ���. ������������ ��
        $name = '�������� ���. ������.';
        if (!empty($_SESSION['bts_number'])) {
            $display = '��' . $_SESSION['bts_number'];
        } else {
            $display = '';
        }
    }
    if ($_GET['f'] == 19) {     // �������� ���
        $name = '�������� ���';
    }
    if ($_GET['f'] == 20) {     // ���� � ��������
        $name = '��������';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 21) {     // ������ �������������
        array_splice($_SESSION['sections'], 1);
        $name = '������������';
    }
    if ($_GET['f'] == 22) {     // �������� �������������
        $name = '�������� ������������';
    }
    if ($_GET['f'] == 23) {     // ������������
        $name = '������������';
    }
    if ($_GET['f'] == 24) {     // ������ ��� � Lotus
        $name = '������ � Lotus';
    }
    if ($_GET['f'] == 25) {     // �������������� ����� 
        $name = '�������������� �����';
        if ($_GET['object'] == 'budget') {
            $display = '����� � ��������';
        }
    }
    if ($_GET['f'] == 26) {     // ������� ������������ 
        array_splice($_SESSION['sections'], 0);
        $name = '������� ������������';
    }
    if ($_GET['f'] == 27) {     // ����� ������, ������ 
        $name = '�������� �����������';
    }
    if ($_GET['f'] == 28) {     // �������� ��������� 
        // ���������� �������� ����� 0-�� ������
        if (isset($_SESSION['sections'][0]['form'])) {
            foreach ($_SESSION['sections'][0]['form'] as $k => $v) {
                $nullsection[$k] = $v;
            }
        }
        array_splice($_SESSION['sections'], 0);
        $name = '�������� ���������';
    }
    if ($_GET['f'] == 29) {     // ������������ ����������� 
        $name = '������������ �����������';
    }
    if ($_GET['f'] == 30) {     // ���� � ��������
        $name = '�������';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 31) {     // �������� ��������
        $name = '�������� ��������';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 32) {   // �������� �������� ��������
        $name = '�������� ��������';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 33) {   // �������� �������� ��������
        $name = '�������� ��������';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 34) {   // �������� ���������
        // ���������� �������� ����� 0-�� ������
        $nullsection = init_zero_section($_GET['f'], $_SESSION['sections'][0]);
        array_splice($_SESSION['sections'], 0);
        $name = '�������� ���������';
    }
    if ($_GET['f'] == 35) {     // ���� � ���������
        $name = '��';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 36) {     // �������� ���������
        $name = '��';
        $display = $_SESSION['display'];
    }
    if ($_GET['f'] == 37) {     // ������� ������� ���������
        $name = '������� �������';
    }

// ������� ���-�� ������
    $section_count = count($_SESSION['sections']);
    for ($i = 0; $i < $section_count; $i++) {
        if ($_SERVER['REQUEST_URI'] == $_SESSION['sections'][$i]['link']) {
            array_splice($_SESSION['sections'], $i + 1);
            break;
        }
    }

// ����� ������ ����������� ��������
    $_SESSION['sections'][$i]['name'] = $name;
    $_SESSION['sections'][$i]['link'] = $_SERVER['REQUEST_URI'];
    $_SESSION['sections'][$i]['id'] = $_GET['f'];
    if (isset($display) && ($i > 0)) {
        $_SESSION['sections'][$i - 1]['display'] = $display;
    }
    unset($_SESSION['sections'][$i]['display']);

// ������� �������� ����� ��� 0 ������
    if ($i == 0 && isset($nullsection)) {
        foreach ($nullsection as $k => $v) {
            $_SESSION['sections'][0]['form'][$k] = $v;
        }
    }
}

function get_curr_section_indx() {
    return count($_SESSION['sections']) - 1;
}

function GetFromPrvForm($key, $offset) { // ������ � ������ �� ���������� ����
    $last_index = count($_SESSION['sections']) - $offset - 1;
    $value = $_SESSION['sections'][$last_index]['form'][$key];
    return $value;
}

function PrvFill($key, $value) { // ���������� ����, ��������� ��������� ������ ��� ��������
    $last_index = count($_SESSION['sections']) - 1;
    if (isset($_SESSION['sections'][$last_index]['form'][$key])) {
        $value = $_SESSION['sections'][$last_index]['form'][$key];
    }
    return $value;
}

function CheckEmptyValues($arr, $size = 2) {// ��������� 2-� (1-��) ������ ������ �� ������� (������) ��������
    for ($i = 0; $i < count($arr); $i++) {
        if ($size == 1) {
            $s.= $arr[$i];
        }
        if ($size == 2) {
            foreach ($arr[$i] as $key => $value) {
                $s.=$value;
            }
        }
    }
    if (strlen(trim($s)) == 0) {
        return true;
    } else {
        return false;
    }
}

function BudgetFreeNumbers($gen, $year, $cat, $current) {    // ��������� ������ �������
    if (stripos($gen, '2g') !== false) {
        $num_field = 'budget_number_2g';
        $cat_field = 'budget_type_2g';
    }
    if (stripos($gen, '3g') !== false) {
        $num_field = 'budget_number_3g';
        $cat_field = 'budget_type_3g';
    }

    $sql = "SELECT max($num_field) FROM budget WHERE budget_year=$year AND $cat_field='$cat'";
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $max = $row[0];

    $sql = "SELECT $num_field FROM budget WHERE budget_year=$year AND $cat_field='$cat' GROUP BY $num_field";
    $query = mysql_query($sql) or die(mysql_error());
    $row = mysql_fetch_array($query);
    $freenumbers[] = array('value' => '', 'display' => '');
    for ($i = 1; $i < $max + 100; $i++) {
        if ($i == $row[0]) {
            $row = mysql_fetch_array($query);
        } else {
            $freenumbers[] = array('value' => $i, 'display' => $i);
        }
        if ($i == $current)
            $freenumbers[] = array('value' => $i, 'display' => $i);
    }
    return $freenumbers;
}

function DeleteInterfaceRow($index, $rn) {  // �������� ������ ������ ����������
    // ������� �� ������� ������
    if (isset($_SESSION['sections'][$index]['form'])) {
        $rn = $_GET['rn'];
        foreach ($_SESSION['sections'][$index]['form'] as $k => $v) {
            $i = substr($k, strrpos($k, '_') + 1, strlen($k));
            $r = substr($k, 0, strrpos($k, '_') + 1);
            if (is_numeric($i)) {
                if ($i == $rn) {
                    unset($_SESSION['sections'][$index]['form'][$k]);
                }
                if ($i > $rn) {
                    $ni = $i - 1;
                    $_SESSION['sections'][$index]['form'][$r . $ni] = $_SESSION['sections'][$index]['form'][$k];
                    unset($_SESSION['sections'][$index]['form'][$k]);
                }
                if ($i <> $pr_i)
                    $row_count++;
                $pr_i = $i;
            }
        }
        $_SESSION['sections'][$index]['form']['row_count'] = $row_count - 1;
    }
}

function AddInterfaceRow($index) {  // ���������� ������ ������ ����������
    if (isset($_SESSION['sections'][$index]['form'])) {
        $form = array_reverse($_SESSION['sections'][$index]['form']);
        foreach ($form as $k => $v) {
            $i = substr($k, strripos($k, '_') + 1, strlen($k));
            $r = substr($k, 0, strripos($k, '_') + 1);
            if (is_numeric($i)) {
                if ($i >= 0) {
                    $ni = $i + 1;
                    $form[$r . $ni] = $form[$k];
                    unset($form[$k]);
                }
                if ($i <> $pr_i)
                    $row_count++;
                $pr_i = $i;
            }
        }

        foreach ($form as $k => $v) {
            $i = substr($k, strripos($k, '_') + 1, strlen($k));
            $r = substr($k, 0, strripos($k, '_') + 1);
            if ($i == 1) {
                $form[$r . '0'] = '';
            }
        }
        $_SESSION['sections'][$index]['form'] = array_reverse($form);
        $_SESSION['sections'][$index]['form']['row_count'] = $row_count + 1;
    }
    if (!isset($_SESSION['sections'][$index]['form']['row_count']))
        $_SESSION['sections'][$index]['form']['row_count'] = 1;
}

function SlaveTableUpdate($data, $table, $master_field, $master_id, $fields, $history) {   // ���������� ���������� ������� �� �����
    foreach ($data as $key => $value) {  // ������������ ������ � ����� � �������� ���. ����� - ��������� � ������
        $i = substr($key, strripos($key, '_') + 1, strlen($key));
        $r = substr($key, 0, strripos($key, '_'));
        if (is_numeric($i) && in_array($r, $fields)) {
            $add_data[$i][$r] = $value;
        }
    }
    for ($i = 0; $i < count($add_data); $i++) {
        $id = $add_data[$i]['Id'];
        if (empty($id)) {                    // ����������
            $edit_type = 'insert';
        } else {
            $edit_type = 'update';              // ���������
        }
        unset($add_data[$i]['Id']);

        if ($table != 'rrl')
            $add_data[$i][$master_field] = $master_id;   // ��������� ���������� ���

        $id = MySQLAction($add_data[$i], $table, $id, $edit_type, $history, $master_id);
        $ids[] = $id;
    }

    $ids[] = 0;
    $sql = "SELECT Id FROM $table WHERE $master_field=$master_id AND Id NOT IN (" . implode(',', $ids) . ")";   // ��������
    if ($table == 'rrl')
        $sql = "SELECT Id FROM $table WHERE (bts_id_point1=$master_id OR bts_id_point2=$master_id) AND Id NOT IN (" . implode(',', $ids) . ")";   // ��������� ���������� ���
    $query = mysql_query($sql) or die(mysql_error());
    for ($j = 0; $j < mysql_num_rows($query); $j++) {
        $row = mysql_fetch_array($query);
        $id = $row['Id'];
        $edit_type = 'delete';
        MySQLAction('', $table, $id, $edit_type, $history, $master_id);
    }
}

function MySQLAction($data, $edit_table, $id, $edit_type, $history, $master_id = 0) {//������� ��������� ������ �� mysql + ������ � �������
    $sql2 = "SELECT * FROM $edit_table WHERE id=" . NumOrNull($id);     // ������ ��� ��������� ���������
    $query = mysql_query($sql2) or die(mysql_error());
    $row = mysql_fetch_assoc($query);

    if ($edit_type == 'insert') {          // INSERT
        $sql = "INSERT INTO $edit_table SET ";
    }
    if ($edit_type == 'update') {          // UPDATE
        $sql = "UPDATE $edit_table SET ";
        $where = " WHERE id=$id";
    }

    if ($edit_type != 'delete') {
        if ($edit_table == 'rrl' && $edit_type == 'update')
            $prechanges = "��� " . ValueById($row['bts_id_point1'], 'bts_id_point1') . " - " . ValueById($row['bts_id_point2'], 'bts_id_point2') . ";";

        $i = 0;
        foreach ($data as $key => $value) {
            if ($i > 0)
                $sql.=',';
            $sql.="$key=" . StrOrNull($value);
            $i++;

            if ($row[$key] != $value) {
                if (empty($changes))
                    $changes = $prechanges;
                if ($edit_type == 'update')
                    $changes.="$key " . '"' . ValueById($row[$key], $key) . '"' . " �������� �� " . '"' . ValueById($value, $key) . '"' . "; ";
                if ($edit_type == 'insert')
                    $changes.="$key �������� �������� " . '"' . ValueById($value, $key) . '"' . "; ";
            }
        }
        $sql.=" $where";
    }

    if ($edit_type == 'delete') {           // DELETE
        $sql = "DELETE FROM $edit_table WHERE id=$id";
        foreach ($row as $key => $value) {
            if (!empty($value))
                $changes.="$key ���� �������� " . '"' . ValueById($value, $key) . '"' . "; ";
        }
    }
    $query = mysql_query($sql) or die(mysql_error());
    if ($id == 0 || empty($id))
        $id = mysql_insert_id();

    // HISTORY
    if ($history) {
        if ($edit_type == 'insert') {
            
        }

        if ($edit_type == 'delete') {
            
        }

        if ($edit_type == 'update') {
            
        }

        if (!empty($changes)) {
            $sql = "INSERT INTO history SET";
            $sql.=" act_date=SYSDATE()";
            $sql.=",act_time=CURTIME()";
            $sql.=",user_id=" . $_SESSION['user_id'];
            $sql.=",table_name='$edit_table'";
            if ($master_id == 0) {
                $sql.=",object_id=$id";
            } else {
                $sql.=",object_id=$master_id";
            }
            $sql.=",action='$edit_type'";
            $sql.=",changes='$changes'";
            $query = mysql_query($sql) or die(mysql_error());
        }
    }

    return $id;
}

function ValueById($id, $field) {   // ����� �������� �� id �� ��������� �������
    $fields = array(// ������ ������ id  - ������� - ����
        array(
            'id_field' => 'bts_id'
            , 'table' => 'bts'
            , 'field' => 'bts_number'
        )
        , array(
            'id_field' => 'demontation_bts_id'
            , 'table' => 'bts'
            , 'field' => 'bts_number'
        )
        , array(
            'id_field' => 'construction_2g_type_id'
            , 'table' => 'construction_2g_types'
            , 'field' => 'construction_type'
        )
        , array(
            'id_field' => 'construction_3g_type_id'
            , 'table' => 'construction_3g_types'
            , 'field' => 'construction_type'
        )
        , array(
            'id_field' => 'construction_4g_type_id'
            , 'table' => 'construction_4g_types'
            , 'field' => 'construction_type'
        )
        , array(
            'id_field' => 'gsm_config_id'
            , 'table' => 'gsm_configs'
            , 'field' => 'gsm_config'
        )
        , array(
            'id_field' => 'dcs_config_id'
            , 'table' => 'dcs_configs'
            , 'field' => 'dcs_config'
        )
        , array(
            'id_field' => 'umts_config_id'
            , 'table' => 'umts_configs'
            , 'field' => 'umts_config'
        )
        , array(
            'id_field' => 'bsc_id'
            , 'table' => 'bsc'
            , 'field' => 'bsc_number'
        )
        , array(
            'id_field' => 'rnc_id'
            , 'table' => 'rnc'
            , 'field' => 'rnc_number'
        )
        , array(
            'id_field' => 'settlement_id'
            , 'table' => 'settlements'
            , 'field' => 'settlement'
        )
        , array(
            'id_field' => 'plan_gsm_config_id'
            , 'table' => 'gsm_configs'
            , 'field' => 'gsm_config'
        )
        , array(
            'id_field' => 'install_gsm_config_id'
            , 'table' => 'gsm_configs'
            , 'field' => 'gsm_config'
        )
        , array(
            'id_field' => 'work_gsm_config_id'
            , 'table' => 'gsm_configs'
            , 'field' => 'gsm_config'
        )
        , array(
            'id_field' => 'plan_dcs_config_id'
            , 'table' => 'dcs_configs'
            , 'field' => 'dcs_config'
        )
        , array(
            'id_field' => 'install_dcs_config_id'
            , 'table' => 'dcs_configs'
            , 'field' => 'dcs_config'
        )
        , array(
            'id_field' => 'work_dcs_config_id'
            , 'table' => 'dcs_configs'
            , 'field' => 'dcs_config'
        )
        , array(
            'id_field' => 'plan_umts_config_id'
            , 'table' => 'umts_configs'
            , 'field' => 'umts_config'
        )
        , array(
            'id_field' => 'work_umts_config_id'
            , 'table' => 'umts_configs'
            , 'field' => 'umts_config'
        )
        , array(
            'id_field' => 'plan_umts9_config_id'
            , 'table' => 'umts_configs'
            , 'field' => 'umts_config'
        )
        , array(
            'id_field' => 'work_umts9_config_id'
            , 'table' => 'umts_configs'
            , 'field' => 'umts_config'
        )
        , array(
            'id_field' => 'plan_lte_config_id'
            , 'table' => 'lte_configs'
            , 'field' => 'lte_config'
        )
        , array(
            'id_field' => 'work_lte_config_id'
            , 'table' => 'lte_configs'
            , 'field' => 'lte_config'
        )
        , array(
            'id_field' => 'power_type_id'
            , 'table' => 'power_types'
            , 'field' => 'power_type'
        )
        , array(
            'id_field' => 'antenna_type_id'
            , 'table' => 'antenna_types'
            , 'field' => 'antenna_type'
        )
        , array(
            'id_field' => 'bts_id_point1'
            , 'table' => 'bts'
            , 'field' => 'bts_number'
        )
        , array(
            'id_field' => 'bts_id_point2'
            , 'table' => 'bts'
            , 'field' => 'bts_number'
        )
        , array(
            'id_field' => 'projector_user_id'
            , 'table' => 'users'
            , 'field' => 'surname'
        )
        , array(
            'id_field' => 'agreem_person_id'
            , 'table' => 'agreement_persons'
            , 'field' => 'name'
        )
        , array(
            'id_field' => 'build_person_id'
            , 'table' => 'build_persons'
            , 'field' => 'name'
        )
        , array(
            'id_field' => 'build_organization_id'
            , 'table' => 'build_organizations'
            , 'field' => 'title'
        )
        , array(
            'id_field' => 'project_organization_id'
            , 'table' => 'project_organizations'
            , 'field' => 'title'
        )
        , array(
            'id_field' => 'budget_id'
            , 'table' => 'budget'
            , 'field' => 'outside_id'
        )
        , array(
            'id_field' => 'repeater_link_id'
            , 'table' => 'repeaters'
            , 'field' => 'repeater_number'
        )
    );

    for ($i = 0; $i < count($fields); $i++) {
        if ($field == $fields[$i]['id_field']) {
            $sql = "SELECT " . $fields[$i]['field'] . " FROM " . $fields[$i]['table'] . " WHERE id=" . StrOrNull($id);
            $query = mysql_query($sql) or die(mysql_error());
            $row = mysql_fetch_array($query);
            $value = $row[0];
        }
    }
    if (empty($id))
        $id = 'NULL';
    if (isset($value)) {
        return $value;
    } else {
        return $id;
    }
}

function ZeroOnEmpty($value) {   // ��� ������ ��� NULL ������� ��������� 0
    if (empty($value)) {
        return 0;
    } else {
        return $value;
    }
}

function NameFormat($format, $surname, $name, $middle_name = '') { // ����� ����� ������������ � �������
    if ($format == 'fio') {
        $name = $surname . " " . (!empty($name) ? substr($name, 0, 1) . '.' : '') . (!empty($middle_name) ? substr($middle_name, 0, 1) . '.' : '');
    }
    if ($format == 'full fio') {
        $name = $surname . " " . (!empty($name) ? $name . ' ' : '') . (!empty($middle_name) ? $middle_name . ' ' : '');
    }
    return $name;
}

function BtsFreeNumbers() {    // ��������� ������ ��
    $max = 6000;

    $sql = "SELECT bts_number FROM bts ORDER BY bts_number";
    $query = mysql_query($sql) or die(mysql_error());
    for ($i = 0; $i < mysql_num_rows($query); $i++) {
        $row = mysql_fetch_array($query);
        if (intval($row[0]) > 0)
            $used_numbers[] = intval($row[0]);
    }
    $freenumbers[] = array('value' => '', 'display' => '');

    for ($i = 1; $i < $max; $i++) {
        if (!in_array($i, $used_numbers)) {
            $cur = strval($i);
            if (strlen($cur) == 1)
                $cur = '00' . $cur;
            if (strlen($cur) == 2)
                $cur = '0' . $cur;
            $freenumbers[] = array('value' => $cur, 'display' => $cur);
        }
    }
    return $freenumbers;
}

// ���������� ��� ��������� ��������� GET
function update_get_query($get_key, $get_value) {
    $get = $_GET;
    $get[$get_key] = $get_value;
    return $_SERVER['PHP_SELF'] . "?" . http_build_query($get);
}

?>