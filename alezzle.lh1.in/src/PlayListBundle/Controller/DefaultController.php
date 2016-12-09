<?php

namespace PlayListBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Doctrine\ORM\Tools\Pagination\Paginator;

class DefaultController extends Controller
{
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();
              
        $artists = $em->createQueryBuilder()
            ->select('b.id, b.title')
            ->from('PlayListBundle:Artists',  'b')
            ->orderBy('b.title')
            ->getQuery()
            ->getResult(); 
            
        $genres = $em->createQueryBuilder()
            ->select('b.id, b.name')
            ->from('PlayListBundle:Genres',  'b')
            ->orderBy('b.name')
            ->getQuery()
            ->getResult(); 
            
        $years = $em->getRepository('PlayListBundle:Tracks')
            ->createQueryBuilder('t')
            ->select('t.year')
            ->groupBy('t.year')
            ->orderBy('t.year')
            ->getQuery()
            ->getResult();          

        return $this->render('PlayListBundle:Default:index.html.twig'
            ,array('json' => json_encode(array(
                                                'artists' => $artists,
                                                'genres' => $genres,
                                                'years' => $years 
            )))    
        );        
    }
    
    public function ajaxAction() {  
        $request = $this->getRequest();
        
        $limit = $request->query->get('limit');
        $offset = $request->query->get('page');
        if (!empty($offset)) {$offset = ($offset-1) * $limit;} else $offset = 0; 
        $sort = $request->query->get('sort');
        if (empty($sort)) $sort = 't.id';
        $direction = $request->query->get('direction');
        $artist = $request->query->get('artist');
        $genre = $request->query->get('genre');
        $year = $request->query->get('year');
        if (!empty($artist)) $artistWhere = "a.id='$artist'"; else $artistWhere="1=1";
        if (!empty($genre)) $genreWhere = "g.id='$genre'"; else $genreWhere="1=1";
        if (!empty($year)) $yearWhere = "t.year='$year'"; else $yearWhere="1=1";
        
        $em = $this->getDoctrine()->getManager()->getRepository('PlayListBundle:Tracks');
        $query = $em->createQueryBuilder('t')
            ->join('t.artist', 'a')  
            ->join('t.genre', 'g') 
            ->where("$artistWhere and $genreWhere and $yearWhere")      
            ->orderBy($sort, $direction)    
            ->setMaxResults($limit) 
            ->setFirstResult($offset)  
            ->getQuery();
        
        $paginator = new Paginator($query);
        $total = count($paginator);
        $tracksObj=$query->getResult();
                
        foreach ($tracksObj as $track) {
            $tracks[] = array(
                'id' => $track->id
                ,'artist' => $track->artist->title
                ,'track' => $track->title
                ,'genre' => $track->genre->name
                ,'year' => $track->year    
            );
        }
        $data = array('total' => $total, 'data' => $tracks);      
        
        $response = new Response();
        $response->setContent(json_encode($data));
        $response->headers->set('Content-Type', 'application/json');
        return $response; 
    }
}
