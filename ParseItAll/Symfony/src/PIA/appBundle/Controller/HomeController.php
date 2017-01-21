<?php

namespace PIA\appBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class HomeController extends Controller {

    public function indexAction() {

        $jobs = $this->getDoctrine()->getRepository('PIABundle:Jobs')
                ->findAll();

        return $this->render('PIABundle:Jobs:index.html.twig', array(
                    'jobs' => $jobs
        ));
    }

}
