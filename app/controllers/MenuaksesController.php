<?php
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MenuaksesController extends ControllerBase
{
    /**
     * laman index menu akses
     */
    public function indexAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if(method_exists(__CLASS__,$param))
            {
                $this->{$param}();
            }
            else
            {
                throw new Exception("method tidak tersedia");
            }
        }
        else
        {
            $this->myassets->treeTable();
            $data['list_roles']=$this->getListRoles()->render('roles',[
                'class'=>'form-select',
                'onchange'=>'load_access(this.value)'
            ]);
            $this->view->setVar("data",(object)$data);
        }
    }
    
    
    public function editAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if($this->request->isAjax())
            {
                $this->view->disable();
                if(method_exists(__CLASS__,$param))
                {
                    $this->{$param}();
                }
                else
                {
                    throw new Exception("method tidak tersedia");
                }
            }
        }
        else
        {
            $this->show404();
        }
    }
    
    /**
     * get list role (dropdown)
     */
    private function getListRoles($def_val=null){
        $form=new Form();
        $result=array();
		if($this->session->get('auth')->roles=='developer')
		{
			$dt=MRoles::find(['order'=>'roles ASC']);
        }else{
			$dt=MRoles::find(["roles NOT IN ('developer')",'order'=>'roles ASC']);
		}
		foreach($dt as $val){
            $result[$val->roles]=$val->roles;
        }
        
        $select = new Select("roles",$result,["useEmpty"  =>  true,"emptyText" =>  "Roles"]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
        return $form->add($select);
    }
    
    /**
     * get list menu by roles
     */
    private function get_list_menu_by_role()
    {
        $roles=$this->request->get('roles');
            
        try{
            $allResource=MMenu::find();
            $dt=[];
            if(count($allResource) > 0)
            {
                foreach($allResource as $r)
                {
                    $accessList=MAccessList::findFirst([
                        "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "roles"=>$roles,
                            "resources"=>$r->resources_name,
                            "access"=>$r->access_name
                        ]
                    ]);
                    
                    if($accessList != true)
                    {
                        
                        $newAccess=new MAccessList();
                        $newAccess->roles=$roles;
                        $newAccess->resources_name=$r->resources_name;
                        $newAccess->access_name=$r->access_name;
                        if($r->resources_name == 'start' || $r->resources_name == 'profile')
                        {
                            $newAccess->allowed=1;
                        }
                        else
                        {
                            $newAccess->allowed=0;
                        }
                        $newAccess->save();
                    }
                }
            }
            /*
            $menuItemX=$this->modelsManager->createBuilder()
                ->from("MMenu")
                ->columns("MMenu.menu_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.menu_parent_id,MMenu.description,MMenu.show_menu,MMenu.menu_order,MAccessList.allowed,MAccessList.roles")
                ->join("MAccessList","MAccessList.resources_name = MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
                ->where("MAccessList.roles='$roles' AND MMenu.show_menu='Y'")
                ->orderBy("MMenu.menu_order ASC")
                ->getQuery()
                ->execute();
            
            */
            //$menu = new MenuGenerate($menuItem);
            $this->ars->success=true;
            $this->ars->data=$this->treeTable($roles);
        }catch(Exception $e)
        {
            $this->ars->message=$e->getMessage();
        }
        $this->ars->send();
    }
    
    private function get_data_menu($roles,$m=false,$r=false)
    {
        $show_menu='';
        $resource='';
        $cari=$this->request->get('cari');
        if($m)
        {
            $show_menu="AND MMenu.show_menu='Y'";
        }
        if($r != false)
        {
            $resource="AND MAccessList.resources_name='$r'";
        }
        if($cari != '')
        {
            $cari="AND MMenu.resources_name LIKE '%$cari%')";
        }
		// AND MMenu.module_id IN (select module_id from m_modules_access where roles='$roles')
        /*
		$menuItem=$this->modelsManager->createBuilder()
                ->from("MMenu")
                ->columns("MMenu.menu_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.menu_parent_id,MMenu.description,MMenu.show_menu,MMenu.menu_order,MAccessList.allowed,MAccessList.roles")
                ->join("MAccessList","MAccessList.resources_name = MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
                ->where("MMenu.resources_name!='start' AND MMenu.resources_name!='profile' AND MAccessList.roles='$roles'  $show_menu $resource $cari")
                ->orderBy("MMenu.menu_order ASC")
                ->getQuery()
                ->execute();
		
		return $menuItem;
		*/
		$menuItem=$this->db->fetchAll("select MMenu.menu_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.menu_parent_id,MMenu.description,MMenu.show_menu,MMenu.menu_order,MAccessList.allowed,MAccessList.roles
										from m_menu MMenu 
										left join m_access_list MAccessList on MAccessList.resources_name = MMenu.resources_name AND MAccessList.access_name=MMenu.access_name
										where MMenu.resources_name!='start' AND MMenu.resources_name!='profile' AND MAccessList.roles='$roles' 
										AND MMenu.module_id IN (select module_id from m_modules_access where roles='$roles' and allowed=1) $show_menu $resource $cari
										order by MMenu.menu_order ASC"); 
        return $menuItem;
    }
    
    private function treeTable($roles)
    {
        $cari=$this->request->get('cari');
        $html  = '';
        $items = $this->get_data_menu($roles,TRUE);
        $checked[0]="";
        $checked[1]="checked";
        $html .= '
            
            <table id="treeGrid" class="table table-hover  table-striped width-full table-bordered ">
            <thead>
                <tr>
                    <th>Menu Title</th>
                    <th>URI</th>
                    <th style="text-align: center;">Can Access?</th>
                </tr>
            </thead>
            <tbody>
        ';
        $aksi='';        
        if(count($items) > 0)
        {
            foreach($items as $v)
            {
                $acccess=$this->get_data_menu($v['roles'],FALSE,$v['resources_name']);
                $r='';
                $acc['index']='-';
                $acc['add']='-';
                $acc['edit']='-';
                $acc['delete']='-';
                $acc['export']='-';
                $acc['print']='-';
                $acc['upload']='-';
                
                if(count($acccess) > 0)
                {
                    foreach($acccess as $a)
                    {
                        $aksi = '<input id="'.$a['resources_name'].$a['menu_id'].'" class="form-check-input '.$a['resources_name'].'" type="checkbox" onchange="checkOne('."'".$a['resources_name']."'".','."'".$a['access_name']."'".','."'".$a['menu_id']."'".')" name="'.$a['resources_name'].'[]" value="'.$a['access_name'].'" '.$checked[$a['allowed']].'/>';
                        $acc[$a['access_name']] =$aksi;
                    }
                }
                if($v['menu_parent_id'] == 0)
                {
                    $p="data-tt-id='parent-".$v['menu_id']."'";
                }
                else
                {
                    $p="data-tt-id='parent-".$v['menu_id']."' data-tt-parent-id='parent-".$v['menu_parent_id']."'";
                }
                $html .='
                        <tr '.$p.'>
                            <td>'.$v['menu_title'].'</td>
                            <td>'.$v['resources_name'].'/'.$v['access_name'].'</td>
                            <td align="center">'.$acc['index'].'</td>
                        </tr>
                    ';
            }
        }
        else
        {
            $html .='<td colspan="8" class="text-center">Data tidak tersedia</td>';
        }
        $html .= '</tbody></table>';
        return $html;
    }
    
    /**
     * set access untuk setiap roles
     */
    private function setAccess()
    {
        $data=[];
        $type=$this->request->getPost('type');
        $roles=$this->request->getPost('roles');
        $resources=$this->request->getPost('resources');
        $access=$this->request->getPost('access');
        $allowed=$this->request->getPost('allowed');
        try
        {
            if($type != "")
            {
                if($type == "one")
                {
                    $setData=MAccessList::findFirst([
                        "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "roles"=>$roles,
                            "resources"=>$resources,
                            "access"=>$access
                        ]
                    ]);
                    $setData->allowed=$allowed;
                    $setData->update();
                }
                else
                {
                    $a=[];
                    if(count($access) > 0)
                    {
                        foreach($access as $v)
                        {
                            $setData=MAccessList::findFirst([
                                "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                                "bind"=>[
                                    "roles"=>$roles,
                                    "resources"=>$resources,
                                    "access"=>$v
                                ]
                            ]);
                            $setData->allowed=$allowed;
                            $setData->update();
                        }
                    }
                }
                $this->ars->success=true;
            }
            else
            {
                $this->ars->message="type tidak diketahui";
            }
            
        }catch(Exception $e)
        {
            $this->ars->code=$e->getCode();
            $this->ars->message=$e->getMessage();
        }
        $this->ars->send();
    }
    
    private function set_full_access()
    {
        $role=$this->request->getPost('role');
        try
        {
            $data=MAccessList::find([
                "roles=:role:",
                "bind"=>[
                    "role"=>$role
                ]
            ]);
            if($data)
            {
                foreach($data as $v)
                {
                    $setData=MAccessList::findFirst([
                        "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "roles"=>$role,
                            "resources"=>$v->resources_name,
                            "access"=>$v->access_name
                        ]
                    ]);
                    $setData->allowed=1;
                    $setData->update();
                }
            }
            //$this->ars->data=$data;
            $this->ars->success=true;
        }catch(Exception $e)
        {
            $this->ars->code=$e->getCode();
            $this->ars->message=$e->getMessage();
        }
        $this->ars->send();
    }
}