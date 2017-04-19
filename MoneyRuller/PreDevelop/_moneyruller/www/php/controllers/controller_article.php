<?php

class controller_article extends controller {

    function action_index() {
        $this->model = new model_article($this->lang_code);
        $data = $this->model->index($_GET['uaid']);
        $this->view->generate('view_article.php', 'view_template.php', $data);
    }

    function action_update() {
        $this->model = new model_article($this->lang_code);
        $data = $this->model->update($_POST['id'], $_POST['title']);
        $this->view->generate('view_article.php', 'view_template.php', $data);
    }
    
    function action_add() {
        $this->model = new model_article($this->lang_code);
        $autid = $this->model->add($_GET['autid']);
        $data = $this->model->index($autid);
        $this->view->generate('view_article.php', 'view_template.php', $data);
    }

}

?>