<?php

namespace PIA\appBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobGroups
 */
class JobGroups
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $notes;

    /**
     * @var \PIA\appBundle\Entity\JobLevels
     */
    private $jobLevel;


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
     * Set notes
     *
     * @param string $notes
     * @return JobGroups
     */
    public function setNotes($notes)
    {
        $this->notes = $notes;

        return $this;
    }

    /**
     * Get notes
     *
     * @return string 
     */
    public function getNotes()
    {
        return $this->notes;
    }

    /**
     * Set jobLevel
     *
     * @param \PIA\appBundle\Entity\JobLevels $jobLevel
     * @return JobGroups
     */
    public function setJobLevel(\PIA\appBundle\Entity\JobLevels $jobLevel = null)
    {
        $this->jobLevel = $jobLevel;

        return $this;
    }

    /**
     * Get jobLevel
     *
     * @return \PIA\appBundle\Entity\JobLevels 
     */
    public function getJobLevel()
    {
        return $this->jobLevel;
    }
}
