<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;

class ControllerBase extends Controller
{
    protected $auth=false;
    protected $controller=false;
    
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        $this->myassets->assetsBase();
        $this->auth=$this->session->get('auth');
        $this->auth->module_id=1;
        $this->controller=$dispatcher->getControllerName();
        //$this->auth->module=null;        
    }
    
    public function afterExecuteRoute(Dispatcher $dispatcher)
    {
        // $modul=$dispatcher->getControllerName();
        $acces=$dispatcher->getActionName();
        //$this->logger->info($this->router->getRewriteUri());
        $data['auth']=$this->auth;
        // if(!$this->request->isAjax() && !$this->request->isPost())
        if(!$this->request->isAjax())
        {
            // $menu=$this->get_row_menu($modul,$acces);
            // $dtMenu=$menu;
            // if($menu->menu_parent_id != 0)
            // {
            //     $dtMenu=$this->get_row_parent($menu->menu_parent_id);
            // }
            // $data['row_menu']=$menu;
            // $data['row_module']=$this->get_row_module($menu->module_id);
            // $data['list_parent_menu']=$this->get_list_parent_menu();
            // $data['list_sub_menu']=$this->get_list_sub_menu($menu->menu_id);
            // $data['get_menu_by_module']=$this->list_menu_by_modul();
            // $data['aside_menu']=$this->listMenuByModule();
            $data['sidebar_menu']=$this->sidebarMenu();
            $data['sidebar_menu_scs']=$this->sidebarMenuScs();
            $data['access']=$this->get_row_access($dispatcher->getControllerName(),$dispatcher->getActionName());
            // $data['aside_menu_html']=$this->menuGeneratorTree();
            
            $this->view->setVar("page",(object)$data);
        }
    }
    
    private function get_menu_by_module()
    {
        $data=$this->modelsManager->createBuilder()
            ->from("MMenu")
            ->columns("MMenu.menu_id,MMenu.menu_parent_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.description,MMenu.icon")
            ->join("MAccessList","MAccessList.resources_name=MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
            ->where("MMenu.show_menu='Y' AND MAccessList.allowed=1 AND MAccessList.roles='".$this->auth->roles."' AND MMenu.module_id=".$this->auth->module_id)
            ->orderBy("MMenu.menu_order ASC")
            ->getQuery()
            ->execute();
        return $data->toArray();
    }

    private function get_row_access($resources,$access)
    {
        $data=MAccess::findFirst([
            "resources_name=:resources: AND access_name=:access:",
            "bind"=>[
                "resources"=>$resources,
                "access"=>$access
            ]
        ]);
        return $data;
    }
    
    private function sidebarMenu( $root_id = 0 )
    {
        $html  = '';
        $items = $this->get_menu_by_module();

        foreach ( $items as $item ) $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul id="side-menu">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul></div>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    // $option['value']['show_menu'],
                    'Y',
                    $option['value']['description'],
                    $option['value']['icon']
                );
                $html .= $tab . "\t" . '
                <li>
                <a href="#sidebar_'.$option['value']['menu_id'].'" data-bs-toggle="collapse">
                    <i class="'.$option['value']['icon'].'"></i>
                    <span>'.$option['value']['menu_title'].'</span>
                    <span class="menu-arrow"></span>
                    </a>
                    <div class="collapse" id="sidebar_'.$option['value']['menu_id'].'">
                        <ul class="nav-second-level">
                            ';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")
                    $html .= sprintf(
                        '%1$s<li>
                            <a href="/%4$s/%5$s" title="%3$s">
                            <i class="%9$s"></i>
                            <span>%3$s</span>
                            </a>
                        </li>',
                        str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                        $option['value']['menu_id'],
                        $option['value']['menu_title'],
                        $option['value']['resources_name'],
                        $option['value']['access_name'],
                        $option['value']['menu_parent_id'],
                        'Y',
                        $option['value']['description'],
                        $option['value']['icon']
                    );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }

    private function sidebarMenuScs( $root_id = 0 )
    {
        $html  = '';
        $items = $this->get_menu_by_module();

        foreach ( $items as $item ) $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul id="side-menu">       ';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ($option === false) {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul></div>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif (!empty( $children[$option['value']['menu_id']])) {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    // $option['value']['show_menu'],
                    'Y',
                    $option['value']['description'],
                    $option['value']['icon']
                );
                $html .= $tab . "\t" . '
                <li>
                    <a href="#sidebarMenu-'.$option['value']['menu_id'].'" data-bs-toggle="collapse">
                        <i data-feather="'.$option['value']['icon'].'"></i>
                        <span>'.$option['value']['menu_title'].'</span>
                        <span class="menu-arrow"></span>
                    </a>
                    <div class="collapse" id="sidebarMenu-'.$option['value']['menu_id'].'">
                        <ul class="nav-second-level">
                            ';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
            {
                // HTML for menu item with no children (aka "leaf")
                if ($option['value']['icon'] == 'arrow-right') {
                    $html .= sprintf(
                        '%1$s<li>
                            <a href="/%4$s/%5$s" title="%3$s">
                            <span>%3$s</span>
                            </a>
                        </li>',
                        str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                        $option['value']['menu_id'],
                        $option['value']['menu_title'],
                        $option['value']['resources_name'],
                        $option['value']['access_name'],
                        $option['value']['menu_parent_id'],
                        'Y',
                        $option['value']['description'],
                        $option['value']['icon']
                    );
                } 
                else {
                    $html .= sprintf(
                        '%1$s<li>
                            <a href="/%4$s/%5$s" title="%3$s">
                            <i data-feather="%9$s"></i>
                            <span>%3$s</span>
                            </a>
                        </li>',
                        str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                        $option['value']['menu_id'],
                        $option['value']['menu_title'],
                        $option['value']['resources_name'],
                        $option['value']['access_name'],
                        $option['value']['menu_parent_id'],
                        'Y',
                        $option['value']['description'],
                        $option['value']['icon']
                    );
                }
            }
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    // show login page
    protected function showLogin()
    {
        $this->dispatcher->forward(
            [
                "controller" => "auth",
                "action"     => "index",
            ]
        );
    }
    // show 404 page not found
    protected function show404()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show404",
            ]
        );
    }
    
    // show page forbidden access
    protected function show403()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show403",
            ]
        );
    }
    
    // show page forbidden access
    protected function show503()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show503",
            ]
        );
    }
    
    protected function nocontent($msg='')
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "nocontent"
            ]
        );
    }
}
