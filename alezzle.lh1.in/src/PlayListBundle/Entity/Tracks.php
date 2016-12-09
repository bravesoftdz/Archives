<?php

namespace PlayListBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Tracks
 *
 * @ORM\Table(name="tracks", indexes={@ORM\Index(name="artist_id", columns={"artist_id"}), @ORM\Index(name="genre_id", columns={"genre_id"})})
 * @ORM\Entity
 */
class Tracks
{
    /**
     * @var integer
     *
     * @ORM\Column(name="Id", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="IDENTITY")
     */
    public $id;

    /**
     * @var string
     *
     * @ORM\Column(name="title", type="string", length=255, nullable=false)
     */
    public $title;

    /**
     * @var integer
     *
     * @ORM\Column(name="year", type="smallint", nullable=true)
     */
    public $year;

    /**
     * @var \Artists
     *
     * @ORM\ManyToOne(targetEntity="Artists")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="artist_id", referencedColumnName="Id")
     * })
     */
    public $artist;

    /**
     * @var \Genres
     *
     * @ORM\ManyToOne(targetEntity="Genres")
     * @ORM\JoinColumns({
     *   @ORM\JoinColumn(name="genre_id", referencedColumnName="Id")
     * })
     */
    public $genre;



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
     * Set title
     *
     * @param string $title
     * @return Tracks
     */
    public function setTitle($title)
    {
        $this->title = $title;

        return $this;
    }

    /**
     * Get title
     *
     * @return string 
     */
    public function getTitle()
    {
        return $this->title;
    }

    /**
     * Set year
     *
     * @param integer $year
     * @return Tracks
     */
    public function setYear($year)
    {
        $this->year = $year;

        return $this;
    }

    /**
     * Get year
     *
     * @return integer 
     */
    public function getYear()
    {
        return $this->year;
    }

    /**
     * Set artist
     *
     * @param \PlayListBundle\Entity\Artists $artist
     * @return Tracks
     */
    public function setArtist(\PlayListBundle\Entity\Artists $artist = null)
    {
        $this->artist = $artist;

        return $this;
    }

    /**
     * Get artist
     *
     * @return \PlayListBundle\Entity\Artists 
     */
    public function getArtist()
    {
        return $this->artist;
    }

    /**
     * Set genre
     *
     * @param \PlayListBundle\Entity\Genres $genre
     * @return Tracks
     */
    public function setGenre(\PlayListBundle\Entity\Genres $genre = null)
    {
        $this->genre = $genre;

        return $this;
    }

    /**
     * Get genre
     *
     * @return \PlayListBundle\Entity\Genres 
     */
    public function getGenre()
    {
        return $this->genre;
    }
}
