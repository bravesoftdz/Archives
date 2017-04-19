<?php

class model_budget extends model {

    public function index($period=null,$begin=null,$end=null) {
        // определяем период
        if (!isset($period) || ($period == "current")) $date = new DateTime();
        if ($period == "previous") {
          $date = new DateTime($begin);
          $date->sub(new DateInterval('P1D'));
        }
        if ($period == "next") {
          $date = new DateTime($end);
          $date->add(new DateInterval('P1D'));
        }

        $accounting_period = $this -> get_accounting_period();
        switch ($accounting_period) {
          case 'month':
            $begin = $date->format('Y-m-01');
            $end = $date->format('Y-m-t');
        }         

        $data['begin']=$begin;
        $data['end']=$end;
    
        // выбор категорий
        $sql = "select uat.id";
        $sql.= ",GetTextByLid(uat.lid,'" . $this->lang_code . "') as title";
        $sql.= ",ifnull(uat.order_num,100) as order_num";
        $sql.= ",is_fixed";
        $sql.= ",article_type_id";
        $sql.= " from user_article_types uat";
        $sql.= " left join article_types at on at.id=uat.article_type_id";
        $sql.= " where uat.user_id=" . $this->str_shield($_SESSION['user_id']);
        $sql.= " and uat.section_id=3";
        $sql.= " and uat.parent_id is null";
        $sql.= " order by order_num";            
        $result_types = $this->select($sql);
        $type_num = -1;

        while ($row = $result_types->fetch_assoc()) {
            $type_num++;
            $data['expense_types'][] = $row;       

            // выбор подкатегорий и статей
            $sql = " select z.*, sum(z.quota_val) as quota_value, sum(z.quota2_val) as quota2_value";
            $sql.= ",GetDebTurnByArticle(id," . $this->get_main_curr_id() . ",'$begin','$end') as deb_value";
            $sql.= ",GetDebTurnByArticle(id," . $this->get_slave_curr_id() . ",'$begin','$end') as deb2_value";
            $sql.= " from ";
            $sql.= "(select";
            $sql.= " ua.id";
            $sql.= ",uat.id as uat_id";
            $sql.= ",GetTextByLid(uat.lid,'" . $this->lang_code . "') as type_title";
            $sql.= ",GetTextByLid(ua.lid,'" . $this->lang_code . "') as article_title";
            $sql.= ",GetCurrEq(sum(q.value), q.curr_id, " . $this->get_main_curr_id() . ", curdate()) as quota_val";
            $sql.= ",GetCurrEq(sum(q.value), q.curr_id, " . $this->get_slave_curr_id() . ", curdate()) as quota2_val";
            $sql.= " from user_article_types uat";
            $sql.= " left join user_articles ua on ua.user_article_type_id=uat.id";
            $sql.= " left join quotas q on q.user_article_id=ua.id and q.begin>='$begin' and q.expire<='$end'";
            $sql.= " where parent_id=" . $this->str_shield($row['id']);           
            $sql.= " group by ua.id, q.curr_id";
            $sql.= " ) z";
            $sql.= " group by id";
            $sql.= " order by type_title";  
            
            // для не фиксированных статей условие вывода наличие квоты или оборот в периоде
            if ($row['is_fixed'] != 1) {
                $sql = 'select * from (' . $sql;
                $sql.= ') z where quota_value>0 or deb_value>0';      
            }        
                            
            $result_sabtypes = $this->select($sql);   
            
            $articles = array();
            $subtype_title = '';
            $subtype_num = -1;
            
            if ($result_sabtypes->num_rows > 0) {
    
                while ($row_subtype = $result_sabtypes->fetch_assoc()) {
                    if ($row_subtype['type_title'] != $subtype_title) {
                        // записываем новую статью
                        $subtype_num++;
                        $articles[] = array('type_title' => $row_subtype['type_title'], 'uat_id' => $row_subtype['uat_id'], 'articles' => array());
                        $subtype_title = $row_subtype['type_title'];
                    }
                    $articles[$subtype_num]['articles'][] = $row_subtype;
                    // считаем итого по основной валюте
                    $data['total']['quot_main_curr'][$row_subtype['uat_id']]+= $row_subtype['quota_value'];
                    $data['total']['quot_main_curr'][$row['id']]+= $row_subtype['quota_value'];
                    $data['total']['deb_main_curr'][$row_subtype['uat_id']]+= $row_subtype['deb_value'];
                    $data['total']['deb_main_curr'][$row['id']]+= $row_subtype['deb_value'];
                    $data['total']['expenses']['quot_main_curr']+=$row_subtype['quota_value']; 
                    $data['total']['expenses']['deb_main_curr']+=$row_subtype['deb_value']; 
                    // считаем итого по второй валюте
                    $data['total']['quot_second_curr'][$row_subtype['uat_id']]+= $row_subtype['quota2_value'];
                    $data['total']['quot_second_curr'][$row['id']]+= $row_subtype['quota2_value'];
                    $data['total']['deb_second_curr'][$row_subtype['uat_id']]+= $row_subtype['deb2_value'];
                    $data['total']['deb_second_curr'][$row['id']]+= $row_subtype['deb2_value'];
                    $data['total']['expenses']['quot_slave_curr']+=$row_subtype['quota2_value']; 
                    $data['total']['expenses']['deb_slave_curr']+=$row_subtype['deb2_value']; 
                }
            }
            $data['expense_types'][$type_num]+= array('subtypes' => $articles);
        }
        $data['currencies']['main_curr'] = $this->get_main_curr();
        $data['currencies']['slave_curr'] = $this->get_slave_curr();
        $data['currencies']['main_curr_id'] = $this->get_main_curr_id();
        $data['currencies']['slave_curr_id'] = $this->get_slave_curr_id();


        $data['is_slave_show'] = false;
        return $data;
    }

    public function get_quota($quota_id, $user_article_id, $begin = null, $expire = null) {
        $sql = "select *";
        $sql.= " from user_articles ua";
        $sql.= " join user_article_types uat on uat.id=ua.user_article_type_id";
        $sql.= " left join quotas q on q.user_article_id=ua.id";
        $sql.= " where ua.id='" . $this->str_shield($user_article_id) . "'";
        $result = $this->select($sql);
        while ($row = $result->fetch_assoc()) {
            $data['quota'][] = $row;
        }
        return $data;
    }

}

?>
