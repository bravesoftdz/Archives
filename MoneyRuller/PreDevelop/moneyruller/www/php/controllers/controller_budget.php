<?php

class controller_budget extends controller {

    //function action_index() {
    //    $this->create_model('model_budget');
    //    $data = $this->model->index($_GET['period'], $_GET['begin'], $_GET['end']);
    //    echo json_encode($data);
    //    //$this->view->generate('view_budget.php','view_template.php',$data);
    //}
    //function action_edit() {
    //    //$this->model = new model_budget();
    //    //$data = $this->model->get_quota($_GET['q'], $_GET['a']);
    //    //$this->view->generate('view_quota.php','view_template.php',$data);
    //}

    public function action_expences() {

        $this->create_model('model_budget');
        $data = $this->model->get_expences($_GET['from'], $_GET['to']);
        $this->set_output($data);
    }

}

?>