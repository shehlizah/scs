<?php
use Phalcon\Mvc\User\Component;
class MyException extends Component
{
    /**
     * Error code :
     * 
     * 00 :  logic
     * 404 : page not found
     * 1049 : database
     */
    private $message='';
    
    public function __construct($message =null, $code = 00)
    {
        $this->logger->error($this->message);
        $this->message = $message;
        $this->ars->code=$code;
        $this->ars->message=$message;
        $this->ars->send();
    }
}