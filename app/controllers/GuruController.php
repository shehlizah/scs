<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class GuruController extends ControllerBase
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
		$builder = $this->modelsManager->createBuilder()  
			->columns('
                 Guru.id
				,Guru.sekolah
				,Guru.nama_lengkap
				,Guru.nip
				,Guru.nik
				,Guru.nuptk
				,Guru.sex
				,Guru.tempat_lahir
				,Guru.tgllahir
				,Guru.statuskepegawaianid
				,StatusKepegawaian.nama as status_pegawai
				,Guru.golonganid
				,Guru.jenisptkid
				,Guru.agama
				,Guru.alamat
				,Guru.telepon
				,Guru.hp
				,Guru.email
				,Guru.tglmasuk
				,Guru.aktif
				,Guru.no_surat_tugas
				,Guru.tgl_surat_tugas
				,Guru.keluar_karena
				,Guru.tgl_keluar
				,Guru.fr_id
				,Guru.fr_enroll_at
				,Guru.fr_enroll
				,Guru.fr_md5
				,Guru.image_path
				,Guru.created_at
				,Guru.created_by
				,Guru.updated_at
				,Guru.updated_by
			')
            ->Join('StatusKepegawaian','Guru.statuskepegawaianid=StatusKepegawaian.id','StatusKepegawaian')
			->from('Guru');
            
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

    public function dropdownPangkatGolongan($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT id, nama FROM ref_pangkat_golongan ORDER BY id ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['nama']);
        }
        
        $select = new Select("golonganid",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Tidak Ada',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownStatusKepegawaian($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT id, nama FROM status_kepegawaian ORDER BY id ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['nama']);
        }
        
        $select = new Select("statuskepegawaianid",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Tidak Ada',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownJenisPtk($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT id, nama FROM ref_jenis_ptk ORDER BY id ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['nama']);
        }
        
        $select = new Select("jenisptkid",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Tidak Ada',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function addAction() 
	{ 
        if($this->request->isPost()) {
            $new = new Guru();
            $new->sekolah=Config::findFirstByKey('scs_sekolah')->value;
            $new->provinsi='SULAWESI SELATAN';
            $new->nama_lengkap=$this->request->getpost('nama_lengkap');
            $new->nik=$this->request->getpost('nik');
            $new->nip=$this->request->getpost('nip');
            $new->nuptk=$this->request->getpost('nuptk');
            $new->statuskepegawaianid=$this->request->getpost('statuskepegawaianid');
            $new->golonganid=$this->request->getpost('golonganid');
            $new->jenisptkid=$this->request->getpost('jenisptkid');
            
            if (strlen($this->request->getpost('tempat_lahir')) > 0) {
                $new->tempat_lahir=$this->request->getpost('tempat_lahir');
            }

            if (strlen($this->request->getpost('tgllahir')) > 0) {
                $new->tgllahir=$this->request->getpost('tgllahir');
            }

            if (strlen($this->request->getpost('tglmasuk')) > 0) {
                $new->tglmasuk=$this->request->getpost('tglmasuk');
            }

            if (strlen($this->request->getpost('tgl_surat_tugas')) > 0) {
                $new->tgl_surat_tugas=$this->request->getpost('tgl_surat_tugas');
            }

            $new->no_surat_tugas=$this->request->getpost('no_surat_tugas');
            $new->alamat=$this->request->getpost('alamat');
            $new->telepon=$this->request->getpost('telepon');
            $new->hp=$this->request->getpost('hp');
            $new->email=$this->request->getpost('email');
            $new->created_at=date('Y-m-d H:i:s');
            
            if ($new->save()) {
                $this->flashSession->success("Data Guru $row->nama_lengkap berhasil ditambah."); 
                $this->response->redirect("/guru/index");                                
            }
            else {
                $this->flashSession->error("Data gagal ditambah"); 
                $this->response->redirect("/guru/index");
            }
        }

        $data['row']=$row;
        $data['image_path']="-";

        $data['dropdown_pangkat_golongan']=$this->dropdownPangkatGolongan()->render(
            'golonganid',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );
        
        $data['dropdown_status_kepegawaian']=$this->dropdownStatusKepegawaian()->render(
            'statuskepegawaianid',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );
        
        $data['dropdown_jenis_ptk']=$this->dropdownJenisPtk()->render(
            'jenisptkid',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );

        $this->view->setVar("data",(object)$data);
	}

    public function editAction($id=false) 
	{ 
		if($id!=false) {
			$row=Guru::findFirstById($id);
			if($row) {
				if($this->request->isPost()) {
                    $row->sekolah=Config::findFirstByKey('scs_sekolah')->value;
                    $row->nama_lengkap=$this->request->getpost('nama_lengkap');
					$row->nik=$this->request->getpost('nik');
					$row->nip=$this->request->getpost('nip');
					$row->nuptk=$this->request->getpost('nuptk');
					$row->statuskepegawaianid=$this->request->getpost('statuskepegawaianid');
					$row->golonganid=$this->request->getpost('golonganid');
					$row->jenisptkid=$this->request->getpost('jenisptkid');
					
                    if (strlen($this->request->getpost('tempat_lahir')) > 0) {
                        $row->tempat_lahir=$this->request->getpost('tempat_lahir');
                    }

                    if (strlen($this->request->getpost('tgllahir')) > 0) {
                        $row->tgllahir=$this->request->getpost('tgllahir');
                    }

                    if (strlen($this->request->getpost('tglmasuk')) > 0) {
                        $row->tglmasuk=$this->request->getpost('tglmasuk');
                    }

                    if (strlen($this->request->getpost('tgl_surat_tugas')) > 0) {
                        $row->tgl_surat_tugas=$this->request->getpost('tgl_surat_tugas');
                    }

					$row->no_surat_tugas=$this->request->getpost('no_surat_tugas');
					$row->alamat=$this->request->getpost('alamat');
					$row->telepon=$this->request->getpost('telepon');
					$row->hp=$this->request->getpost('hp');
					$row->email=$this->request->getpost('email');
                    $new->updated_at=date('Y-m-d H:i:s');
					$row->save();

                    if ($this->request->hasFiles() == true) {
                        $dir_sekolah = str_replace(" ","_",Config::findFirstByKey('scs_sekolah')->value);
						$upload_dir = 'memberdir/'.$dir_sekolah.'_GURU/';
		
						if(!is_dir($upload_dir)) {
							mkdir($upload_dir, 0755, true);
						}
		
						foreach ($this->request->getUploadedFiles() as $file) {
							if(strlen($file->getExtension()) > 0) {
								$kolom = $file->getKey();
								$filename=$row->nisn.'.'.$file->getExtension();
								$upload_file=$upload_dir . $filename;

								if (file_exists($old->$kolom)) {
									unlink($old->$kolom);
								}
		
								if($file->moveTo($upload_file)) {
									// $update=Siswa::findFirstById($id);
									// $update->$kolom=$upload_dir.$filename;
									// $update->update();
                                    $new_file = $upload_file;
                                    $image = new \Phalcon\Image\Adapter\Gd($upload_file);
                                    if ($image->getWidth() > 600) {
                                        $image->resize(
                                            500,
                                            null,
                                            \Phalcon\Image::WIDTH
                                        );
                                        
                                        $filename='resize_'.$filename;
                                        $image->save($upload_dir . $filename);
                                        $new_file = $upload_dir . $filename;
                                        unlink($upload_file);
                                    }                                    

                                    // start enrollment ke NVR
                                    $data['cookie'] = $this->session->get('set-cookie');
                                    $data['xcsrftoken'] = $this->session->get('x-csrftoken');
                                    $cookie=explode(";",$data['cookie']);
                                    $session=str_replace("session=","",$cookie[0]);

                                    $img64=base64_encode(file_get_contents($new_file));
                                    $guru=Guru::findFirstById($row->id);

                                    $enroll=[
                                        'data'=>[
                                            'FaceInfo'=>[
                                                0=>[
                                                    "GrpId" => (int) Config::findFirstByKey('nvr_group_target')->value,
                                                    "Sex" => 1,
                                                    // "Age"=> 33,
                                                    "Image" => $img64,
                                                    "Feature" => "",
                                                    "FtVersion" => 141188,
                                                    "Name" => $guru->nama_lengkap.' '.$guru->nip.' '.$guru->nik.' '.$guru->nuptk,
                                                    "Country" => $guru->provinsi,
                                                    "NativePlace" => $guru->provinsi,
                                                    "IdCode" => $guru->tgllahir,
                                                    "Job" => "GURU",
                                                    "Domicile" => $guru->sekolah,
                                                    "Remark" => "",
                                                    "EnableChnAlarm" => [255,255,255,255],
                                                ]
                                            ]
                                        ]
                                    ];
                    
                    
                                    $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_enroll')->value."?".date('YmdHis');
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
                    
                                    if ($_resp['data']['Count'] == 1 
                                        && $_resp['data']['ResultReason'][0] == 'Successful' 
                                        && strlen($_resp['data']['Id'][0]) > 0 
                                        && strlen($_resp['data']['MD5'][0]) > 0) {

                                        $e=Siswa::findFirstById($row->id);
                                        $e->fr_id=$_resp['data']['Id'][0];
                                        $e->fr_md5=$_resp['data']['MD5'][0];
                                        $e->fr_enroll_at=date('Y-m-d H:i:s');
                                        $e->$kolom=$new_file;
                                        $e->save();
                                        
                                        $this->flashSession->success("Status Enroll NVR $row->nip $row->nama_lengkap Berhasil : ".$resp); 
                                        $this->response->redirect("/guru/edit/".$row->id);
                                    } 
                                    else {
                                        $this->flashSession->error("Status Enroll NVR $row->nip $row->nama_lengkap ERROR, Message ".$resp." ".json_encode($enroll)); 
                                        $this->response->redirect("/guru/edit/".$row->id);
                                    }
								}
							}
                            else {
                                $this->flashSession->success("Data Guru $row->nama_lengkap berhasil diubah."); 
                                $this->response->redirect("/guru/edit/".$id);                                
                            }
						}
					}
				}

				$data['row']=$row;
				$data['image_path']="-";

                $data['dropdown_pangkat_golongan']=$this->dropdownPangkatGolongan($row->golonganid)->render(
					'golonganid',
					[
						'class'=>'form-control select2 select2_tag_add_new',
						
					]
				);
                
                $data['dropdown_status_kepegawaian']=$this->dropdownStatusKepegawaian($row->statuskepegawaianid)->render(
					'statuskepegawaianid',
					[
						'class'=>'form-control select2 select2_tag_add_new',
						
					]
				);
                
                $data['dropdown_jenis_ptk']=$this->dropdownJenisPtk($row->jenisptkid)->render(
					'jenisptkid',
					[
						'class'=>'form-control select2 select2_tag_add_new',
						
					]
				);

                if (strlen($row->image_path) > 0) {
                    $data['image_path']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a 
                            href="" 
                            class="btn col-3 btn-danger waves-effect waves-light" 
                            id="enroll_nvr_delete" 
                            title="Hapus Enrollment Foto"
                            text="Foto Enrollment '.$row->nik.' - '.$row->nama_lengkap.' akan dihapus"
                            >Hapus Enrollment Foto</a>
                        <br/>
                        <br/>
                        <a href="/'.$row->image_path.'" target="_blank">
                            <img src="/'.$row->image_path.'?'.date('YmdHis').'" width="300" border=0>
                        </a>
                    </div>                    
                    ';
                }

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
			$row=Guru::findFirstById($id);
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

                    $e=Guru::findFirstById($row->id);
                    $e->fr_id=null;
                    $e->fr_md5=null;
                    $e->fr_enroll_at=null;
                    $e->image_path=null;
                    $e->save();
                    
                    $this->flashSession->success("Status Hapus Foto Enroll $row->nik $row->nama_lengkap Berhasil : ".$resp); 
                    $this->response->redirect("/guru/edit/".$row->id);
                } 
                else {
                    if (file_exists($row->image_path)) {
                        unlink($row->image_path);
                    }

                    $e=Guru::findFirstById($row->id);
                    $e->fr_id=null;
                    $e->fr_md5=null;
                    $e->fr_enroll_at=null;
                    $e->image_path=null;
                    $e->save();
                    
                    $this->flashSession->error("Status Hapus Foto Enroll $row->nik $row->nama_lengkap ERROR, Message ".$resp." ".json_encode($enroll)); 
                    $this->response->redirect("/guru/edit/".$row->id);
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