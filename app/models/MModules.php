<?php

class MModules extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(column="id", type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(column="name", type="string", length=255, nullable=true)
     */
    public $name;

    /**
     *
     * @var string
     * @Column(column="description", type="string", length=255, nullable=true)
     */
    public $description;

    /**
     *
     * @var string
     * @Column(column="icon", type="string", length=255, nullable=true)
     */
    public $icon;

    /**
     *
     * @var integer
     * @Column(column="status", type="integer", length=255, nullable=true)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(column="color", type="string", length=255, nullable=true)
     */
    public $color;
    public $modul_order;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        //$this->setSchema("bp_admin");
        $this->setSource("m_modules");
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MModules[]|MModules|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MModules|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
