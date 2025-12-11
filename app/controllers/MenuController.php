<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MenuController extends ControllerBase
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
				 menu_id
				,resources_name
				,access_name
				,menu_title
				,menu_parent_id
				,menu_order
				,description
				,status
				,show_menu
				,icon
				,module_id
			') 
			->from('MMenu'); 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function simpan_menu()
	{
		if($this->request->isAjax()):
			$check_menu=MMenu::findFirst([
                "menu_title=:menu_title:",
                "bind"=>[
                    "menu_title"=>$this->request->getPost('menu_title')
                ]
            ]);

			if($check_menu) {
				$this->apiOut['status'] = (int) 0;
				$this->apiOut['error'] = true;
				$this->apiOut['message'] = 'Menu '.$this->request->getPost('menu_title').' sudah ada.';
			}
			else {
                $urutan=$this->db->fetchOne("SELECT MAX(menu_order) AS urutan FROM m_menu WHERE menu_parent_id=0", \Phalcon\Db::FETCH_ASSOC)['urutan'];

				$menu=new MMenu();
                $menu->resources_name=$this->request->getPost('resources_name');
                $menu->access_name='index';
                $menu->menu_title=$this->request->getPost('menu_title');
                $menu->menu_parent_id=0;
                $menu->menu_order=$urutan + 1;
                $menu->description=$this->request->getPost('description');
                $menu->status=0;
                $menu->show_menu='Y';
                $menu->icon=$this->request->getPost('icon');
                $menu->module_id=1;
                if($menu->save()) {
                    $this->db->query("DELETE FROM m_access_list WHERE roles='developer' AND resources_name='$menu->resources_name' AND access_name='index'");

                    $new_access=new MAccessList();
                        $new_access->roles='developer';
                        $new_access->resources_name=$menu->resources_name;
                        $new_access->access_name=$menu->access_name;
                        $new_access->allowed=1;
                    $new_access->save();
                }

				$this->apiOut['status'] = (int) 1;
				$this->apiOut['error'] = false;
				$this->apiOut['message'] = 'Menu '.$this->request->getPost('menu_title').' berhasil disimpan';
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}

    private function update_menu()
	{
		if($this->request->isAjax()):
			$menu=MMenu::findFirstByMenuId($this->request->getPost('menu_id'));

			if($menu) {
				$menu->resources_name=$this->request->getPost('resources_name');
				$menu->access_name=$this->request->getPost('access_name');
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

    private function delete_menu()
	{
		if($this->request->isAjax()):
			$menu=MMenu::findFirstByMenuId($this->request->get('menu_id'));
            $old=$menu;
			if($menu) {

                $check_parent=$this->db->fetchOne("SELECT COUNT(1) AS total FROM m_menu WHERE menu_parent_id=$menu->menu_id")['total'];

                if($check_parent == 0) {
                    if($menu->delete()) {
                        $accessList=MAccessList::find(
                            [
                                "resources_name = :resources_name: AND access_name = :access_name:",
                                "bind"=>
                                    [
                                        "resources_name"=>$old->resources_name,
                                        "access_name"=>$old->access_name,
                                    ]
                            ]
                        );
                        $accessList->delete();

                        $this->apiOut['status'] = (int) 1;
                        $this->apiOut['error'] = false;
                        $this->apiOut['message'] = 'Menu '.$old->menu_title.' berhasil dihapus';
                    } 
                    else {
                        $this->apiOut['status'] = (int) 0;
                        $this->apiOut['error'] = true;
                        $this->apiOut['message'] = 'Menu '.$old->menu_title.' gagal dihapus';
                    }
                } 
                else {
                    $this->apiOut['status'] = (int) 0;
                    $this->apiOut['error'] = true;
                    $this->apiOut['message'] = 'Menu '.$menu->menu_title.' merupaken parent, jadi tidak bisa dihapus.';
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
}
