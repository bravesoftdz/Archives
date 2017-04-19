<?php

// подключение к MySQL
$mysqli = new mysqli("127.0.0.1", "moneyruller", "Underground20", "moneyruller");
$mysqli->query('set names utf8');
if ($mysqli->connect_errno) {
    exit;
}

// бозовый класс модели
class model {

    private $mysqli;
    protected $lang_code;

    // конструктор
    public function __construct($lang_code = null) {
        global $mysqli;
        $this->mysqli = $mysqli;
        $this->lang_code = $lang_code;
    }

    // экранирование строки
    protected function str_shield($str) {
        return "'" . $this->mysqli->real_escape_string($str) . "'";
    }

    // функция select
    protected function select($sql) {
        return $this->mysqli->query($sql);
    }

    // функция execSQL
    protected function execSQL($sql) {
        $this->mysqli->query($sql);
        return $this->mysqli->insert_id; 
    }
    
    // функция insert
    protected function insert($table, $insert_data) {
        $sql = "INSERT INTO $table SET";
        $i = 0;
        foreach ($insert_data as $key => $value) {
            if ($i == 0) {
                $sql.= " ";
            } else {
                $sql.= ",";
            }
            $sql.= "$key='" . $this->str_shield($value) . "'";
            $i++;
        }
        $this->mysqli->query($sql);
    }

    //
    function get_init($lang_code) {
        $sql = "select * from languages l where l.lang_code=" . $this->str_shield($lang_code);
        $sql.= " union";
        $sql.= " (select * from languages l where l.lang_code<>" . $this->str_shield($lang_code) . " order by l.lang_code)";
        $result = $this->select($sql);
        while ($row = $result->fetch_assoc()) {
            $add = 'lang=' . $row['lang_code'];
            $url = (isset($_SERVER['REQUEST_URI'])) ? '?' : '&';
            $url.= $add;
            $row['url'] = $url;
            $data['languages'][] = $row;
        }
        return $data;
    }

    // получить ID основной валюты для пользователя
    function get_main_curr_id() {
        $sql = "select GetUserMainCurrId(" . $this->str_shield($_SESSION['user_id']) . ") as CurrID";
        $result = $this->select($sql);
        $row = $result->fetch_assoc();
        return $row['CurrID'];
    }

    // получить ID второй валюты для пользователя
    function get_slave_curr_id() {
        $sql = "select GetUserSecondCurrId(" . $this->str_shield($_SESSION['user_id']) . ") as CurrID";
        $result = $this->select($sql);
        $row = $result->fetch_assoc();
        return $row['CurrID'];
    }

    // получить код основной валюты для пользователя
    function get_main_curr() {
        $sql = "select code from users u join currencies c on c.id=u.main_curr_id where u.id=" . $this->str_shield($_SESSION['user_id']);
        $result = $this->select($sql);
        $row = $result->fetch_assoc();
        return $row['code'];
    }

    // получить код второй валюты для пользователя
    function get_slave_curr() {
        $sql = "select code from users u join currencies c on c.id=u.second_curr_id where u.id=" . $this->str_shield($_SESSION['user_id']);
        $result = $this->select($sql);
        $row = $result->fetch_assoc();
        return $row['code'];
    }

    // получить вид отчётного периода пользователя
    function get_accounting_period() {
        $sql = "select accounting_period from users where id=" . $this->str_shield($_SESSION['user_id']);
        $result = $this->select($sql);
        $row = $result->fetch_assoc();
        return $row['accounting_period'];
    }

}

?>