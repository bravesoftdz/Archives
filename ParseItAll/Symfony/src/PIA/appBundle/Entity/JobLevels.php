<?php

namespace PIA\appBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobLevels
 */
class JobLevels
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var integer
     */
    private $level;

    /**
     * @var \PIA\appBundle\Entity\Jobs
     */
    private $job;


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
     * Set level
     *
     * @param integer $level
     * @return JobLevels
     */
    public function setLevel($level)
    {
        $this->level = $level;

        return $this;
    }

    /**
     * Get level
     *
     * @return integer 
     */
    public function getLevel()
    {
        return $this->level;
    }

    /**
     * Set job
     *
     * @param \PIA\appBundle\Entity\Jobs $job
     * @return JobLevels
     */
    public function setJob(\PIA\appBundle\Entity\Jobs $job = null)
    {
        $this->job = $job;

        return $this;
    }

    /**
     * Get job
     *
     * @return \PIA\appBundle\Entity\Jobs 
     */
    public function getJob()
    {
        return $this->job;
    }
}
