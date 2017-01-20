<?php

namespace ParseItAll\ParseItAllBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobRegexp
 */
class JobRegexp
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $regexp;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\JobRules
     */
    private $jobRule;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\JobRegexpTypeRef
     */
    private $typeRefid;


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
     * Set regexp
     *
     * @param string $regexp
     * @return JobRegexp
     */
    public function setRegexp($regexp)
    {
        $this->regexp = $regexp;

        return $this;
    }

    /**
     * Get regexp
     *
     * @return string 
     */
    public function getRegexp()
    {
        return $this->regexp;
    }

    /**
     * Set jobRule
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\JobRules $jobRule
     * @return JobRegexp
     */
    public function setJobRule(\ParseItAll\ParseItAllBundle\Entity\JobRules $jobRule = null)
    {
        $this->jobRule = $jobRule;

        return $this;
    }

    /**
     * Get jobRule
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\JobRules 
     */
    public function getJobRule()
    {
        return $this->jobRule;
    }

    /**
     * Set typeRefid
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\JobRegexpTypeRef $typeRefid
     * @return JobRegexp
     */
    public function setTypeRefid(\ParseItAll\ParseItAllBundle\Entity\JobRegexpTypeRef $typeRefid = null)
    {
        $this->typeRefid = $typeRefid;

        return $this;
    }

    /**
     * Get typeRefid
     *
     * @return \ParseItAll\ParseItAllBundle\Entity\JobRegexpTypeRef 
     */
    public function getTypeRefid()
    {
        return $this->typeRefid;
    }
}
