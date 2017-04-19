<?php

class controller_auth extends controller {

    public function action_getstate() {
        
        $_SESSION['user_id'] = 1;
        
        $this->create_model('model_auth');
        $data = $this->model->getstate();
	$this->set_output($data);        
    }

    function action_signin() {
        $this->create_model('model_auth');
        $data = $this->model->signin($_POST['login'], $_POST['password']);
        $this->set_output($data);
        //$host = 'http://'.$_SERVER['HTTP_HOST'].'/index.php';
        //header('Location:'.$host);
    }

    function action_signout() {
        //$this->model = new model_auth();
        //$data = $this->model->signout();
        //$this->set_output($data);
        //$host = 'http://'.$_SERVER['HTTP_HOST'].'/index.php';
        //header('Location:'.$host);
    }

}

?>