<?php

class MAccessList extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(column="roles", type="string", length=32, nullable=false)
     */
    public $roles;

    /**
     *
     * @var string
     * @Primary
     * @Column(column="resources_name", type="string", length=32, nullable=false)
     */
    public $resources_name;

    /**
     *
     * @var string
     * @Primary
     * @Column(column="access_name", type="string", length=32, nullable=false)
     */
    public $access_name;

    /**
     *
     * @var integer
     * @Column(column="allowed", type="integer", length=4, nullable=false)
     */
    public $allowed;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        //$this->setSchema("bp_admin");
        $this->setSource("m_access_list");
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'm_access_list';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MAccessList[]|MAccessList|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MAccessList|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
