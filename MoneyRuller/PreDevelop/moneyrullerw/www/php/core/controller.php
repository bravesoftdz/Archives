<?php

// базовый класс контроллера
class controller {

    public $model;
    public $view;
    public $lang_code;

    function set_lang_code() {
      if (isset($_GET['lang'])) $_SESSION['lang_code'] = $_GET['lang'];
    }

    function get_lang_code() {
        if (isset($_SESSION['lang_code'])) return $_SESSION['lang_code'];
        else return 'en';
    }

    // конструктор
    function __construct() {
        //
        $this->set_lang_code();
        $this->lang_code = $this->get_lang_code();
        //
        $this->model = new model();
        $data = $this->model->get_init($this->lang_code);
        //
        $this->view = new view($this->lang_code, $data);
    }
}

?>