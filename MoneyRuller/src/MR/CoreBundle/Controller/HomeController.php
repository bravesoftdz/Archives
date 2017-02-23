<?php

namespace MR\CoreBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class HomeController extends Controller {

    public function indexAction() {

        return $this->render('MRCoreBundle:Home:index.html.twig');
    }

}
