<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class AccessrolesController extends ControllerBase
{
    protected $apiOut;

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
    }

    private function all_data()
	{ 
		$builder = $this->modelsManager->createBuilder()  
			->columns('
                 resources_name
				,access_name
				,access_title
				,created_at
				,created_by
			') 
			->from('MAccess'); 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function simpan()
	{
		if($this->request->isAjax()) {
            $new=new MAccess();
            $new->resources_name=$this->request->getPost('resources_name');
            $new->access_name=$this->request->getPost('access_name');
            $new->access_title=$this->request->getPost('access_title');
            $new->created_at=date('Y-m-d H:i:s');
            $new->created_by=$this->session->get('auth')->username;
            if($new->save()) {
                $this->db->query("DELETE FROM m_access_list WHERE roles='developer' AND resources_name='$new->resources_name' AND access_name='$new->access_name'");

                $new_access=new MAccessList();
                    $new_access->roles='developer';
                    $new_access->resources_name=$new->resources_name;
                    $new_access->access_name=$new->access_name;
                    $new_access->allowed=1;
                $new_access->save();
            }

            $this->apiOut['status'] = (int) 1;
            $this->apiOut['error'] = false;
            $this->apiOut['message'] = "Access Controller $new->resources_name Method $new->access_name berhasil disimpan";

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		}
	}

    private function update()
	{
		if($this->request->isAjax()):
            $data=MAccess::findFirst(
                [
                    "resources_name = :resources_name: AND access_name = :access_name:",
                    "bind"=>
                        [
                            "resources_name"=>$this->request->getPost('resources_name'),
                            "access_name"=>$this->request->getPost('access_name'),
                        ]
                ]            
            );

			if($data) {
				$data->access_title=$this->request->getPost('access_title');
                $data->updated_at=date('Y-m-d H:i:s');
                $data->updated_by=$this->session->get('auth')->username;

                if($data->update()) {
                    $this->apiOut['status'] = (int) 1;
                    $this->apiOut['error'] = false;
                    $this->apiOut['message'] = 'Controller '.$this->request->getPost('resources_name').' Method '.$this->request->getPost('access_name').' berhasil disimpan';
                }
                else {
                    $this->apiOut['status'] = (int) 0;
                    $this->apiOut['error'] = true;
                    $this->apiOut['message'] = 'Controller '.$this->request->getPost('resources_name').' Method '.$this->request->getPost('access_name').' gagal disimpan';
                }
			}
			else {
                $this->apiOut['status'] = (int) 0;
                $this->apiOut['error'] = true;
                $this->apiOut['message'] = 'Controller dan Method tidak ada';
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
		if($this->request->isAjax()):
			$menu=MAccess::findFirst(
                [
                    "resources_name = :resources_name: AND access_name = :access_name:",
                    "bind"=>
                        [
                            "resources_name"=>$this->request->get('controller'),
                            "access_name"=>$this->request->get('method'),
                        ]
                ]);
            $old=$menu;
			if($menu) {
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
                    $this->apiOut['message'] = 'Controller '.$old->resources_name.' Method '.$old->access_name.' berhasil dihapus';
                } 
                else {
                    $this->apiOut['status'] = (int) 0;
                    $this->apiOut['error'] = true;
                    $this->apiOut['message'] = 'Controller '.$old->resources_name.' Method '.$old->access_name.' gagal dihapus';
                }
			}
			else {
                $this->apiOut['status'] = (int) 0;
                $this->apiOut['error'] = true;
                $this->apiOut['message'] = 'Controller Method tidak ada';
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

	public function wineditAction($controller,$method)
	{
		$row=MAccess::findFirst(
            [
                "resources_name = :resources_name: AND access_name = :access_name:",
                "bind"=>
                    [
                        "resources_name"=>$controller,
                        "access_name"=>$method,
                    ]
            ]            
        );
		$data['row']=$row;

		$this->view->setVar("data",(object)$data);
	}
}
