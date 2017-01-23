<?php

namespace PIA\appBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class TestRulesController extends Controller {

    public function indexAction($jobid) {

        $job = $this->getDoctrine()->getRepository('PIABundle:Jobs')
                ->find($jobid);

        return $this->render('PIABundle:TestRules:index.html.twig', array(
                    'job' => $job
        ));
    }

}
