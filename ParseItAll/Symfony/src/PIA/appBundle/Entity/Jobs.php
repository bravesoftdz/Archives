<?php

namespace PIA\appBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Jobs
 */
class Jobs {

    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $caption;

    /**
     * @var string
     */
    private $zeroLink;

    /**
     * @var \Doctrine\Common\Collections\Collection
     */
    private $levels;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->levels = new \Doctrine\Common\Collections\ArrayCollection();
    }

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
     * Set caption
     *
     * @param string $caption
     * @return Jobs
     */
    public function setCaption($caption)
    {
        $this->caption = $caption;

        return $this;
    }

    /**
     * Get caption
     *
     * @return string 
     */
    public function getCaption()
    {
        return $this->caption;
    }

    /**
     * Set zeroLink
     *
     * @param string $zeroLink
     * @return Jobs
     */
    public function setZeroLink($zeroLink)
    {
        $this->zeroLink = $zeroLink;

        return $this;
    }

    /**
     * Get zeroLink
     *
     * @return string 
     */
    public function getZeroLink()
    {
        return $this->zeroLink;
    }

    /**
     * Add levels
     *
     * @param \PIA\appBundle\Entity\JobLevels $levels
     * @return Jobs
     */
    public function addLevel(\PIA\appBundle\Entity\JobLevels $levels)
    {
        $this->levels[] = $levels;

        return $this;
    }

    /**
     * Remove levels
     *
     * @param \PIA\appBundle\Entity\JobLevels $levels
     */
    public function removeLevel(\PIA\appBundle\Entity\JobLevels $levels)
    {
        $this->levels->removeElement($levels);
    }

    /**
     * Get levels
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getLevels()
    {
        return $this->levels;
    }
}
