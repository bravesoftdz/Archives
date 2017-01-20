<?php

namespace ParseItAll\ParseItAllBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobMessages
 */
class JobMessages
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\Links
     */
    private $link;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\JobNodes
     */
    private $jobNode;


    /**
     * Get id
     *
     * @return integer 
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set link
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\Links $link
     * @return JobMessages
     */
    public function setLink(\ParseItAll\ParseItAllBundle\Entity\Links $link = null)
    {
        $this->link = $link;

        return $this;
    }

    /**
     * Get link
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\Links 
     */
    public function getLink()
    {
        return $this->link;
    }

    /**
     * Set jobNode
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\JobNodes $jobNode
     * @return JobMessages
     */
    public function setJobNode(\ParseItAll\ParseItAllBundle\Entity\JobNodes $jobNode = null)
    {
        $this->jobNode = $jobNode;

        return $this;
    }

    /**
     * Get jobNode
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\JobNodes 
     */
    public function getJobNode()
    {
        return $this->jobNode;
    }
}
