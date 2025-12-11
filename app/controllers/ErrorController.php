<?php
use Phalcon\Mvc\Controller;

class ErrorController extends Controller
{
    private function assetError()
    {
       
    }
    public function errorLoginAction()
    {
        $this->view->disable();
        $this->ars->code=403;
        $this->ars->message="Anda sudah logout, harap login kembali";
        $this->ars->send();
    }
    public function error404Action()
    {
        $this->assetError();
        $this->view->setVar("title","404 - page not found");
    }
    
    public function error403Action()
    {
        $this->assetError();
        $this->view->setVar("title","403 - forbidden access");
    }
    
    public function error503Action()
    {
        $this->assetError();
        $this->view->setVar("title","503 - server error");
    }
    
    public function error000Action()
    {
        $this->view->setVar("title","001 - Out of schedule");
    }
    
    public function ajax404Action()
    {
        $this->view->disable();
        $this->ars->code=404;
        $this->ars->message="Laman tidak tersedia";
        $this->ars->send();
    }
    
    public function ajax403Action()
    {
        $this->view->disable();
        $this->ars->code=403;
        $this->ars->message="Maaf anda tidak punya akses untuk menu ini";
        $this->ars->send();
    }
    
    public function ajax000Action()
    {
        $this->view->disable();
        $this->ars->code=000;
        $this->ars->message="Maaf menu ini diluar schedule";
        $this->ars->send();
    }
}