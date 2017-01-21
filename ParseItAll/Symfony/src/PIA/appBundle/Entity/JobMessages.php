<?php

namespace PIA\appBundle\Entity;

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
     * @var \PIA\appBundle\Entity\Links
     */
    private $link;

    /**
     * @var \PIA\appBundle\Entity\JobNodes
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
     * @param \PIA\appBundle\Entity\Links $link
     * @return JobMessages
     */
    public function setLink(\PIA\appBundle\Entity\Links $link = null)
    {
        $this->link = $link;

        return $this;
    }

    /**
     * Get link
     *
     * @return \PIA\appBundle\Entity\Links 
     */
    public function getLink()
    {
        return $this->link;
    }

    /**
     * Set jobNode
     *
     * @param \PIA\appBundle\Entity\JobNodes $jobNode
     * @return JobMessages
     */
    public function setJobNode(\PIA\appBundle\Entity\JobNodes $jobNode = null)
    {
        $this->jobNode = $jobNode;

        return $this;
    }

    /**
     * Get jobNode
     *
     * @return \PIA\appBundle\Entity\JobNodes 
     */
    public function getJobNode()
    {
        return $this->jobNode;
    }
}
