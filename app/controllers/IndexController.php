<?php

class IndexController extends ControllerBase
{

    public function onConstruct()
    {
        $controller='auth';
        
        if($this->session->has('auth'))
        {
            $controller='dashboard';
            
        }
        $this->dispatcher->forward(
            [
                "controller" => $controller,
                "action"     => "index",
            ]
        );
    }
    
    public function logoutAction()
    {
        $this->view->disable();
        $this->session->destroy();
        $this->response->redirect('/');
    }
}