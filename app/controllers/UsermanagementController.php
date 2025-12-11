<?php 
use \DataTables\DataTable; 
use Phalcon\Forms\Form; 
use Phalcon\Forms\Element\Select; 

class UsermanagementController extends ControllerBase 
{
	protected $apiOut;

	public function indexAction($param=false)
   	{
		if($this->request->isAjax()):
			$this->view->disable(); 
			if(method_exists(__CLASS__,$param)): 
				$this->{$param}(); 
			else: 
				throw new Exception("Method tidak tersedia"); 
			endif;
		endif;
	}
	
	private function all_data()
	{ 
		$builder = $this->modelsManager->createBuilder()  
			->columns('
				 id
				,username
				,email
				,password
				,roles
				,create_at
				,last_login
				,status
				,fullname
				,no_whatsapp
				,activated_at
				,id_relation
			') 
			->from('MUsers')
			->notInWhere('MUsers.roles',['developer']); 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function simpan_user()
	{
		if($this->request->isAjax()):
			$query="SELECT COUNT(1) AS total FROM m_users WHERE username='".$this->request->getPost('username')."'";
			$checkUsername=$this->db->fetchOne($query, \Phalcon\Db::FETCH_OBJ)->total;

			if($checkUsername > 0) {
				$this->apiOut['status'] = (int) 0;
				$this->apiOut['error'] = true;
				$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' sudah ada di database.';
			}
			else {
				$users=new MUsers();
					$users->username=$this->request->getPost('username');
					$users->fullname=$this->request->getPost('fullname');
					$users->email=$this->request->getPost('email');
					$users->roles=$this->request->getPost('roles');
					$users->status=1;
					$users->no_whatsapp=$this->request->getPost('no_whatsapp');
					$users->create_at=date('Y-m-d h:i:s');
					$users->password=$this->security->hash($this->request->getPost('password'));
				$users->save();

				$this->apiOut['status'] = (int) 1;
				$this->apiOut['error'] = false;
				$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' berhasil disimpan';
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}

	private function update_user()
	{
		if($this->request->isAjax()):
			$old=MUsers::findFirstById($this->request->getPost('user_id'));
			
			if($this->request->getPost('username') == $old->username) {
				$old->fullname=$this->request->getPost('fullname');
				$old->email=$this->request->getPost('email');
				$old->roles=$this->request->getPost('roles');
				$old->status=$this->request->getPost('status');
				$old->no_whatsapp=$this->request->getPost('no_whatsapp');
				if(strlen($this->request->getPost('password')) > 0) {
					$old->password=$this->security->hash($this->request->getPost('password'));
				}
				
				if($old->save()) {
					if($old->roles=='penyuluh') {
						$penyuluh=Penyuluh::findFirstById($old->id_relation);
							$penyuluh->login_username=$this->request->getPost('username');
							if(strlen($this->request->getPost('password')) > 0) {
								$penyuluh->login_password=$this->request->getPost('password');
							}
						$penyuluh->update();
						$this->apiOut['message_extend']="update ke penyuluh, id=$old->id_relation. username jadi : ".$this->request->getPost('username');
					}

					$this->apiOut['status'] = (int) 1;
					$this->apiOut['error'] = false;
					$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' berhasil disimpan';
				} 
				else {
					$this->apiOut['status'] = (int) 0;
					$this->apiOut['error'] = true;
					$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' gagal disimpan';
				}
			}
			else {
				$query="SELECT COUNT(1) AS total FROM m_users WHERE username='".$this->request->getPost('username')."'";
				$checkUsername=$this->db->fetchOne($query, \Phalcon\Db::FETCH_OBJ)->total;
	
				if($checkUsername > 0) {
					$this->apiOut['status'] = (int) 0;
					$this->apiOut['error'] = true;
					$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' sudah ada di database.';
				}
				else {
					$old->username=$this->request->getPost('username');
					$old->fullname=$this->request->getPost('fullname');
					$old->email=$this->request->getPost('email');
					$old->roles=$this->request->getPost('roles');
					$old->status=$this->request->getPost('status');
					$old->no_whatsapp=$this->request->getPost('no_whatsapp');
					if(strlen($this->request->getPost('password')) > 0) {
						$old->password=$this->security->hash($this->request->getPost('password'));
					}
	
					if($old->save()) {

						if($old->roles=='penyuluh') {
							$penyuluh=Penyuluh::findFirstById($old->id_relation);
								$penyuluh->login_username=$this->request->getPost('username');
								if(strlen($this->request->getPost('password')) > 0) {
									$penyuluh->login_password=$this->request->getPost('password');
								}
							$penyuluh->save();
							$this->apiOut['message_extend']="update ke penyuluh, id=$old->id_relation. username jadi : ".$this->request->getPost('username');
						}

						$this->apiOut['status'] = (int) 1;
						$this->apiOut['error'] = false;
						$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' berhasil disimpan';
					} 
					else {
						$this->apiOut['status'] = (int) 0;
						$this->apiOut['error'] = true;
						$this->apiOut['message'] = 'Username '.$this->request->getPost('username').' gagal disimpan';
					}
				}
			}

			$this->apiOut['post'] = $this->request->getPost();
			$this->apiOut['request'] = $_REQUEST;

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}

	private function hapus_user()
	{
		if($this->request->isAjax()):
			$delete=MUsers::findFirstById($this->request->get('uid'));
			$old=$delete;
			$delete->delete();

			if($old->roles=="penyuluh") {
				$penyuluh=Penyuluh::findFirstById($old->id_relation);
					$penyuluh->login_username=null;
					$penyuluh->login_password=null;
				$penyuluh->save();
			}

			$this->apiOut['status'] = (int) 1;
			$this->apiOut['error'] = null;
			$this->apiOut['message'] = 'Berhasil Hapus';
			$this->apiOut['post'] = $this->request->getPost();

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}	

	private function getListRoles($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT roles AS get_value FROM m_roles WHERE roles NOT IN ('developer') ORDER BY roles ASC";
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

	public function winaddAction()
	{
		$data['list_roles']=$this->getListRoles()->render(
			'roles',
			[
				'class'=>'form-control select2',
				'required'=>'required',
				'id'=>'mySelect2',
			]
		);

		$this->view->setVar("data",(object)$data);
	}

	public function wineditAction($id)
	{
		$row=MUsers::findFirstById($id);
		$data['row']=$row;

		$data['list_roles']=$this->getListRoles($row->roles)->render(
			'roles',
			[
				'class'=>'form-control select2',
				'required'=>'required',
				'id'=>'mySelect2',
			]
		);

		$data['status_active']='';
		$data['status_not_active']='checked';

		if($row->status == 1) {
			$data['status_active']='checked';
			$data['status_not_active']='';
		}

		$this->view->setVar("data",(object)$data);
	}
}