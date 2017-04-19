<?php

// базовый класс представления
class view {

    private $lang_code;
    private $data;
    private $content_view;
    private $lang_array;

    function __construct($lang_code, $data) {
        $this->lang_code = $lang_code;
        $this->data = $data;
    }

    function put($key) {
        $result = $this->lang_array[$key][$this->lang_code];
        if (empty($result))
            $result = $this->lang_array[$key]['en'];
        if (empty($result))
            $result = 'not defined';
        echo $result;
    }
    
    function curr_format($value,$curr_id) {
        if (($curr_id)==974) $decimal=0; else $decimal=2;
        return number_format($value, $decimal, '.', ' ');
    }

    function include_view($view_file) {
        // подключаем файл переводов 
        $lang_file = "php/languages/lang_$view_file";
        if (file_exists($lang_file)) {
            include $lang_file;
            $this->lang_array = $lang_array;
        }
        $data = $this->data;
        include "php/views/$view_file";
    }

    public function generate($content_view, $template_view = null, $data = null) {
        if (isset($data))
            $this->data+= $data;
        $this->content_view = $content_view;

        // js connection
        //$js = "/js/debititems_list.js";
        // подключение представлений
        if (isset($template_view)) {
            $this->include_view("$template_view");
        } else {
            $this->include_view("$content_view");
        }
    }

    //public function ajax_response($content_view, $data = null) {
    //include "php/views/$content_view";
    //}
}

?>