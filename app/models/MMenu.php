<?php

class MMenu extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(column="menu_id", type="integer", length=11, nullable=false)
     */
    public $menu_id;

    /**
     *
     * @var string
     * @Primary
     * @Column(column="resources_name", type="string", length=50, nullable=false)
     */
    public $resources_name;

    /**
     *
     * @var string
     * @Primary
     * @Column(column="access_name", type="string", length=30, nullable=false)
     */
    public $access_name;

    /**
     *
     * @var string
     * @Column(column="menu_title", type="string", length=30, nullable=true)
     */
    public $menu_title;

    /**
     *
     * @var integer
     * @Column(column="menu_parent_id", type="integer", length=11, nullable=true)
     */
    public $menu_parent_id;

    /**
     *
     * @var integer
     * @Column(column="menu_order", type="integer", length=11, nullable=true)
     */
    public $menu_order;

    /**
     *
     * @var string
     * @Column(column="description", type="string", length=255, nullable=true)
     */
    public $description;

    /**
     *
     * @var integer
     * @Column(column="status", type="integer", length=4, nullable=true)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(column="show_menu", type="string", nullable=true)
     */
    public $show_menu;

    /**
     *
     * @var string
     * @Column(column="icon", type="string", length=50, nullable=true)
     */
    public $icon;
    public $module_id;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        //$this->setSchema("bp_admin");
        $this->setSource("m_menu");
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MMenu[]|MMenu|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MMenu|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
