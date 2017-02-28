<?php

namespace PIA\appBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class JobsController extends Controller {

    public function listAction() {

        $jobs = $this->getDoctrine()->getRepository('PIABundle:Jobs')
                ->findAll();

        return $this->render('PIABundle:Jobs:job_list.html.twig', array(
                    'jobs' => $jobs
        ));
    }

}
