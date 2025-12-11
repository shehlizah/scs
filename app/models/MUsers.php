<?php

use Phalcon\Validation;
use Phalcon\Validation\Validator\Email as EmailValidator;

class MUsers extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(column="username", type="string", length=50, nullable=false)
     */
    public $username;

    /**
     *
     * @var string
     * @Column(column="email", type="string", length=50, nullable=true)
     */
    public $email;

    /**
     *
     * @var string
     * @Column(column="password", type="string", length=150, nullable=true)
     */
    public $password;

    /**
     *
     * @var string
     * @Column(column="roles", type="string", length=50, nullable=true)
     */
    public $roles;

    /**
     *
     * @var string
     * @Column(column="create_at", type="string", nullable=true)
     */
    public $create_at;

    /**
     *
     * @var string
     * @Column(column="last_login", type="string", nullable=true)
     */
    public $last_login;

    /**
     *
     * @var integer
     * @Column(column="status", type="integer", length=4, nullable=true)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(column="fullname", type="string", length=100, nullable=true)
     */
    public $fullname;

    /**
     * Validations and business logic
     *
     * @return boolean
     */
    /*
    public function validation()
    {
        $validator = new Validation();

        $validator->add(
            'email',
            new EmailValidator(
                [
                    'model'   => $this,
                    'message' => 'Please enter a correct email address',
                ]
            )
        );

        return $this->validate($validator);
    }
    */

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        //$this->setSchema("bp_admin");
        $this->setSource("m_users");
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MUsers[]|MUsers|\Phalcon\Mvc\Model\ResultSetInterface
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MUsers|\Phalcon\Mvc\Model\ResultInterface
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
