<?php

class controller {

    public function create_view($view_name, $data) {
    
        // подключаем файл представления
        $view_name = 'view_' . $view_name;
        $view_file = strtolower($view_name) . '.php';
        $view_path = 'mvc/views/' . $view_file;
        if (file_exists($view_path)) {
            include $view_path;
        } else {
            //Route::ErrorPage404();
            echo ('didn`t find view');
            exit();
        }   
    }
}

?>