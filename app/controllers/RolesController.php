<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class RolesController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if(method_exists(__CLASS__,$param)) {
                $this->{$param}();
            }
            else {
                throw new Exception("method tidak tersedia");
            }
        }
    }

    private function all_data()
	{ 
		$builder = $this->modelsManager->createBuilder()  
			->columns('
				 roles
				,name
				,description
			') 
			->from('MRoles'); 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

    private function getListRoles($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT roles AS get_value FROM m_roles ORDER BY roles ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['get_value']]=$val['get_value'];
        }
        
        $select = new Select("roles",$result,["useEmpty"  =>  false,]);
        if($def_val != null){
            $select->setDefault($def_val);
        }

        return $form->add($select);
    }

	private function save()
	{
		if($this->request->isAjax()):
			$check=MRoles::findFirstByRoles($this->request->getPost('roles'));

			if($check) {
				$this->apiOut['status'] = (int) 0;
				$this->apiOut['error'] = true;
				$this->apiOut['message'] = 'Group '.$this->request->getPost('roles').' sudah ada.';
			}
			else {
                $new=new MRoles();
                $new->roles=$this->request->getPost('roles');
                $new->name=$this->request->getPost('name');
                $new->description=$this->request->getPost('description');
                if($new->save()) {
                    $new_access=new MAccessList();
                        $new_access->roles=$new->roles;
                        $new_access->resources_name='dashboard';
                        $new_access->access_name='index';
                        $new_access->allowed=1;
                    $new_access->save();

                    $new_access=new MAccessList();
                        $new_access->roles=$new->roles;
                        $new_access->resources_name='ubahpassword';
                        $new_access->access_name='index';
                        $new_access->allowed=1;
                    $new_access->save();
                }

				$this->apiOut['status'] = (int) 1;
				$this->apiOut['error'] = false;
				$this->apiOut['message'] = 'Group '.$this->request->getPost('roles').' berhasil disimpan';
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}
	
    private function do_access_list()
	{
		if($this->request->isAjax()) {
            $controller_method=explode("_",$this->request->get('controller_method'));
			$check=MAccessList::findFirst(
                [
                    "roles=:roles: AND resources_name=:resources_name: AND access_name=:access_name:",
                    "bind"=>
                        [
                            "roles"=>$this->request->get('role'),
                            "resources_name"=>$controller_method[0],
                            "access_name"=>$controller_method[1],
                        ]
                ]
            );

			if($check) {
                $check->allowed=0;
                if($this->request->get('allowed') == 'true') {
                    $check->allowed=1;
                }
                $check->update();
			}
			else {
                $new_access=new MAccessList();
                $new_access->roles=$this->request->get('role');
                $new_access->resources_name=$controller_method[0];
                $new_access->access_name=$controller_method[1];
                $new_access->allowed=0;
                if($this->request->get('allowed') == 'true') {
                    $new_access->allowed=1;
                }
                $new_access->save();
            }

            $this->apiOut['status'] = (int) 1;
            $this->apiOut['error'] = false;
            $this->apiOut['message'] = 'Role: '.$this->request->get('role').', Controller: '.$controller_method[0].', Method: '.$controller_method[1].', Allowed: '.$this->request->get('allowed');

			$this->apiOut['get'] = $this->request->get();
			$this->apiOut['post'] = $this->request->getPost();

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		}
	}

    private function update()
	{
		if($this->request->isAjax()):
			$menu=MMenu::findFirstByMenuId($this->request->getPost('menu_id'));

			if($menu) {
				$menu->resources_name=$this->request->getPost('resources_name');
                $menu->menu_title=$this->request->getPost('menu_title');
                $menu->description=$this->request->getPost('description');
                $menu->icon=$this->request->getPost('icon');

                if($menu->update()) {
                    $this->apiOut['status'] = (int) 1;
                    $this->apiOut['error'] = false;
                    $this->apiOut['message'] = 'Menu '.$this->request->getPost('menu_title').' berhasil disimpan';
                }
                else {
                    $this->apiOut['status'] = (int) 0;
                    $this->apiOut['error'] = true;
                    $this->apiOut['message'] = 'Menu '.$this->request->getPost('menu_title').' gagal disimpan';
                }
			}
			else {
                $this->apiOut['status'] = (int) 0;
                $this->apiOut['error'] = true;
                $this->apiOut['message'] = 'Menu tidak ada';
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}

    private function delete()
	{
		if($this->request->isAjax()) {
			$role=MRoles::findFirstByRoles($this->request->get('uid'));
            $old=$role;
			if($role) {
                if($role->delete()) {
                    $accessList=MAccessList::find(
                        [
                            "roles = :roles:",
                            "bind"=>
                                [
                                    "roles"=>$old->roles,
                                ]
                        ]
                    );
                    $accessList->delete();

                    $this->apiOut['status'] = (int) 1;
                    $this->apiOut['error'] = false;
                    $this->apiOut['message'] = 'Group '.$old->roles.' berhasil dihapus';
                } 
                else {
                    $this->apiOut['status'] = (int) 0;
                    $this->apiOut['error'] = true;
                    $this->apiOut['message'] = 'Group '.$old->roles.' gagal dihapus';
                }
			}
			else {
                $this->apiOut['status'] = (int) 0;
                $this->apiOut['error'] = true;
                $this->apiOut['message'] = 'Group tidak ada';
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		}
	}

    public function winaddAction()
	{
		$this->view->setVar("data",(object)$data);
	}

	public function wineditAction($id)
	{
		$row=MMenu::findFirstByMenuId($id);
		$data['row']=$row;
		$data['status_active']='';
		$data['status_not_active']='checked';

		if($row->status == 1) {
			$data['status_active']='checked';
			$data['status_not_active']='';
		}

		$this->view->setVar("data",(object)$data);
	}

    public function accessAction($role) 
    {
        $data['list_roles']=$this->getListRoles($role)->render(
			'roles',
			[
				'class'=>'form-select',
				'required'=>'required',
				'id'=>'list_roles',
			]
		);

        $access=MAccess::find(
            [
                "order" => "resources_name ASC, access_name ASC"
            ]
        );
        $data['access']=$access;

        $roleAccess=MAccessList::find(
            [
                "roles = :roles:",
                "bind"=>
                    [
                        "roles"=>$role
                    ]
            ]
        );

        $list_role_access=[];
        $list_role_access_allowed=[];
        foreach($roleAccess as $row) {
            $list_role_access[]=$row->resources_name.'_'.$row->access_name;
            $list_role_access_allowed[$row->resources_name.'_'.$row->access_name]=$row->allowed;
        }

        $data['role']=$role;
        $data['role_access']=$roleAccess;
        $data['list_role_access']=$list_role_access;
        $data['list_role_access_allowed']=$list_role_access_allowed;

        $this->view->setVar("data",(object)$data);
    }
}
