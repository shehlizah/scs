<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class RefsekolahController extends ControllerBase
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
				 RefSekolah.id
				,RefSekolah.kab_kota
				,RefSekolah.sekolah
				,RefSekolah.map_lat
				,RefSekolah.map_lng
				,RefSekolah.tahun_kegiatan
			')
            // ->Join('RefSekolah','TaskPic.sekolah=RefSekolah.sekolah','RefSekolah')
            ->from('RefSekolah');
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

    private function list_soal()
	{ 
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
			->from('BankSoal')
            ->where("BankSoal.sekolah = '".$this->request->get('sekolah')."'")
            ->andWhere("BankSoal.tingkat = ".$this->request->get('tingkat')."")
            ->andWhere("BankSoal.id_mapel = ".$this->request->get('id_mapel')."")
            ; 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}

	private function delete()
	{
		if($this->request->isAjax()):
			$delete=TaskPic::findFirstById($this->request->get('uid'));
			$old=$delete;
			$delete->delete();

            unlink('/home/devops/web_dev/scs_api/public/'.$old->foto_visit);

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
		
		$q1="SELECT * FROM ref_sekolah ORDER BY kab_kota ASC, urutan ASC";
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

    public function dropdownKabkota($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT * FROM ref_kabkota ORDER BY urutan ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['nama_kabkota']]=$val['tipe_kabkota'].' '.strtoupper($val['nama_kabkota']);
        }
        
        $select = new Select("kab_kota",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Kabupaten/Kota',
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

    public function dropdownPic($def_val=null)
	{
        $form=new Form();
		$result=array();
		
		$q1="SELECT * FROM ref_pic ORDER BY nama ASC";
        $dt=$this->db->fetchAll($q1);;
        foreach($dt as $val){
            $result[$val['id']]=strtoupper($val['nama']).' - '.$val['no_telp'];
        }
        
        $select = new Select("pic",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih PIC',
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
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Tingkat Kelas',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function dropdownRombel($sekolah=null, $tingkat=null, $def_val=null)
	{
        $form=new Form();
		$result=[];

        if ($def_val != null) {
            $q1="SELECT * FROM sekolah_rombel WHERE sekolah='$sekolah' and tingkat='$tingkat' ORDER BY rombel ASC";
            $dt=$this->db->fetchAll($q1);;
            foreach($dt as $val){
                $result[$val['rombel']]=strtoupper($val['rombel']);
            }
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

    public function dropdownDurasi($def_val=null)
	{
        $form=new Form();
		$result=[];
        $result[30]='30 Menit';
        $result[45]='45 Menit';
        $result[60]='60 Menit';
        $result[90]='90 Menit';
        $result[120]='120 Menit';
        
        $select = new Select("durasi",$result,[
            "useEmpty"  =>  false,
            'emptyText' => 'Pilih Durasi',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    public function addAction($id=false) 
	{ 
        if($this->request->isPost()) {
            $new = new RefSekolah();
            $new->sekolah = $this->request->getpost('sekolah');
            $new->kab_kota = $this->request->getpost('kab_kota');
            $new->map_lat = $this->request->getpost('map_lat');
            $new->map_lng = $this->request->getpost('map_lng');
            $new->created_at = date('Y-m-d H:i:s');
            $new->created_by = $this->session->get('auth')->username;
            
            if ($new->save()) {

                $this->flashSession->success("Data Sekolah berhasil ditambah."); 
                $this->response->redirect("/refsekolah");
            } 
            else {
                $this->flashSession->error("Data Sekolah gagal ditambah."); 
                $this->response->redirect("/refsekolah/index");
            }
        }

        $data['dropdown_kabkota']=$this->dropdownKabkota()->render(
            'kab_kota',
            [
                'class'=>'form-control select2 select2_tag_add_new',
                
            ]
        );      

        $this->view->setVar("data",(object)$data);
	}

    public function editAction($id=false) 
	{ 
		if($id!=false) {
			$row=RefSekolah::findFirstById($id);
            $old=$row;
			if($row) {
				if($this->request->isPost()) {
                    $row->sekolah = $this->request->getpost('sekolah');
                    $row->kab_kota = $this->request->getpost('kab_kota');
                    $row->map_lat = $this->request->getpost('map_lat');
                    $row->map_lng = $this->request->getpost('map_lng');
                    $row->alamat = $this->request->getpost('alamat');
                    $row->no_telp = $this->request->getpost('no_telp');
                    $row->updated_at = date('Y-m-d H:i:s');
                    $row->updated_by = $this->session->get('auth')->username;
                    $row->save();                

                    $this->flashSession->success("Data Sekolah berhasil diubah."); 
                    $this->response->redirect("/refsekolah");
				}

				$data['row']=$row;
				
                $data['dropdown_kabkota']=$this->dropdownKabkota($row->kab_kota)->render(
                    'kab_kota',
                    [
                        'class'=>'form-control select2 select2_tag_add_new',
                        
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

    public function readAction($id=false) 
	{ 
		if($id!=false) {
			$row=testonline::findFirstById($id);
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