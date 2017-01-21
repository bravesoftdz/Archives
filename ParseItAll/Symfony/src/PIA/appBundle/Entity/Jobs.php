<?php

namespace PIA\appBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Jobs
 */
class Jobs
{
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
}
