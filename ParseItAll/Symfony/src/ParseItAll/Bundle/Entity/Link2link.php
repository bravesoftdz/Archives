<?php

namespace ParseItAll\ParseItAllBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Link2link
 */
class Link2link
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\Links
     */
    private $masterLink;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\Links
     */
    private $slaveLink;


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
     * Set masterLink
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\Links $masterLink
     * @return Link2link
     */
    public function setMasterLink(\ParseItAll\ParseItAllBundle\Entity\Links $masterLink = null)
    {
        $this->masterLink = $masterLink;

        return $this;
    }

    /**
     * Get masterLink
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\Links 
     */
    public function getMasterLink()
    {
        return $this->masterLink;
    }

    /**
     * Set slaveLink
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\Links $slaveLink
     * @return Link2link
     */
    public function setSlaveLink(\ParseItAll\ParseItAllBundle\Entity\Links $slaveLink = null)
    {
        $this->slaveLink = $slaveLink;

        return $this;
    }

    /**
     * Get slaveLink
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\Links 
     */
    public function getSlaveLink()
    {
        return $this->slaveLink;
    }
}
