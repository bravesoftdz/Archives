<?php

class controller_auth extends controller {

    function action_logon() {
        $this->model = new model_auth();
        $data = $this->model->logon($_POST['login'], $_POST['password']);
        $host = 'http://'.$_SERVER['HTTP_HOST'].'/index.php';
        header('Location:'.$host);
    }

    function action_logoff() {
        $this->model = new model_auth();
        $data = $this->model->logoff();
        $host = 'http://'.$_SERVER['HTTP_HOST'].'/index.php';
        header('Location:'.$host);
    }

}

?>