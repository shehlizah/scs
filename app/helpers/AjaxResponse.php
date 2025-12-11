<?php
use Phalcon\Mvc\User\Component;
class AjaxResponse extends Component
{
    private $arayResponse;
    public $success=false;
    public $code=00;
    public $message='OK';
    public $data=null;
    
    public function send()
    {
        /*
        $this->response->setContentType("application/json");
        $this->response->setHeader("Access-Control-Allow-Origin", "*");
        $this->response->setHeader("Access-Control-Allow-Credentials", "true");
        $this->response->setRawHeader('HTTP/1.1 200 OK');
        $this->response->sendHeaders();
        */
        
        $this->arayResponse['success']=$this->success;
        
        if($this->success)
        {
            $this->arayResponse['message']  =$this->message;
            $this->arayResponse['data']     =$this->data;
        }
        else
        {
            $this->arayResponse['error']['code']=$this->code;
            $this->arayResponse['error']['message']=$this->message;
        }
        echo json_encode($this->arayResponse);
    }
}