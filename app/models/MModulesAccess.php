<?php

class MModulesAccess extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(column="roles", type="string", length=255, nullable=false)
     */
    public $roles;

    /**
     *
     * @var integer
     * @Primary
     * @Column(column="module_id", type="integer", length=11, nullable=false)
     */
    public $module_id;
    public $allowed;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        //$this->setSchema("bp_admin");
        $this->setSource("m_modules_access");
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MModulesAccess[]|MModulesAccess|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MModulesAccess|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
