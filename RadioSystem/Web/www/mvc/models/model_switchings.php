<?php

class model_switchings {

    public function get_list(array $stat_categories, array $tech_categories, array $filters, $sort, $offset, $offset_size) {

        // ������ ��������� �����
        $data['fields'][] = array('name' => 'bts_number', 'title' => '����� ��');
        $data['fields'][] = array('name' => 'settlement', 'title' => '���. �����');
        $data['fields'][] = array('name' => 'area', 'title' => '�����');
        $data['fields'][] = array('name' => 'region', 'title' => '�������');
        $data['fields'][] = array(
            'name' => 'address'
            , 'title' => '�����'
            , 'code' => 'GetAddressString(street_type, street_name, house_type, house_number)'
        );
        $data['fields'][] = array('name' => 'belgei_2g', 'title' => '������ 2G');
        $data['fields'][] = array('name' => 'act_2g', 'title' => '��� �����. 2G');
        $data['fields'][] = array('name' => 'gsm', 'title' => 'GSM');
        $data['fields'][] = array('name' => 'dcs', 'title' => 'DCS');
        $data['fields'][] = array('name' => 'belgei_3g', 'title' => '������ 3G');
        $data['fields'][] = array('name' => 'act_3g', 'title' => '��� �����. 3G');
        $data['fields'][] = array('name' => 'umts2100', 'title' => 'UMTS 2100');
        $data['fields'][] = array('name' => 'belgei_3g9', 'title' => '������ umts900');
        $data['fields'][] = array('name' => 'act_3g9', 'title' => '��� �����. umts900');
        $data['fields'][] = array('name' => 'umts900', 'title' => 'UMTS 900');
        $data['fields'][] = array('name' => 'lte', 'title' => 'LTE (bCloud)');
        $data['fields'][] = array('name' => 'stat', 'title' => '����������');
        $data['fields'][] = array('name' => 'uninstall', 'title' => '��������');

        // ��������� ������ sql �� ��������� �����
        $i = 0;
        foreach ($data['fields'] as $field) {
            $i++;
            if ($i > 1)
                $sql_fields.= ',';
            else
                $sql_fields.= ' ';
            if (isset($field['code'])) {
                $sql_fields.= $field['code'] . ' as ' . $field['name'];
            } else
                $sql_fields.= $field['name'];
            $data['fields'][$i - 1]['sort_link'] = update_get_query('sort', $data['fields'][$i - 1]['name']);
        }

        // ��������� �������          
        $sql_categories.= " and ((sw.id=0)";
        foreach ($stat_categories as $key => $value) {
            if ($value == 1) {
                $sql_categories.= " or ";
                if ($key == 'is_on') {
                    $sql_categories.= "(is_on = 1)";
                    $data['categories_notes'].=' [����������]';
                }    
                if ($key == 'is_uninst') {
                    $sql_categories.= "(uninstall is not null and is_on is null)";
                    $data['categories_notes'].=' [���������������]';
                }    
                if ($key == 'is_ready') {
                    $sql_categories.= "(is_on is null and ((belgei_2g is not null and act_2g is not null) or (belgei_3g is not null and act_3g is not null) or (belgei_3g9 is not null and act_3g9 is not null) or (lte is not null)) and stat is not null and uninstall is null)";
                    $data['categories_notes'].=' [������� � ���������]';
                }
                if ($key == 'is_not_ready') {
                    $sql_categories.= "(is_on is null and uninstall is null and (belgei_2g is null or act_2g is null or belgei_3g is null or act_3g is null or belgei_3g9 is null or act_3g9 is null or lte is null or stat is null))";
                    $data['categories_notes'].=' [�� ������� � ���������]';
                }  
                $data['categories'][$key] = 'checked';
            }
        }
        $sql_categories.=")";

        // ��������� ����������
        $sql_categories.= " and ((sw.id=0)";
        foreach ($tech_categories as $key => $value) {
            if ($value == 1) {
                $sql_categories.= " or ";
                if ($key == 'is_2g_only') {
                    $sql_categories.= "((work_gsm_config_id>0 or work_dcs_config_id>0 or plan_gsm_config_id>0 or plan_dcs_config_id>0) and work_umts_config_id is null and work_umts9_config_id is null and work_lte_config_id is null and plan_umts_config_id is null and plan_umts9_config_id is null and plan_lte_config_id is null)";
                    $data['categories_notes'].=' [2G only]';
                }
                if ($key == 'is_2g') {
                    $sql_categories.= "(work_gsm_config_id>0 or work_dcs_config_id>0 or plan_gsm_config_id>0 or plan_dcs_config_id>0)";
                    $data['categories_notes'].=' [2G]';
                }
                if ($key == 'is_3g_only') {
                    $sql_categories.= "((work_umts_config_id>0 or plan_umts_config_id>0 or plan_umts_config_id>0 or plan_umts_config_id>0) and work_gsm_config_id is null and work_dcs_config_id is null and work_lte_config_id is null and plan_gsm_config_id is null and plan_dcs_config_id is null and plan_lte_config_id is null)";
                    $data['categories_notes'].=' [3G only]';
                }
                if ($key == 'is_3g') {
                    $sql_categories.= "(work_umts_config_id>0 or plan_umts_config_id>0)";
                    $data['categories_notes'].=' [3G]';
                }
                if ($key == 'is_3g9') {
                    $sql_categories.= "(work_umts9_config_id>0 or plan_umts9_config_id>0)";
                    $data['categories_notes'].=' [3G 900]';
                }
                if ($key == 'is_4g') {
                    $sql_categories.= "(work_lte_config_id>0 or plan_lte_config_id>0)";
                    $data['categories_notes'].=' [4G]';
                }
                $data['categories'][$key] = 'checked';
            }
        }
        $sql_categories.=")";

        // �������
        foreach ($filters as $key => $value) {
            if (!empty($value)) {
                $sql_value = str_replace("*", "%", $value);
                $is_add_code = false;
                foreach ($data['fields'] as $field) {
                    if ($field['name'] == $key) {
                        if (isset($field['code'])) {
                            $sql_filters.= " and " . $field['code'] . " like '$sql_value'";
                            $is_add_code = true;
                        }
                    }
                }
                if (!$is_add_code)
                    $sql_filters.= " and $key like '$sql_value'";
                $data['filters'][$key] = $value;
                $data['filters_notes'].=" [$key = $value]";
            }
        }

        // ����������
        if (!empty($sort)) {
            $sort_field = $sort;
        } else {
            $sort_field = $data['fields'][0]['name'];
        }
        $data['sort'] = $sort_field;
        $sql_order = " order by $sort_field";

        // ��������
        $sql_limit = " limit $offset, $offset_size";

        // ���� SQL 
        $sql_body = ' from bts';
        $sql_body.= ' join settlements stl on stl.id=bts.settlement_id';
        $sql_body.= ' join areas on areas.id=stl.area_id';
        $sql_body.= ' join regions r on r.id=areas.region_id';
        $sql_body.= ' left join switchings sw on sw.bts_id=bts.id';
        $sql_body.= ' where bts.bts_number is not null';
        $sql_body.= $sql_filters;
        $sql_body.= $sql_categories;

        // ���������� ��� - �� ����� �������
        $sql = 'select count(*)';
        $sql.= $sql_body;
        $query = mysql_query($sql) or die(mysql_error());
        $row = mysql_fetch_array($query, MYSQL_NUM);
        $data['all_records_count'] = $row[0];

        // ������ - ����� �������
        $sql = 'select';
        $sql.= $sql_fields;
        $sql.= ',is_on';
        $sql.= ',ifnull(work_gsm_config_id, plan_gsm_config_id) as conf_gsm';
        $sql.= ',ifnull(work_dcs_config_id, plan_dcs_config_id) as conf_dcs';
        $sql.= ',ifnull(work_umts_config_id, plan_umts_config_id) as conf_umts';
        $sql.= ',ifnull(work_umts9_config_id, plan_umts9_config_id) as conf_umts9';
        $sql.= ',ifnull(work_lte_config_id, plan_lte_config_id) as conf_lte';
        $sql.= $sql_body;
        $sql.= $sql_order;
        $data['transfer_sql'] = $sql; // ��� �������� � ������� �������
        $sql.= $sql_limit;

        $query = mysql_query($sql) or die(mysql_error());
        $data['rows'] = array();
        for ($i = 0; $i < mysql_num_rows($query); $i++) {
            $row = mysql_fetch_array($query, MYSQL_ASSOC);
            $data['rows'][] = $row;
        }

        // ������ �� ����/���� ��������
        if ($i > 0)
            $data['offset_start'] = $offset + 1;
        else
            $data['offset_start'] = $offset;
        $data['offset_end'] = $offset + $i;
        if ($offset > 0) {
            $data['previous_page_link'] = update_get_query('offset', $offset - $offset_size);
        }
        if ($data['offset_end'] < $data['all_records_count']) {
            $data['next_page_link'] = update_get_query('offset', $offset + $offset_size);
        }

        return $data;
    }

