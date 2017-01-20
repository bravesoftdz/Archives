<?php

namespace ParseItAll\ParseItAllBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobRules
 */
class JobRules
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $description;

    /**
     * @var integer
     */
    private $containerOffset;

    /**
     * @var boolean
     */
    private $criticalType;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\JobGroups
     */
    private $group;


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
     * Set description
     *
     * @param string $description
     * @return JobRules
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string 
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set containerOffset
     *
     * @param integer $containerOffset
     * @return JobRules
     */
    public function setContainerOffset($containerOffset)
    {
        $this->containerOffset = $containerOffset;

        return $this;
    }

    /**
     * Get containerOffset
     *
     * @return integer 
     */
    public function getContainerOffset()
    {
        return $this->containerOffset;
    }

    /**
     * Set criticalType
     *
     * @param boolean $criticalType
     * @return JobRules
     */
    public function setCriticalType($criticalType)
    {
        $this->criticalType = $criticalType;

        return $this;
    }

    /**
     * Get criticalType
     *
     * @return boolean 
     */
    public function getCriticalType()
    {
        return $this->criticalType;
    }

    /**
     * Set group
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\JobGroups $group
     * @return JobRules
     */
    public function setGroup(\ParseItAll\ParseItAllBundle\Entity\JobGroups $group = null)
    {
        $this->group = $group;

        return $this;
    }

    /**
     * Get group
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\JobGroups 
     */
    public function getGroup()
    {
        return $this->group;
    }
}
