<?php

namespace ParseItAll\Bundle\Controller;

use ParseItAll\ParseItAllBundle\Entity\Jobs;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Component\HttpFoundation\Request;

/**
 * Job controller.
 *
 * @Route("jobs")
 */
class JobsController extends Controller
{
    /**
     * Lists all job entities.
     *
     * @Route("/", name="jobs_index")
     * @Method("GET")
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $jobs = $em->getRepository('ParseItAllBundle:Jobs')->findAll();

        return $this->render('jobs/index.html.twig', array(
            'jobs' => $jobs,
        ));
    }

    /**
     * Creates a new job entity.
     *
     * @Route("/new", name="jobs_new")
     * @Method({"GET", "POST"})
     */
    public function newAction(Request $request)
    {
        $job = new Job();
        $form = $this->createForm('ParseItAll\ParseItAllBundle\Form\JobsType', $job);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($job);
            $em->flush($job);

            return $this->redirectToRoute('jobs_show', array('id' => $job->getId()));
        }

        return $this->render('jobs/new.html.twig', array(
            'job' => $job,
            'form' => $form->createView(),
        ));
    }

    /**
     * Finds and displays a job entity.
     *
     * @Route("/{id}", name="jobs_show")
     * @Method("GET")
     */
    public function showAction(Jobs $job)
    {
        $deleteForm = $this->createDeleteForm($job);

        return $this->render('jobs/show.html.twig', array(
            'job' => $job,
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Displays a form to edit an existing job entity.
     *
     * @Route("/{id}/edit", name="jobs_edit")
     * @Method({"GET", "POST"})
     */
    public function editAction(Request $request, Jobs $job)
    {
        $deleteForm = $this->createDeleteForm($job);
        $editForm = $this->createForm('ParseItAll\ParseItAllBundle\Form\JobsType', $job);
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('jobs_edit', array('id' => $job->getId()));
        }

        return $this->render('jobs/edit.html.twig', array(
            'job' => $job,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Deletes a job entity.
     *
     * @Route("/{id}", name="jobs_delete")
     * @Method("DELETE")
     */
    public function deleteAction(Request $request, Jobs $job)
    {
        $form = $this->createDeleteForm($job);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($job);
            $em->flush($job);
        }

        return $this->redirectToRoute('jobs_index');
    }

    /**
     * Creates a form to delete a job entity.
     *
     * @param Jobs $job The job entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Jobs $job)
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('jobs_delete', array('id' => $job->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