    private function fill_data_counter($region, $row, $data, $order) {

        $data['total'][$order]['region'] = $region;
        if (!empty($row['conf_gsm'])) {
            $data['total'][$order]['conf_gsm'] ++;
            $data['conf_gsm_total'] ++;
        }    
        if (!empty($row['conf_dcs'])) {
            $data['total'][$order]['conf_dcs'] ++;
            $data['conf_dcs_total'] ++;
        }
        if (!empty($row['conf_umts'])) {
            $data['total'][$order]['conf_umts'] ++;
            $data['conf_umts_total'] ++;
        }
        if (!empty($row['conf_umts9'])) {
            $data['total'][$order]['conf_umts9'] ++;
            $data['conf_umts9_total'] ++;
        }
        if (!empty($row['conf_lte'])) {
            $data['total'][$order]['conf_lte'] ++;
            $data['conf_lte_total'] ++;
        }
        if (!empty($row['uninstall']) && empty($row['is_on'])) {
            $data['total'][$order]['uninstall'] ++;
            $data['uninstall_total'] ++;  
        }
        
        // ��������
        // ������ 2G
        if ((!empty($row['conf_gsm']) || !empty($row['conf_dcs'])) && empty($row['conf_umts']) && empty($row['conf_umts9']) && empty($row['conf_lte'])) {
            $data['total'][$order]['2g_only'] ++;
            $data['total'][$order]['sites'] ++;
            $data['2g_only_total'] ++;
            $data['sites_total'] ++;
        }
        // 2G/3G
        if ((!empty($row['conf_gsm']) || !empty($row['conf_dcs'])) && (!empty($row['conf_umts']) || !empty($row['conf_umts9']))) {
            $data['total'][$order]['2g/3g'] ++;
            $data['total'][$order]['sites'] ++;
            $data['2g/3g_total'] ++;
            $data['sites_total'] ++;
        }
        // ������ 3G
        if ((!empty($row['conf_umts']) || !empty($row['conf_umts9'])) && empty($row['conf_gsm']) && empty($row['conf_dcs']) && empty($row['conf_lte'])) {
            $data['total'][$order]['3g_only'] ++;
            $data['total'][$order]['sites'] ++;
            $data['3g_only_total'] ++;
            $data['sites_total'] ++;
        }
        
        return $data;
    }

