<?php

namespace EbayNBundle\Controller;

use EbayNBundle\Entity\Products;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Method;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;use Symfony\Component\HttpFoundation\Request;

/**
 * Product controller.
 *
 * @Route("products")
 */
class ProductsController extends Controller
{
    /**
     * Lists all product entities.
     *
     * @Route("/", name="products_index")
     * @Method("GET")
     */
    public function indexAction()
    {
        $em = $this->getDoctrine()->getManager();

        $products = $em->getRepository('EbayNBundle:Products')->findAll();

        return $this->render('products/index.html.twig', array(
            'products' => $products,
        ));
    }

    /**
     * Creates a new product entity.
     *
     * @Route("/new", name="products_new")
     * @Method({"GET", "POST"})
     */
    public function newAction(Request $request)
    {
        $product = new Products();
        $form = $this->createForm('EbayNBundle\Form\ProductsType', $product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($product);
            $em->flush($product);

            return $this->redirectToRoute('products_show', array('id' => $product->getId()));
        }

        return $this->render('products/new.html.twig', array(
            'product' => $product,
            'form' => $form->createView(),
        ));
    }

    /**
     * Finds and displays a product entity.
     *
     * @Route("/{id}", name="products_show")
     * @Method("GET")
     */
    public function showAction(Products $product)
    {
        $deleteForm = $this->createDeleteForm($product);

        return $this->render('products/show.html.twig', array(
            'product' => $product,
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Displays a form to edit an existing product entity.
     *
     * @Route("/{id}/edit", name="products_edit")
     * @Method({"GET", "POST"})
     */
    public function editAction(Request $request, Products $product)
    {
        $deleteForm = $this->createDeleteForm($product);
        $editForm = $this->createForm('EbayNBundle\Form\ProductsType', $product);
        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('products_edit', array('id' => $product->getId()));
        }

        return $this->render('products/edit.html.twig', array(
            'product' => $product,
            'edit_form' => $editForm->createView(),
            'delete_form' => $deleteForm->createView(),
        ));
    }

    /**
     * Deletes a product entity.
     *
     * @Route("/{id}", name="products_delete")
     * @Method("DELETE")
     */
    public function deleteAction(Request $request, Products $product)
    {
        $form = $this->createDeleteForm($product);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($product);
            $em->flush($product);
        }

        return $this->redirectToRoute('products_index');
    }

    /**
     * Creates a form to delete a product entity.
     *
     * @param Products $product The product entity
     *
     * @return \Symfony\Component\Form\Form The form
     */
    private function createDeleteForm(Products $product)
    {
        return $this->createFormBuilder()
            ->setAction($this->generateUrl('products_delete', array('id' => $product->getId())))
            ->setMethod('DELETE')
            ->getForm()
        ;
    }
}
