<?php

namespace ParseItAll\ParseItAllBundle\Entity;

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
     * @var \ParseItAll\ParseItAllBundle\Entity\Jobs
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
     * @param \ParseItAll\ParseItAllBundle\Entity\Jobs $job
     * @return JobLevels
     */
    public function setJob(\ParseItAll\ParseItAllBundle\Entity\Jobs $job = null)
    {
        $this->job = $job;

        return $this;
    }

    /**
     * Get job
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\Jobs 
     */
    public function getJob()
    {
        return $this->job;
    }
}