    public function get_total($base_sql) {

        $query = mysql_query($base_sql) or die(mysql_error());

        // �������
        for ($i = 0; $i < mysql_num_rows($query); $i++) {
            $row = mysql_fetch_array($query);

            if ($row['region'] == '���������' && $row['settlement'] != '�����')
                $data = $this->fill_data_counter('��������� ���. (��� ������)', $row, $data, 1);
            if ($row['settlement'] == '�����')
                $data = $this->fill_data_counter('�����', $row, $data, 2);

            if ($row['region'] == '���������' && $row['settlement'] != '�������')
                $data = $this->fill_data_counter('��������� ���. (��� ��������)', $row, $data, 3);
            if ($row['settlement'] == '�������')
                $data = $this->fill_data_counter('�������', $row, $data, 4);

            if ($row['region'] == '����������' && $row['settlement'] != '������')
                $data = $this->fill_data_counter('���������� ���. (��� ������)', $row, $data, 5);
            if ($row['settlement'] == '������')
                $data = $this->fill_data_counter('������', $row, $data, 6);

            if ($row['region'] == '�����������' && $row['settlement'] != '������')
                $data = $this->fill_data_counter('����������� ���. (��� ������)', $row, $data, 7);
            if ($row['settlement'] == '������')
                $data = $this->fill_data_counter('������', $row, $data, 8);

            if ($row['region'] == '�������' && $row['settlement'] != '�����')
                $data = $this->fill_data_counter('������� ���. (��� ������)', $row, $data, 9);
            if ($row['settlement'] == '�����')
                $data = $this->fill_data_counter('�����', $row, $data, 10);

            if ($row['region'] == '����������' && $row['settlement'] != '������')
                $data = $this->fill_data_counter('���������� ���. (��� �������)', $row, $data, 11);
            if ($row['settlement'] == '������')
                $data = $this->fill_data_counter('������', $row, $data, 12);
        }

        $data['total'] = set_array_type($data['total']);
        ksort($data['total']);
        return $data;
    }

}

?>