<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class BanksoalController extends ControllerBase
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
                     BankSoal.id
                    ,BankSoal.id_test
                    ,BankSoal.sekolah
                    ,BankSoal.id_mapel
                    ,RefMapel.mapel
                    ,BankSoal.tingkat
                    ,BankSoal.created_at
                    ,BankSoal.created_by
                    ,BankSoal.updated_at
                    ,BankSoal.updated_by
                    ,BankSoal.soal_text
                    ,BankSoal.soal_foto
                    ,BankSoal.jawab1_text
                    ,BankSoal.jawab1_foto
                    ,BankSoal.jawab2_text
                    ,BankSoal.jawab2_foto
                    ,BankSoal.jawab3_text
                    ,BankSoal.jawab3_foto
                    ,BankSoal.jawab4_text
                    ,BankSoal.jawab4_foto
                    ,BankSoal.jawab5_text
                    ,BankSoal.jawab5_foto
                    ,BankSoal.jawab_benar
                    ,BankSoal.soal_bobot                
    
                ')
                ->where("BankSoal.sekolah = '".$this->session->get('auth')->sekolah."'")
                ->Join('RefMapel','BankSoal.id_mapel=RefMapel.id','RefMapel')
                ->from('BankSoal');
        }
        else {
            $builder = $this->modelsManager->createBuilder()  
                ->columns('
                     BankSoal.id
                    ,BankSoal.id_test
                    ,BankSoal.sekolah
                    ,BankSoal.id_mapel
                    ,RefMapel.mapel
                    ,BankSoal.tingkat
                    ,BankSoal.created_at
                    ,BankSoal.created_by
                    ,BankSoal.updated_at
                    ,BankSoal.updated_by
                    ,BankSoal.soal_text
                    ,BankSoal.soal_foto
                    ,BankSoal.jawab1_text
                    ,BankSoal.jawab1_foto
                    ,BankSoal.jawab2_text
                    ,BankSoal.jawab2_foto
                    ,BankSoal.jawab3_text
                    ,BankSoal.jawab3_foto
                    ,BankSoal.jawab4_text
                    ,BankSoal.jawab4_foto
                    ,BankSoal.jawab5_text
                    ,BankSoal.jawab5_foto
                    ,BankSoal.jawab_benar
                    ,BankSoal.soal_bobot                
    
                ')
                ->Join('RefMapel','BankSoal.id_mapel=RefMapel.id','RefMapel')
                ->from('BankSoal');
        }
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function delete()
	{
		if($this->request->isAjax()):
			$delete=BankSoal::findFirstById($this->request->get('uid'));
			$old=$delete;
			$delete->delete();

            if (file_exists($old->soal_foto)) {
                unlink($old->soal_foto);
            }

            if (file_exists($old->jawab1_foto)) {
                unlink($old->jawab1_foto);
            }

            if (file_exists($old->jawab2_foto)) {
                unlink($old->jawab2_foto);
            }

            if (file_exists($old->jawab3_foto)) {
                unlink($old->jawab3_foto);
            }

            if (file_exists($old->jawab4_foto)) {
                unlink($old->jawab4_foto);
            }

            if (file_exists($old->jawab5_foto)) {
                unlink($old->jawab5_foto);
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

    public function dropdownMapel($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT id, mapel FROM ref_mapel ORDER BY mapel ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['mapel']);
        }
        
        $select = new Select("mapel",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Mata Pelajaran',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownTingkatKelas($def_val=null)
	{
        $form=new Form();
		$result=[];
        $result[10]='KELAS 10';
        $result[11]='KELAS 11';
        $result[12]='KELAS 12';
        
        $select = new Select("tingkat",$result,[
            "useEmpty"  =>  false,
            'emptyText' => 'Pilih Tingkat Kelas',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownJawabanBenar($def_val=null)
	{
        $form=new Form();
		$result=[];
        $result[1]='JAWABAN A';
        $result[2]='JAWABAN B';
        $result[3]='JAWABAN C';
        $result[4]='JAWABAN D';
        $result[5]='JAWABAN E';
        
        $select = new Select("jawab_benar",$result,[
            "useEmpty"  =>  false,
            'emptyText' => 'Pilih Jawaban Benar',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function addAction($id=false) 
	{ 
        if($this->request->isPost()) {
            $new = new BankSoal();
            $new->id_test = null;
            $new->sekolah = $this->request->getpost('sekolah');
            $new->id_mapel = $this->request->getpost('mapel');
            $new->tingkat = $this->request->getpost('tingkat');
            $new->created_at = date('Y-m-d H:i:s');
            $new->created_by = $this->session->get('auth')->username;
            $new->soal_text = $this->request->getpost('soal_text');
            $new->jawab1_text = $this->request->getpost('jawab1_text');
            $new->jawab2_text = $this->request->getpost('jawab2_text');
            $new->jawab3_text = $this->request->getpost('jawab3_text');
            $new->jawab4_text = $this->request->getpost('jawab4_text');
            $new->jawab5_text = $this->request->getpost('jawab5_text');
            $new->jawab_benar = $this->request->getpost('jawab_benar');
            $new->soal_bobot = $this->request->getpost('soal_bobot');

            if ($new->save()) {
                if ($this->request->hasFiles() == true) {
                    $dir_sekolah = str_replace(" ","_",$new->sekolah);
                    $upload_dir = 'file/soal/'.$dir_sekolah.'/';
    
                    if(!is_dir($upload_dir)) {
                        mkdir($upload_dir, 0755, true);
                    }
    
                    foreach ($this->request->getUploadedFiles() as $file) {
                        if(strlen($file->getExtension()) > 0) {
                            $kolom = $file->getKey();
                            $filename=$new->id.'_'.$kolom.'.'.$file->getExtension();
                            $upload_file=$upload_dir . $filename;

                            if($file->moveTo($upload_file)) {
                                $update=BankSoal::findFirstById($new->id);
                                $update->$kolom=$upload_dir.$filename;
                                $update->update();
                            }
                        }
                    }
                }

                $this->flashSession->success("Soal $new->soal_text berhasil ditambah."); 
                $this->response->redirect("/banksoal/index");
            } 
            else {
                $this->flashSession->error("Soal $new->soal_text gagal ditambah."); 
                $this->response->redirect("/banksoal/index");
            }
        }

        $data['dropdown_sekolah']=$this->dropdownSekolah()->render(
            'sekolah',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );        
        
        $data['dropdown_mapel']=$this->dropdownMapel()->render(
            'mapel',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );        
        
        $data['dropdown_tingkat']=$this->dropdownTingkatKelas()->render(
            'tingkat',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );        
        
        $data['dropdown_jawaban_benar']=$this->dropdownJawabanBenar()->render(
            'jawab_benar',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );        

        $this->view->setVar("data",(object)$data);
	}

    public function editAction($id=false) 
	{ 
		if($id!=false) {
			$row=BankSoal::findFirstById($id);
            $old=$row;
			if($row) {
				if($this->request->isPost()) {
                    $row->id_test = null;
                    $row->id_mapel = $this->request->getpost('mapel');
                    $row->tingkat = $this->request->getpost('tingkat');
                    $row->updated_at = date('Y-m-d H:i:s');
                    $row->updated_by = $this->session->get('auth')->username;
                    $row->soal_text = $this->request->getpost('soal_text');
                    $row->jawab1_text = $this->request->getpost('jawab1_text');
                    $row->jawab2_text = $this->request->getpost('jawab2_text');
                    $row->jawab3_text = $this->request->getpost('jawab3_text');
                    $row->jawab4_text = $this->request->getpost('jawab4_text');
                    $row->jawab5_text = $this->request->getpost('jawab5_text');
                    $row->jawab_benar = $this->request->getpost('jawab_benar');
                    $row->soal_bobot = $this->request->getpost('soal_bobot');
                    $row->save();

                    if ($this->request->hasFiles() == true) {
                        $dir_sekolah = str_replace(" ","_",$row->sekolah);
                        $upload_dir = 'file/soal/'.$dir_sekolah.'/';
		
						if(!is_dir($upload_dir)) {
							mkdir($upload_dir, 0755, true);
						}
		
						foreach ($this->request->getUploadedFiles() as $file) {
							if(strlen($file->getExtension()) > 0) {
								$kolom = $file->getKey();
								$filename=$row->id.'_'.$kolom.'.'.$file->getExtension();
								$upload_file=$upload_dir . $filename;

								if (file_exists($old->$kolom)) {
									unlink($old->$kolom);
								}
		
								if($file->moveTo($upload_file)) {
									$update=BankSoal::findFirstById($row->id);
                                    $update->$kolom=$upload_dir.$filename;
                                    $update->update();
								}
							}
						}
					}

                    $this->flashSession->success("Soal $row->soal_text berhasil diubah."); 
                    $this->response->redirect("/banksoal/edit/".$row->id);
				}

				$data['row']=$row;
				$data['soal_foto']="-";
				$data['jawab1_foto']="-";
				$data['jawab2_foto']="-";
				$data['jawab3_foto']="-";
				$data['jawab4_foto']="-";
				$data['jawab5_foto']="-";

                $data['dropdown_sekolah']=$this->dropdownSekolah($row->sekolah)->render(
                    'sekolah',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_mapel']=$this->dropdownMapel($row->id_mapel)->render(
                    'mapel',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_tingkat']=$this->dropdownTingkatKelas($row->tingkat)->render(
                    'tingkat',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_jawaban_benar']=$this->dropdownJawabanBenar($row->jawab_benar)->render(
                    'jawab_benar',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );

                if (strlen($row->soal_foto) > 0) {
                    $data['soal_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->soal_foto.'" target="_blank">
                            <img src="/'.$row->soal_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab1_foto) > 0) {
                    $data['jawab1_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab1_foto.'" target="_blank">
                            <img src="/'.$row->jawab1_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab2_foto) > 0) {
                    $data['jawab2_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab2_foto.'" target="_blank">
                            <img src="/'.$row->jawab2_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab3_foto) > 0) {
                    $data['jawab3_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab3_foto.'" target="_blank">
                            <img src="/'.$row->jawab3_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab4_foto) > 0) {
                    $data['jawab4_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab4_foto.'" target="_blank">
                            <img src="/'.$row->jawab4_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab5_foto) > 0) {
                    $data['jawab5_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab5_foto.'" target="_blank">
                            <img src="/'.$row->jawab5_foto.'?'.date('YmdHis').'" width="400" border=0>
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

    public function readAction($id=false) 
	{ 
		if($id!=false) {
			$row=BankSoal::findFirstById($id);
            $old=$row;
			if($row) {
				$data['row']=$row;
				$data['soal_foto']="-";
				$data['jawab1_foto']="-";
				$data['jawab2_foto']="-";
				$data['jawab3_foto']="-";
				$data['jawab4_foto']="-";
				$data['jawab5_foto']="-";

                $data['mapel'] = RefMapel::findFirstById($row->id_mapel)->mapel;
                $result=[];
                $result[1]='JAWABAN A';
                $result[2]='JAWABAN B';
                $result[3]='JAWABAN C';
                $result[4]='JAWABAN D';
                $result[5]='JAWABAN E';

                $data['jawab_benar'] = $result[$row->jawab_benar];
                
                $data['dropdown_sekolah']=$this->dropdownSekolah($row->sekolah)->render(
                    'sekolah',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_mapel']=$this->dropdownMapel($row->id_mapel)->render(
                    'mapel',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_tingkat']=$this->dropdownTingkatKelas($row->tingkat)->render(
                    'tingkat',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );        
                
                $data['dropdown_jawaban_benar']=$this->dropdownJawabanBenar($row->jawab_benar)->render(
                    'jawab_benar',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
                    ]
                );

                if (strlen($row->soal_foto) > 0) {
                    $data['soal_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->soal_foto.'" target="_blank">
                            <img src="/'.$row->soal_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab1_foto) > 0) {
                    $data['jawab1_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab1_foto.'" target="_blank">
                            <img src="/'.$row->jawab1_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab2_foto) > 0) {
                    $data['jawab2_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab2_foto.'" target="_blank">
                            <img src="/'.$row->jawab2_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab3_foto) > 0) {
                    $data['jawab3_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab3_foto.'" target="_blank">
                            <img src="/'.$row->jawab3_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab4_foto) > 0) {
                    $data['jawab4_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab4_foto.'" target="_blank">
                            <img src="/'.$row->jawab4_foto.'?'.date('YmdHis').'" width="400" border=0>
                        </a>
                    </div>                    
                    ';
                }

                if (strlen($row->jawab5_foto) > 0) {
                    $data['jawab5_foto']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="/'.$row->jawab5_foto.'" target="_blank">
                            <img src="/'.$row->jawab5_foto.'?'.date('YmdHis').'" width="400" border=0>
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
}