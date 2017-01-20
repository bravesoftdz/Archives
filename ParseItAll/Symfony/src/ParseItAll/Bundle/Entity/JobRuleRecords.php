<?php

namespace ParseItAll\ParseItAllBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * JobRuleRecords
 */
class JobRuleRecords
{
    /**
     * @var integer
     */
    private $id;

    /**
     * @var string
     */
    private $key;

    /**
     * @var boolean
     */
    private $typeRefid;

    /**
     * @var \ParseItAll\ParseItAllBundle\Entity\JobRules
     */
    private $jobRule;


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
     * Set key
     *
     * @param string $key
     * @return JobRuleRecords
     */
    public function setKey($key)
    {
        $this->key = $key;

        return $this;
    }

    /**
     * Get key
     *
     * @return string 
     */
    public function getKey()
    {
        return $this->key;
    }

    /**
     * Set typeRefid
     *
     * @param boolean $typeRefid
     * @return JobRuleRecords
     */
    public function setTypeRefid($typeRefid)
    {
        $this->typeRefid = $typeRefid;

        return $this;
    }

    /**
     * Get typeRefid
     *
     * @return boolean 
     */
    public function getTypeRefid()
    {
        return $this->typeRefid;
    }

    /**
     * Set jobRule
     *
     * @param \ParseItAll\ParseItAllBundle\Entity\JobRules $jobRule
     * @return JobRuleRecords
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
}
