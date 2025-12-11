<?php

class Generate extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $gen_no;

    /**
     *
     * @var string
     */
    public $table_name;

    /**
     *
     * @var integer
     */
    public $month;

    /**
     *
     * @var integer
     */
    public $year;

    /**
     *
     * @var string
     */
    public $gen_format;

    /**
     *
     * @var string
     */
    public $divisi;

    /**
     *
     * @var string
     */
    public $gEN_TYPE;

    /**
     *
     * @var string
     */
    public $mAUTO;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        // $this->setSchema("db_skck");
        $this->setSource("generate");
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return Generate[]|Generate|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return Generate|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
