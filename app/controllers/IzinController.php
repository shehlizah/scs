<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class IzinController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($param=false)
    {
        if ($this->request->isAjax()) {
			$this->view->disable(); 
			if (method_exists(__CLASS__,$param)) {
				$this->{$param}(); 
			} 
            else { 
				throw new Exception("Method tidak tersedia"); 
			}
		} 
        else {
            $this->view->setVar("data",(object)$page);
        }
    }

    private function all_data()
	{ 
		// 

        if (strlen($this->session->get('auth')->sekolah) > 0) {
            $builder = $this->modelsManager->createBuilder()  
			->columns('
                 LeaveRequest.id
				,LeaveRequest.sekolah
				,LeaveRequest.rombel
				,LeaveRequest.nisn
				,Siswa.nama_lengkap
				,LeaveRequest.tgl_request
				,LeaveRequest.tgl_request_str
				,LeaveRequest.request_type
				,LeaveRequest.keterangan
				,LeaveRequest.status_type
				,LeaveRequest.file_surat
				,LeaveRequest.created_at
				,LeaveRequest.created_by
				,LeaveRequest.updated_at
				,LeaveRequest.updated_by
			')
            ->where("LeaveRequest.sekolah = '".$this->session->get('auth')->sekolah."'") 
            ->Join('Siswa','LeaveRequest.nisn=Siswa.nisn','Siswa')
			->from('LeaveRequest');     
        }
        else {

            $builder = $this->modelsManager->createBuilder()  
                ->columns('
                     LeaveRequest.id
                    ,LeaveRequest.sekolah
                    ,LeaveRequest.rombel
                    ,LeaveRequest.nisn
                    ,Siswa.nama_lengkap
                    ,LeaveRequest.tgl_request
                    ,LeaveRequest.tgl_request_str
                    ,LeaveRequest.request_type
                    ,LeaveRequest.keterangan
                    ,LeaveRequest.status_type
                    ,LeaveRequest.file_surat
                    ,LeaveRequest.created_at
                    ,LeaveRequest.created_by
                    ,LeaveRequest.updated_at
                    ,LeaveRequest.updated_by
                ') 
                ->Join('Siswa','LeaveRequest.nisn=Siswa.nisn','Siswa')
                ->from('LeaveRequest'); 
        }
        
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

    public function dropdownSekolah($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT DISTINCT(sekolah) AS sekolah FROM sekolah_rombel ORDER BY sekolah ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['sekolah']]=strtoupper($val['sekolah']);
        }
        
        $select = new Select("sekolah",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Sekolah',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownRombel($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT DISTINCT(rombel) AS rombel FROM sekolah_rombel ORDER BY rombel ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['rombel']]=strtoupper($val['rombel']);
        }
        
        $select = new Select("rombel",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Rombel',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownStatusType($def_val=null)
	{
        $form=new Form();
		$result=[];

        $result['BELUM DISETUJUI'] = 'BELUM DISETUJUI';
        $result['DISETUJUI'] = 'DISETUJUI';
        
        $select = new Select("status_type",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Status',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function addAction($id=false) 
	{ 
        if($this->request->isPost()) {
            $row = new LeaveRequest();
            $row->sekolah=$this->request->getpost('sekolah');
            $row->rombel=$this->request->getpost('rombel');
            $row->nisn=$this->request->getpost('nisn');
            $row->tgl_request=$this->request->getpost('tgl_request');
            $row->request_type='IZIN';
            $row->keterangan=$this->request->getpost('keterangan');
            $row->status_type=$this->request->getpost('status_type');
            $row->created_at=date('Y-m-d H:i:s');

            if ($row->save()) {

                if ($this->request->hasFiles() == true) {
                    $dir_sekolah = str_replace(" ","_",$row->sekolah);
                    $upload_dir = 'izin/'.$dir_sekolah.'/';
                    $full_upload_dir = '/home/devops/web_dev/scs_api/public/izin/'.$dir_sekolah.'/';
    
                    if(!is_dir($full_upload_dir)) {
                        mkdir($full_upload_dir, 0755, true);
                    }
    
                    foreach ($this->request->getUploadedFiles() as $file) {
                        if(strlen($file->getExtension()) > 0) {
                            $kolom = $file->getKey();
                            $filename=$row->tgl_request.'_'.$row->nisn.'.'.$file->getExtension();
                            $upload_file=$full_upload_dir . $filename;
    
                            if($file->moveTo($upload_file)) {
                                $update=LeaveRequest::findFirstById($row->id);
                                $update->$kolom=$upload_dir.$filename;
                                $update->update();
                            }
                        }
                    }
                }

                $this->flashSession->success("Input Izin Siswa Berhasil"); 
                $this->response->redirect("/izin");
            } 
            else {
                $this->flashSession->error("Input Izin Siswa Gagal"); 
                $this->response->redirect("/izin");
            }
        }

        $data['dropdown_sekolah']=$this->dropdownSekolah()->render(
            'sekolah',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                'required'=>''
                
            ]
        );        
        
        $data['dropdown_rombel']=$this->dropdownRombel()->render(
            'rombel',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                'required'=>''
                
            ]
        );

        $data['dropdown_status_type']=$this->dropdownStatusType()->render(
            'status_type',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                'required'=>''
                
            ]
        );

        $this->view->setVar("data",(object)$data);
	}

    public function editAction($id=false) 
	{ 
		if($id!=false) {
			$row=LeaveRequest::findFirstById($id);
			if($row) {
				if($this->request->isPost()) {
                    $row->status_type='SUDAH DISETUJUI';
                    $row->updated_at=date('Y-m-d H:i:s');
                    $row->save();

                    $this->flashSession->success("Permohonan Izin Siswa Berhasil disimpan"); 
                    $this->response->redirect("/izin");
				}

				$data['row']=$row;
				$data['file_surat']="-";

                if (strlen($row->file_surat) > 0) {
                    $data['file_surat']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a 
                            href="https://api.disdiksulsel.id/'.$row->file_surat.'" 
                            class="btn col-3 btn-warning waves-effect waves-light" 
                            title="Lihat Surat"
                            text="" 
                            target="_blank"
                            >Lihat Surat</a>
                    </div>                    
                    ';
                }

                $data['dropdown_status_type']=$this->dropdownStatusType($row->status_type)->render(
                    'status_type',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        'required'=>''
                        
                    ]
                );

				$this->view->setVar("data",(object)$data);
			}
			else {
				throw new Exception("Data tidak tersedia"); 
			}
		}
		else {
			throw new Exception("Data tidak tersedia"); 
		}
	}

    public function deletenvrAction($id=false) 
	{ 
		if($id!=false) {
			$row=Siswa::findFirstById($id);
			if ($row) {
                // start enrollment ke NVR
                $data['cookie'] = $this->session->get('set-cookie');
                $data['xcsrftoken'] = $this->session->get('x-csrftoken');
                $cookie=explode(";",$data['cookie']);
                $session=str_replace("session=","",$cookie[0]);

                $enroll=[
                    'data'=>[
                        'FaceInfo'=>[
                            0=>[
                                "Id" => (int) $row->fr_id,
                            ]
                        ]
                    ]
                ];

                $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_facedelete')->value."?".date('YmdHis');
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($enroll));
                curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
                curl_setopt($ch, CURLOPT_HTTPHEADER,
                    [
                        'X-csrftoken: '.$this->session->get('x-csrftoken'),
                        'Content-Type: application/json',
                        'Cookie: session='.$session
                    ]
                );

                $resp = curl_exec($ch);
                curl_close($ch);

                $_resp = json_decode($resp, true);

                // {
                //     "data": {
                //       "Count": 1,
                //       "Result": [
                //         0
                //       ],
                //       "ResultReason": [
                //         "Successful"
                //       ],
                //       "Id": [
                //         40
                //       ],
                //       "MD5": [
                //         "E65DC85572CE558DD0E91C4608138209"
                //       ]
                //     }
                // }

                if ($_resp['data']['Count'] == 1 
                    && $_resp['data']['ResultReason'][0] == 'Successful' 
                    && strlen($_resp['data']['Id'][0]) > 0) {
                    
                    if (file_exists($row->image_path)) {
                        unlink($row->image_path);
                    }

                    $e=Siswa::findFirstById($row->id);
                    $e->fr_id=null;
                    $e->fr_md5=null;
                    $e->fr_enroll_at=null;
                    $e->image_path=null;
                    $e->save();
                    
                    $this->flashSession->success("Status Hapus Foto Enroll $row->nisn $row->nama_lengkap Berhasil : ".$resp); 
                    $this->response->redirect("/siswa/edit/".$row->id);
                } 
                else {
                    if (file_exists($row->image_path)) {
                        unlink($row->image_path);
                    }

                    $e=Siswa::findFirstById($row->id);
                    $e->fr_id=null;
                    $e->fr_md5=null;
                    $e->fr_enroll_at=null;
                    $e->image_path=null;
                    $e->save();
                    
                    $this->flashSession->error("Status Hapus Foto Enroll $row->nisn $row->nama_lengkap ERROR, Message ".$resp." ".json_encode($enroll)); 
                    $this->response->redirect("/siswa/edit/".$row->id);
                }                
			}
			else {
				throw new Exception("Data tidak tersedia"); 
			}
		}
		else {
			throw new Exception("Data tidak tersedia"); 
		}
	}
}