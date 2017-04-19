<?php

class model_article extends model {

    public function index($uaid) {
        $lang_code = $this->lang_code;
        $main_curr_id = $this->get_main_curr_id();

        $sql = "select";
        $sql.= " ua.id as uaid";
        $sql.= ",GetTextByLid(ua.lid,'$lang_code') as article_title";
        $sql.= ",GetTextByLid(uast.lid,'$lang_code') as subtype_title";
        $sql.= ",GetTextByLid(uat.lid,'$lang_code') as type_title";
        $sql.= ",(select count(*) from transactions where article_id=ua.id and value_date between '2016-02-01' and '2016-02-29') count_pr";
        $sql.= ",(select count(*) from transactions where article_id=ua.id and value_date between '2016-01-01' and '2016-01-31') count_pr2";
        $sql.= ",(select count(*) from transactions where article_id=ua.id and value_date between '2015-12-01' and '2015-12-31') count_pr3";
        $sql.= ",GetDebTurnByArticle(ua.id,974,'2016-03-01','2016-03-31') as deb_value";
        $sql.= ",GetDebTurnByArticle(ua.id,974,'2016-02-01','2016-02-29') as pr_deb_value";
        $sql.= ",GetDebTurnByArticle(ua.id,974,'2016-01-01','2016-02-29')/2 as pr2_deb_value";
        $sql.= ",GetDebTurnByArticle(ua.id,974,'2015-12-01','2016-02-29')/3 as pr3_deb_value";
        $sql.= " from user_articles ua";
        $sql.= " join user_article_types uast on uast.id=ua.user_article_type_id";
        $sql.= " join user_article_types uat on uat.id=uast.parent_id";
        $sql.= " where ua.id=" . $this->str_shield($uaid);

        $result = $this->select($sql);
        while ($row = $result->fetch_assoc()) {
            $data = $row;
        }

        return $data;
    }

    public function update($id, $title) {
        $sql = "select *";
        $sql.= " from user_articles ua";
        $sql.= " left join translations t on t.lid=ua.lid";
        $sql.= " where ua.id=" . $this->str_shield($id);

        $result = $this->select($sql);
        $row = $result->fetch_assoc();

        if (!empty($row['lid'])) {
            $sql = "update translations set value=" . $this->str_shield($title);
            $sql.= " where lid = " . $this->str_shield($row['lid']);
            $sql.= " and lang_code = 'ru'";
            $this->execSQL($sql);
        } else {
            $sql = "select max(lid)+1 as next_lid from translations";
            $result = $this->select($sql);
            $row = $result->fetch_assoc();
            $next_lid = $row['next_lid'];
            $sql = "insert into translations set value=" . $this->str_shield($title);
            $sql.= ",lid = " . $this->str_shield($next_lid);
            $sql.= ",lang_code = 'ru'";
            $this->execSQL($sql);
            
            $sql = "update user_articles set lid = ". $this->str_shield($next_lid);
            $sql.= " where id =  ". $this->str_shield($id);
            $this->execSQL($sql);
        }
    }

    public function add($uatid) {
        $sql = "insert into user_articles set";
        $sql.= " user_article_type_id=" . $this->str_shield($uatid);
        $sql.= ",user_id=" . $this->str_shield($_SESSION['user_id']);
        return $this->execSQL($sql);
    }

}

?>
