<?php

namespace PIA\appBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class JobsController extends Controller {

    public function listAction() {

        $repository = $this->getDoctrine()->getRepository('PIABundle:Jobs');

        $user_id = $this->getUser()->getId();
        
        $query = $repository->createQueryBuilder('p')
                ->where('p.user = :user')
                ->setParameter('user', $user_id)
                ->orderBy('p.id', 'ASC')
                ->getQuery();
        $jobs = $query->getResult();

        return $this->render('PIABundle:Jobs:job_list.html.twig', array(
                    'jobs' => $jobs
        ));
    }
    
    public function addAction() {
        
    }

}
