<?php

namespace ParseItAll\Bundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class HomeController extends Controller {

    public function indexAction() {
        
        return $this ->render('ParseItAllBundle::index.html.twig');
        
    }

}
