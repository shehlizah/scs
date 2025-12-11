<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class SiswaController extends ControllerBase
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
        if (strlen($this->session->get('auth')->sekolah) > 0) {
            $builder = $this->modelsManager->createBuilder()  
                ->columns('
                    id
                    ,sekolah
                    ,nama_lengkap
                    ,sex
                    ,tgl_lahir
                    ,nama_ibu_kandung
                    ,nik
                    ,nisn
                    ,tingkat
                    ,rombel
                    ,waktu_pembaruan
                    ,fr_id
                    ,fr_enroll_at
                    ,fr_enroll
                    ,image_path
                    ,nomor_orangtua
                    ,sync_at
                ') 
                ->from('Siswa')
                ->where("Siswa.sekolah = '".$this->session->get('auth')->sekolah."'");
        }
        else {
            $builder = $this->modelsManager->createBuilder()  
                ->columns('
                    id
                    ,sekolah
                    ,nama_lengkap
                    ,sex
                    ,tgl_lahir
                    ,nama_ibu_kandung
                    ,nik
                    ,nisn
                    ,tingkat
                    ,rombel
                    ,waktu_pembaruan
                    ,fr_id
                    ,fr_enroll_at
                    ,fr_enroll
                    ,image_path
                    ,nomor_orangtua
                    ,sync_at
                ') 
                ->from('Siswa');
        }
		
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

    public function addAction($id=false) 
	{ 
        if($this->request->isPost()) {
            $row = new Siswa();
            $row->sekolah=Config::findFirstByKey('scs_sekolah')->value;
            $row->nisn=$this->request->getpost('nisn');
            $row->nama_lengkap=$this->request->getpost('nama_lengkap');
            $row->nik=$this->request->getpost('nik');
            $row->tingkat=$this->request->getpost('tingkat');
            $row->rombel=$this->request->getpost('rombel');
            $row->nomor_orangtua=$this->request->getpost('nomor_orangtua');
            $row->nama_ibu_kandung=$this->request->getpost('nama_ibu_kandung');
            if ($row->save()) {
                $this->flashSession->success("Input $row->nisn $row->nama_lengkap Berhasil"); 
                $this->response->redirect("/siswa/edit/".$row->id);
            } 
            else {
                $this->flashSession->error("Input $row->nisn $row->nama_lengkap ERROR"); 
                $this->response->redirect("/siswa/edit/".$row->id);
            }
        }

        $this->view->setVar("data",(object)$data);
	}

    public function editAction($id=false) 
	{ 
		if($id!=false) {
			$row=Siswa::findFirstById($id);
			if($row) {
				if($this->request->isPost()) {
					$row->sekolah=$this->request->getpost('sekolah');
					$row->nisn=$this->request->getpost('nisn');
					$row->nama_lengkap=$this->request->getpost('nama_lengkap');
					$row->nik=$this->request->getpost('nik');
					$row->tingkat=$this->request->getpost('tingkat');
					$row->rombel=$this->request->getpost('rombel');
					$row->nomor_orangtua=$this->request->getpost('nomor_orangtua');
					$row->nama_ibu_kandung=$this->request->getpost('nama_ibu_kandung');
                    $row->save();

                    if ($this->request->hasFiles() == true) {
                        $dir_sekolah = str_replace(" ","_",Config::findFirstByKey('scs_sekolah')->value);
						$upload_dir = 'memberdir/'.$dir_sekolah.'/';
		
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
                                    $siswa=Siswa::findFirstById($row->id);

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
                                                    "Name" => $siswa->nama_lengkap.' '.$siswa->nisn.' '.$siswa->rombel.' '.$siswa->sekolah,
                                                    "Country" => $siswa->provinsi,
                                                    "NativePlace" => $siswa->kabkota,
                                                    "IdCode" => $siswa->tgl_lahir,
                                                    "Job" => "SISWA",
                                                    "Domicile" => $siswa->sekolah,
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
                                        && strlen($_resp['data']['Id'][0]) > 0 
                                        && strlen($_resp['data']['MD5'][0]) > 0) {

                                        $e=Siswa::findFirstById($row->id);
                                        $e->fr_id=$_resp['data']['Id'][0];
                                        $e->fr_md5=$_resp['data']['MD5'][0];
                                        $e->fr_enroll_at=date('Y-m-d H:i:s');
                                        $e->$kolom=$new_file;
                                        $e->save();
                                        
                                        $this->flashSession->success("Status Enroll NVR $row->nisn $row->nama_lengkap Berhasil : ".$resp); 
                                        $this->response->redirect("/siswa/edit/".$row->id);
                                    } 
                                    else {
                                        $this->flashSession->error("Status Enroll NVR $row->nisn $row->nama_lengkap ERROR, Message ".$resp." ".json_encode($enroll)); 
                                        $this->response->redirect("/siswa/edit/".$row->id);
                                    }
								}
							}
                            else {
                                $this->flashSession->success("Data Siswa $row->nisn $row->nama_lengkap berhasil diubah."); 
                                $this->response->redirect("/siswa/edit/".$id);                                
                            }
						}
					}
				}

				$data['row']=$row;
				$data['image_path']="-";

                if (strlen($row->image_path) > 0) {
                    $data['image_path']='
                    <div style="margin-top:10px; margin-bottom:20px;">
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