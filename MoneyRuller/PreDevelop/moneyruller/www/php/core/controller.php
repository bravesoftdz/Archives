<?php

// базовый класс контроллера
class controller {

    public $is_api;
    public $model;
    public $view;
    public $lang_code;

    // конструктор
    public function __construct($is_api, $lang_code) {

        $this->is_api = $is_api;
        $this->lang_code = $lang_code;

        //$this->view = new view($this->lang_code, $data);
    }

    protected function create_model($model_name) {
        $this->model = new $model_name($this->lang_code);
    }

    protected function set_output($data) {
        if ($this->is_api)
            echo json_encode($data);
    }

}

?>