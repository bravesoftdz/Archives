<?php

class controller_budget extends controller {

    function action_index() {
        $this->model = new model_budget($this->lang_code);
        $data = $this->model->index($_GET['period'],$_GET['begin'],$_GET['end']);
        $this->view->generate('view_budget.php','view_template.php',$data);
    }

    function action_edit() {
        $this->model = new model_budget();
        $data = $this->model->get_quota($_GET['q'], $_GET['a']);
        $this->view->generate('view_quota.php','view_template.php',$data);
    }

}

?>