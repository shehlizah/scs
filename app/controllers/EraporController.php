<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;


class EraporController extends ControllerBase
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
                    Erapor.id
                    ,Erapor.tahun_ajaran
                    ,Erapor.id_tahun_ajaran
                    ,RefTahunAjaran.tahun_ajaran
                    ,Erapor.sekolah
                    ,Erapor.rombel
                    ,Erapor.nisn
                    ,Erapor.file_erapor
                    ,Siswa.nama_lengkap
                ')
                ->where("Erapor.sekolah = '".$this->session->get('auth')->sekolah."'")
                ->LeftJoin('Siswa','Erapor.nisn=Siswa.nisn','Siswa')
                ->LeftJoin('RefTahunAjaran','Erapor.id_tahun_ajaran=RefTahunAjaran.id','RefTahunAjaran')
                ->from('Erapor');            
        }
        else {
            $builder = $this->modelsManager->createBuilder()  
                ->columns('
                    Erapor.id
                    ,Erapor.tahun_ajaran
                    ,Erapor.id_tahun_ajaran
                    ,RefTahunAjaran.tahun_ajaran
                    ,Erapor.sekolah
                    ,Erapor.rombel
                    ,Erapor.nisn
                    ,Erapor.file_erapor
                    ,Siswa.nama_lengkap
                ')
                ->LeftJoin('Siswa','Erapor.nisn=Siswa.nisn','Siswa')
                ->LeftJoin('RefTahunAjaran','Erapor.id_tahun_ajaran=RefTahunAjaran.id','RefTahunAjaran')
                ->from('Erapor');
        }
 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function delete()
	{
		if($this->request->isAjax()):
			$delete=Erapor::findFirstById($this->request->get('uid'));
			$old=$delete;
			$delete->delete();

            unlink('/home/devops/web_dev/scs_api/public/'.$old->file_erapor);

			$this->apiOut['status'] = (int) 1;
			$this->apiOut['error'] = null;
			$this->apiOut['message'] = 'Berhasil Hapus';
			$this->apiOut['post'] = $this->request->getPost();

			$this->response->setContentType("application/json", "UTF-8");
			$this->response->setJsonContent($this->apiOut);
			$this->response->send();
		endif;
	}    

    public function dropdownTahunAjaran($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT * FROM ref_tahun_ajaran ORDER BY id ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['tahun_ajaran']);
        }
        
        $select = new Select("tahun_ajaran",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Tahun Ajaran',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
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

    public function dropdownRombel($sekolah=null, $rombel=null)
	{
        $form=new Form();
		$result=array();

        if (strlen($sekolah) > 0 && strlen($rombel) > 0) {
            $res_rombel = SekolahRombel::find([
                'conditions' => 'sekolah = :sekolah:',
                'bind' => [
                    'sekolah' => $sekolah
                ],
                'order' => 'rombel asc'
            ]);

            foreach($res_rombel as $val){
                $result[$val->rombel]=strtoupper($val->rombel);
            }
        }
        else {
            $result[''] = 'Pilih Rombel';
        }
		
        
        $select = new Select("rombel",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Rombel',
        ]);

        if($rombel != null){
            $select->setDefault($rombel);
        }
		
        return $form->add($select);
    }

    public function dropdownNisn($sekolah=null, $rombel=null, $nisn=null)
	{
        $form=new Form();
		$result=array();

        if (strlen($sekolah) > 0 && strlen($rombel) > 0 && strlen($nisn) > 0) {
            $res_rombel = Siswa::find([
                'conditions' => 'sekolah = :sekolah: and rombel = :rombel:',
                'bind' => [
                    'sekolah' => $sekolah,
                    'rombel' => $rombel,
                ],
                'order' => 'nama_lengkap asc'
            ]);

            foreach($res_rombel as $val){
                $result[$val->nisn]=$val->nisn.' - '.$val->nama_lengkap;;
            }
        }
        else {
            $result[''] = 'Pilih Siswa';
        }
		
		$select = new Select("nisn",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Siswa',
        ]);
        if($nisn != null){
            $select->setDefault($nisn);
        }
		
        return $form->add($select);
    }

    public function addAction($id=false) 
	{ 
        if($this->request->isPost()) {
            $new = new Erapor();
            $new->id_tahun_ajaran=$this->request->getpost('tahun_ajaran');
            $new->sekolah=$this->request->getpost('sekolah');
            $new->rombel=$this->request->getpost('rombel');
            $new->nisn=$this->request->getpost('nisn');
            $new->created_at=date('Y-m-d H:i:s');
            $new->created_by='';

            if ($new->save()) {
                if ($this->request->hasFiles() == true) {
                    $dir_sekolah = str_replace(" ","_",$new->sekolah);
                    $upload_dir = '/home/devops/web_dev/scs_api/public/erapor/'.$dir_sekolah.'/';
                    $upload_dir_relative = 'erapor/'.$dir_sekolah.'/';
    
                    if(!is_dir($upload_dir)) {
                        mkdir($upload_dir, 0755, true);
                    }
    
                    foreach ($this->request->getUploadedFiles() as $file) {
                        if(strlen($file->getExtension()) > 0) {
                            $kolom = $file->getKey();
                            $filename=$new->id.'_'.$new->nisn.'.'.$file->getExtension();
                            $upload_file=$upload_dir . $filename;

                            if($file->moveTo($upload_file)) {
                                $update=Erapor::findFirstById($new->id);
                                $update->$kolom=$upload_dir_relative.$filename;
                                $update->update();
                            }
                        }
                    }
                }

                $this->flashSession->success("Data Erapor $new->nisn berhasil ditambah."); 
                $this->response->redirect("/erapor/index");
            } 
            else {
                $this->flashSession->error("Data Erapor $new->nisn gagal ditambah."); 
                $this->response->redirect("/erapor/index");
            }
        }

        $data['dropdown_tahun_ajaran']=$this->dropdownTahunAjaran()->render(
            'tahun_ajaran',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                'required'=>''
                
            ]
        );

        $data['dropdown_tahun_ajaran']=$this->dropdownTahunAjaran()->render(
            'tahun_ajaran',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                'required'=>''
                
            ]
        );  

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
        
        $data['dropdown_nisn']=$this->dropdownNisn()->render(
            'nisn',
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
			$row=Erapor::findFirstById($id);
            $old = $row;
			if($row) {
				if($this->request->isPost()) {
					$row->id_tahun_ajaran=$this->request->getpost('tahun_ajaran');
                    $row->sekolah=$this->request->getpost('sekolah');
                    $row->rombel=$this->request->getpost('rombel');
                    $row->nisn=$this->request->getpost('nisn');
                    $row->updated_at=date('Y-m-d H:i:s');
                    $row->updated_by=$this->session->get('auth')->username;;
                    $row->save();

                    if ($this->request->hasFiles() == true) {
                        $dir_sekolah = str_replace(" ","_",$row->sekolah);
                        $upload_dir = '/home/devops/web_dev/scs_api/public/erapor/'.$dir_sekolah.'/';
                        $upload_dir_relative = 'erapor/'.$dir_sekolah.'/';
		
						if(!is_dir($upload_dir)) {
							mkdir($upload_dir, 0755, true);
						}
		
						foreach ($this->request->getUploadedFiles() as $file) {
							if(strlen($file->getExtension()) > 0) {
								$kolom = $file->getKey();
								$filename=$row->id.'_'.$row->nisn.'.'.$file->getExtension();
								$upload_file=$upload_dir . $filename;

								if (file_exists($old->$kolom)) {
									unlink('/home/devops/web_dev/scs_api/public/' . $old->$kolom);
								}
		
								if($file->moveTo($upload_file)) {
									$update=Erapor::findFirstById($row->id);
									$update->$kolom=$upload_dir_relative . $filename;
									$update->update();
								}
							}
						}
					}

                    $this->flashSession->success("Data Erapor Siswa NISN $row->nisn berhasil diubah.");
                    $this->response->redirect("/erapor/edit/".$row->id);
				}

                $data['dropdown_tahun_ajaran']=$this->dropdownTahunAjaran($row->id_tahun_ajaran)->render(
                    'tahun_ajaran',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        'required'=>''
                        
                    ]
                );        
                
                $data['dropdown_sekolah']=$this->dropdownSekolah($row->sekolah)->render(
                    'sekolah',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        'required'=>''
                        
                    ]
                );        
                
                $data['dropdown_rombel']=$this->dropdownRombel($row->sekolah, $row->rombel)->render(
                    'rombel',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        'required'=>''
                        
                    ]
                );
                
                $data['dropdown_nisn']=$this->dropdownNisn($row->sekolah, $row->rombel, $row->nisn)->render(
                    'nisn',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        'required'=>''
                        
                    ]
                );

				$data['row']=$row;
				$data['file_erapor']="-";

                if (strlen($row->file_erapor) > 0) {
                    $data['file_erapor']='
                    <div style="margin-top:10px; margin-bottom:20px;">
                        <a href="https://api.disdiksulsel.id/'.$row->file_erapor.'?'.date('YmdHis').'" target="_blank" class="btn btn-success waves-effect waves-light">
                        Lihat File
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