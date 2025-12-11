<?php
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

class StartController extends Controller
{
    protected $auth=false;
    
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        $this->auth=$this->session->get('auth');
        //$this->auth->module=null;
        //$this->auth->module_id=null;
        $this->myassets->assetsBase();
    }
    public function afterExecuteRoute(Dispatcher $dispatcher)
    {
        
    }
    
    public function indexAction()
    {
        $this->dispatcher->forward(
            [
                "controller" => "auth",
                "action"     => "login",
            ]
        );
    }
    
    private function get_list_modul()
    {
        $data=$this->modelsManager->createBuilder()
            ->from("MModules")
            ->columns("MModules.id,MModules.name,MModules.description,MModules.icon,MModules.color,MModulesAccess.module_id,MModulesAccess.allowed")
            ->join("MModulesAccess","MModulesAccess.module_id=MModules.id")
            ->where("MModulesAccess.roles='".$this->auth->roles."' AND MModules.status='1'")
			->orderBy("MModules.module_order ASC")
            //->groupBy("MAccessList.resources_name,MAccessList.roles")
            ->getQuery()
            ->execute();
            
        return $data;
    }
    
    public function checkoutAction()
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            
            // $modul_id=1;
            $modul_id=$this->request->getPost('pk');
            $name=$this->request->getPost('modul_name');
            
            $menu=$this->modelsManager->createBuilder()
                ->from("MMenu")
                ->columns("MMenu.menu_id,MMenu.menu_parent_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.description,MMenu.icon")
                ->join("MAccessList","MAccessList.resources_name=MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
                ->where("MMenu.show_menu='Y' AND MAccessList.allowed=1 AND MAccessList.roles='".$this->auth->roles."' AND MMenu.module_id='".$modul_id."'")
                ->orderBy("MMenu.menu_order ASC")
                ->getQuery()
                ->getSingleResult();
            if($menu)
            {
                $this->auth->module=$name;
                $this->auth->module_id=$modul_id;
                $this->ars->success=true;
                $this->ars->data=$menu->resources_name;
            }
            else
            {
                $this->ars->success=false;
                $this->ars->message='Menu tidak tersedia';
            }
            
            $this->ars->send();
        }
    }
}