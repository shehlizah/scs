<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class RekaprekamwajahController extends ControllerBase
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
            $kabkota = 'MAKASSAR';

            if (strlen($this->request->get('kabkota')) > 0) {
                $kabkota = $this->request->get('kabkota'); 
            }

            $pick_ym = date('Y-m');
        
            if (strlen($this->request->get('pick_ym')) > 0) {
                $pick_ym = $this->request->get('pick_ym');
            }

            $pick_date = date('Y-m-d');

            if (strlen($this->request->get('pick_ym')) > 0) {
                $pick_date = $pick_ym.'-'.date('d');
            }

            $date_part = explode('-', $pick_date);
            $days=cal_days_in_month(CAL_GREGORIAN,$date_part[1],$date_part[0]);

            // progress heartbeat scs
            $q_heartbeat = $this->modelsManager->createBuilder()
                ->columns([
                     'HeartbeatScs.id'
                    ,'HeartbeatScs.tanggal'
                    ,'HeartbeatScs.total_siswa'
                    ,'HeartbeatScs.total_siswa_fr'
                    ,'HeartbeatScs.total_siswa_datang'
                    ,'HeartbeatScs.total_siswa_pulang'
                    ,'HeartbeatScs.total_guru'
                    ,'RefSekolah.sekolah'
                    ,'RefSekolah.kab_kota'
                    ,'RefSekolah.urutan'
                ])
                ->Join('RefSekolah', 'HeartbeatScs.sekolah = RefSekolah.sekolah','RefSekolah')
                ->from('HeartbeatScs')
                ->where('HeartbeatScs.sekolah is not null AND HeartbeatScs.tanggal LIKE :date_range:', ['date_range' => ''.$pick_ym.'-%'])
                ->orderBy('RefSekolah.kab_kota asc, RefSekolah.urutan asc')
                ->getQuery();

            $list_heartbeat = $q_heartbeat->execute();
            
            $idx_hearbeat_sekolah_tgl = [];
            $ar_siswa_per_sekolah = [];
            foreach ($list_heartbeat as $k=>$v) {
                $idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$v->tanggal]['total_siswa']=$v->total_siswa;
                $idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$v->tanggal]['total_siswa_fr']=$v->total_siswa_fr;
                $idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$v->tanggal]['total_siswa_datang']=$v->total_siswa_datang;
                $idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$v->tanggal]['total_siswa_pulang']=$v->total_siswa_pulang;
                $ar_siswa_per_sekolah[$v->sekolah]=$v->total_siswa;
            }

            $data['idx_hearbeat_sekolah_tgl'] = $idx_hearbeat_sekolah_tgl;
            $data['ar_siswa_per_sekolah'] = $ar_siswa_per_sekolah;

            // get all sekolah
            $q_sekolah = $this->modelsManager->createBuilder()
                ->columns([
                     'RefSekolah.sekolah'
                    ,'RefSekolah.kab_kota'
                    ,'RefSekolah.urutan'
                ])
                ->from('RefSekolah')
                ->where('RefSekolah.tahun_kegiatan=:tahun_kegiatan:', ['tahun_kegiatan' => '2023'])
                ->orderBy('RefSekolah.kab_kota asc, RefSekolah.urutan asc')
                ->getQuery();

            $list_sekolah = $q_sekolah->execute();
            $data['list_sekolah'] = $list_sekolah;

            $data['pick_date'] = $pick_date;
            $data['kabkota'] = $kabkota;

            $data['date_pick'] = $date_pick;
            $data['days'] = $days;
            $data['date_part'] = $date_part;
            $data['pick_ym_title'] = $this->titlePickYm($pick_ym);

            $data['dropdown_pickym']=$this->dropdownPeriode($pick_ym)->render(
                'pick_ym',
                [
                    'class'=>'form-select form-select-sm',
                    
                ]
            );  

            $this->view->setVar("data",(object)$data);
        }
    }

    public function dropdownPeriode($def_val=null)
	{
        $form=new Form();
		$result=[];

        $result['2024-01']=strtoupper('Januari').' 2024';
        $result['2024-02']=strtoupper('Februari').' 2024';
        $result['2024-03']=strtoupper('Maret').' 2024';
        $result['2024-04']=strtoupper('April').' 2024';
        $result['2024-05']=strtoupper('Mei').' 2024';
        $result['2024-06']=strtoupper('Juni').' 2024';
        $result['2024-07']=strtoupper('Juli').' 2024';
        $result['2024-08']=strtoupper('Agustus').' 2024';
        $result['2024-09']=strtoupper('September').' 2024';
        $result['2024-10']=strtoupper('Oktober').' 2024';
        $result['2024-11']=strtoupper('November').' 2024';
        $result['2024-12']=strtoupper('Desember').' 2024';

        
        $select = new Select("pick_ym",$result,[
            "useEmpty"  =>  true,
            'emptyText' => 'Pilih Periode',
        ]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
    }

    private function getperjalanan()
    {
        $absensi = $this->modelsManager->createBuilder()  
			->columns('
				 TaskPic.id
				,TaskPic.date_action
				,TaskPic.kabkota
				,TaskPic.sekolah
				,TaskPic.pic
				,TaskPic.foto_visit
				,RefSekolah.map_lat
				,RefSekolah.map_lng
				,RefPic.nama
				,RefPic.no_telp
			')
			->where("TaskPic.kabkota='".$this->request->get('kabkota')."'")
			->Join('RefSekolah','TaskPic.sekolah=RefSekolah.sekolah','RefSekolah')
			->Join('RefPic','TaskPic.id_pic=RefPic.id','RefPic')
			->from('TaskPic')
            ->orderBy('RefSekolah.sekolah asc')
            ->getQuery()
            ->execute();

        $map = [];
        foreach ($absensi as $k => $v) {
            $map[$v->id]['map_lat'] = $v->map_lat;
            $map[$v->id]['map_lng'] = $v->map_lng;
            $map[$v->id]['sekolah'] = $v->sekolah;
            $map[$v->id]['date_action'] = $v->date_action;
            $map[$v->id]['pic'] = $v->nama;
            $map[$v->id]['no_telp'] = $v->no_telp;
            $map[$v->id]['foto_visit'] = '';

            if (strlen($v->foto_visit) > 0) {
                $map[$v->id]['foto_visit'] = '<a href="https://api.disdiksulsel.id/'.$v->foto_visit.'" target="_blank"><img src="https://api.disdiksulsel.id/'.$v->foto_visit.'?dt='.date('YmdHis').'" width=400 border=0 ></a>';
            }
            $map[$v->id]['perjalanan']['2']['id_perjalanan_dinas'] = null;
            $map[$v->id]['perjalanan']['2']['tgl_berangkat'] = $v->date_action;
            $map[$v->id]['perjalanan']['2']['tgl_pulang'] = $v->date_action;
            $map[$v->id]['perjalanan']['2']['nama_kegiatan'] = $v->sekolah;
            $map[$v->id]['perjalanan']['2']['kode_prop'] = $v->id;
            $map[$v->id]['perjalanan']['2']['kode_kab'] = $v->id;
            $map[$v->id]['perjalanan']['2']['kode_kec'] = $v->id;
            $map[$v->id]['perjalanan']['2']['kode_desa'] = $v->id;
            $map[$v->id]['perjalanan']['2']['lokasi'] = $v->kabkota;
            $map[$v->id]['perjalanan']['2']['map_lat'] = $v->map_lat;
            $map[$v->id]['perjalanan']['2']['map_lng'] = $v->map_lng;
            $map[$v->id]['perjalanan']['2']['keterangan'] = 'test drive';
            $map[$v->id]['perjalanan']['2']['kendaraan'] = [];
            $map[$v->id]['perjalanan']['2']['tim'] = [];
            $map[$v->id]['perjalanan']['2']['vendor'] = [];
            $map[$v->id]['perjalanan']['2']['photo'] = [];
            $map[$v->id]['perjalanan']['2']['kegiatan'] = [];
        }

        echo json_encode($map);
        
        // echo '{"1171":{"map_lat":"5.548290","map_lng":"95.323753","perjalanan":{"2":{"id_perjalanan_dinas":"2","tgl_berangkat":"2018-12-13","tgl_pulang":"2018-12-14","nama_kegiatan":"KUNJUNGAN KERJA PRESIDEN Bp.Ir JOKO WIDODO KE ACEH","kode_prop":"11","kode_kab":"1171","kode_kec":"","kode_desa":"","lokasi":"KOTA BANDA ACEH, ACEH, INDONESIA","presiden":"JOKOWI","map_lat":"5.548290","map_lng":"95.323753","keterangan":"Kegiatan kunker presiden ke propinsi Aceh tanggal 13-14 Desember 2018\r\n1. Penyerahan sertifikat wakaf\r\n2. Sosialisasi dana desa tahun 2019\r\n3. Silahturahmi dengan ulama Banda Aceh\r\n4. Peresmian proyek proyek strategis di aceh","kendaraan":{"RI-1":[{"id_kendaraan_dinas":"53","id_perjalanan_dinas":"2","jenis_kendaraan":"Sweper","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Polisi","urutan":"0"},{"id_kendaraan_dinas":"54","id_perjalanan_dinas":"2","jenis_kendaraan":"Walpan","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"POM ","urutan":"0"},{"id_kendaraan_dinas":"55","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Protokol","urutan":"0"},{"id_kendaraan_dinas":"56","id_perjalanan_dinas":"2","jenis_kendaraan":"Inova Rebon ","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Sec 1","urutan":"0"},{"id_kendaraan_dinas":"57","id_perjalanan_dinas":"2","jenis_kendaraan":"Mercy S600\/Keras","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"VVIP 1","urutan":"0"},{"id_kendaraan_dinas":"58","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Rebon Captain Seat","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":" VVIP 2","urutan":"0"},{"id_kendaraan_dinas":"59","id_perjalanan_dinas":"2","jenis_kendaraan":"Inova Rebon","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":" Sec 2","urutan":"0"},{"id_kendaraan_dinas":"60","id_perjalanan_dinas":"2","jenis_kendaraan":"Fortuner VRZ","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Korlan","urutan":"0"},{"id_kendaraan_dinas":"61","id_perjalanan_dinas":"2","jenis_kendaraan":"Alphard Velfire","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Cad. VVIP ","urutan":"0"},{"id_kendaraan_dinas":"62","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Matan","urutan":"0"},{"id_kendaraan_dinas":"63","id_perjalanan_dinas":"2","jenis_kendaraan":"Hiace Commuter","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Wartawan 1","urutan":"0"},{"id_kendaraan_dinas":"64","id_perjalanan_dinas":"2","jenis_kendaraan":"Hiace Commuter","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Rombongan resmi ","urutan":"0"},{"id_kendaraan_dinas":"65","id_perjalanan_dinas":"2","jenis_kendaraan":"Hiace Comuter","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Rombongan perangkat","urutan":"0"},{"id_kendaraan_dinas":"66","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Barang VVIP 1","urutan":"0"},{"id_kendaraan_dinas":"67","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Barang VVIP 2","urutan":"0"},{"id_kendaraan_dinas":"68","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Barang VVIP 3","urutan":"0"},{"id_kendaraan_dinas":"69","id_perjalanan_dinas":"2","jenis_kendaraan":"Bus 3\/4","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Tirai","urutan":"0"},{"id_kendaraan_dinas":"70","id_perjalanan_dinas":"2","jenis_kendaraan":"Hiace Commuter","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":" Wartawan 2","urutan":"0"},{"id_kendaraan_dinas":"71","id_perjalanan_dinas":"2","jenis_kendaraan":"Hiace Commuter","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Wartawan 3","urutan":"0"},{"id_kendaraan_dinas":"72","id_perjalanan_dinas":"2","jenis_kendaraan":"Walkang","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"POM ","urutan":"0"},{"id_kendaraan_dinas":"73","id_perjalanan_dinas":"2","jenis_kendaraan":"Ambulace","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":null,"urutan":"0"},{"id_kendaraan_dinas":"74","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Teknisi ","urutan":"0"},{"id_kendaraan_dinas":"75","id_perjalanan_dinas":"2","jenis_kendaraan":"Harpal","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":null,"urutan":"0"},{"id_kendaraan_dinas":"76","id_perjalanan_dinas":"2","jenis_kendaraan":"Waltup","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-1","pengemudi":null,"no_polisi":null,"pengguna":"Polisi","urutan":"0"}],"RI-3":[{"id_kendaraan_dinas":"77","id_perjalanan_dinas":"2","jenis_kendaraan":"Sweeper","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Polisi","urutan":"0"},{"id_kendaraan_dinas":"78","id_perjalanan_dinas":"2","jenis_kendaraan":"Inova Rebon","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Protokol","urutan":"0"},{"id_kendaraan_dinas":"79","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reboen","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Sec 1","urutan":"0"},{"id_kendaraan_dinas":"80","id_perjalanan_dinas":"2","jenis_kendaraan":"Alphard","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"VVIP","urutan":"0"},{"id_kendaraan_dinas":"81","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Sec 2 ","urutan":"0"},{"id_kendaraan_dinas":"82","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Reborn","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Matan","urutan":"0"},{"id_kendaraan_dinas":"83","id_perjalanan_dinas":"2","jenis_kendaraan":"Innova Rebom","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":"Perangkat","urutan":"0"},{"id_kendaraan_dinas":"84","id_perjalanan_dinas":"2","jenis_kendaraan":"Walkang","jenis_perolehan":"INTERNAL","jenis_rangkaian":"RI-3","pengemudi":null,"no_polisi":null,"pengguna":null,"urutan":"0"}]},"tim":[{"id_tim":"4","id_perjalanan_dinas":"2","nip":"","nama":"Abdul Gani","jabatan":"Koordinator","tugas":""},{"id_tim":"5","id_perjalanan_dinas":"2","nip":"","nama":"Ade TP ","jabatan":"Petugas-Angkutan","tugas":""},{"id_tim":"6","id_perjalanan_dinas":"2","nip":"","nama":"Muslih","jabatan":"Pengemudi-Kotoran","tugas":""},{"id_tim":"7","id_perjalanan_dinas":"2","nip":"","nama":"Wiwit.","jabatan":"Pengemudi-Protokol","tugas":""},{"id_tim":"8","id_perjalanan_dinas":"2","nip":"","nama":"Dadang K","jabatan":"Pengemudi-Barang","tugas":""},{"id_tim":"9","id_perjalanan_dinas":"2","nip":"","nama":" Agus","jabatan":"Pengemudi-VVIP","tugas":""},{"id_tim":"10","id_perjalanan_dinas":"2","nip":"","nama":"Andri","jabatan":"Pengemudi-Sec II","tugas":""},{"id_tim":"11","id_perjalanan_dinas":"2","nip":"","nama":"Wajo","jabatan":"Pengemudi-Sec I","tugas":""},{"id_tim":"12","id_perjalanan_dinas":"2","nip":"","nama":"Widodo.","jabatan":"Teknisi-Ransus","tugas":""}],"vendor":[{"id_vendor":"4","nama_vendor":"ManoMarion Transport","pemilik":"Agus Kuncoro","no_telp":"(021) 4602095","alamat":"Jalan Dokter Krt. Radjiman Widyodiningrat No.151, Jatinegara, Cakung, RT.2\/RW.14, Jatinegara, Cakung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13930","id_vendor_kendaraan":"2","id_perjalanan_dinas":"2","dokumen":null,"keterangan":""},{"id_vendor":"3","nama_vendor":"Kian Rental Mobil Jakarta ","pemilik":"Supriyanto","no_telp":"0811-9284-000","alamat":"Jl. Adhi Karya No.65, RT.4\/RW.5, Kedoya Sel., Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11520","id_vendor_kendaraan":"3","id_perjalanan_dinas":"2","dokumen":null,"keterangan":""},{"id_vendor":"4","nama_vendor":"ManoMarion Transport","pemilik":"Agus Kuncoro","no_telp":"(021) 4602095","alamat":"Jalan Dokter Krt. Radjiman Widyodiningrat No.151, Jatinegara, Cakung, RT.2\/RW.14, Jatinegara, Cakung, Kota Jakarta Timur, Daerah Khusus Ibukota Jakarta 13930","id_vendor_kendaraan":"14","id_perjalanan_dinas":"2","dokumen":null,"keterangan":""},{"id_vendor":"3","nama_vendor":"Kian Rental Mobil Jakarta ","pemilik":"Supriyanto","no_telp":"0811-9284-000","alamat":"Jl. Adhi Karya No.65, RT.4\/RW.5, Kedoya Sel., Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11520","id_vendor_kendaraan":"15","id_perjalanan_dinas":"2","dokumen":null,"keterangan":""},{"id_vendor":"3","nama_vendor":"Kian Rental Mobil Jakarta ","pemilik":"Supriyanto","no_telp":"0811-9284-000","alamat":"Jl. Adhi Karya No.65, RT.4\/RW.5, Kedoya Sel., Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11520","id_vendor_kendaraan":"16","id_perjalanan_dinas":"2","dokumen":null,"keterangan":""}],"photo":[{"id_photo":"30","id_perjalanan_dinas":"2","filename":"foto-20181217103959.jpeg","keterangan":"WhatsApp Image 2018-12-17 at 06"},{"id_photo":"31","id_perjalanan_dinas":"2","filename":"foto-20181217104012.jpeg","keterangan":"WhatsApp Image 2018-12-17 at 06"},{"id_photo":"32","id_perjalanan_dinas":"2","filename":"foto-20181217104023.jpeg","keterangan":"WhatsApp Image 2018-12-17 at 06"},{"id_photo":"33","id_perjalanan_dinas":"2","filename":"foto-20181217104039.jpeg","keterangan":"WhatsApp Image 2018-12-17 at 06"}],"kegiatan":[{"id_kegiatan":"4","id_perjalanan_dinas":"2","nama_kegiatan":"Bandara SIM - Hotel Hermes","tanggal":"2018-12-13","keterangan":"Istirahat di Hotel Hermes","kode_prop":"11","kode_kab":"1108","kode_kec":"1108070","kode_desa":"1108070014","lokasi":"Bandara Internasional Sultan Iskandar Muda Aceh Besar, Jl. Bandara Sultan Iskandar Muda, Blang Bintang, Cot Mancang, Kuta Baro, Kabupaten Aceh Besar, Aceh 23373","map_lat":null,"map_lng":null,"jarak":"15.9","waktu":"25","kecepatan":"20-40 km\/jam"},{"id_kegiatan":"5","id_perjalanan_dinas":"2","nama_kegiatan":"Hotel Hermes - UNSYIAH Dayan Dawood","tanggal":"2018-12-14","keterangan":"Sosialisasi dana desa tahun 2019","kode_prop":"11","kode_kab":"1171","kode_kec":"1171041","kode_desa":"1171041009","lokasi":"Hermes Palace Hotel, Jl. T. Panglima Nyak Makam, Lambhuk, Ulee Kareng, Kota Banda Aceh, Aceh 23117","map_lat":null,"map_lng":null,"jarak":"6.5","waktu":"14","kecepatan":"20-40 km\/jam"},{"id_kegiatan":"6","id_perjalanan_dinas":"2","nama_kegiatan":"UNSYIAH Dayan Dawood - Masjid Baiturrahman","tanggal":"2018-12-14","keterangan":"Silahturahmi dengan ulama Banda Aceh","kode_prop":"11","kode_kab":"1171","kode_kec":"1171040","kode_desa":"1171040013","lokasi":"Kopelma Darussalam, Syiah Kuala, Kota Banda Aceh, Aceh 24415","map_lat":null,"map_lng":null,"jarak":"8.3","waktu":"15","kecepatan":"20-60 km\/jam"},{"id_kegiatan":"7","id_perjalanan_dinas":"2","nama_kegiatan":"Masjid Baiturrahman - RM Lem Bakri","tanggal":"2018-12-14","keterangan":"Makan Siang","kode_prop":"11","kode_kab":"1108","kode_kec":"1108042","kode_desa":"","lokasi":"Masjid Raya, Kp. Baru, Baiturrahman, Kota Banda Aceh, Aceh","map_lat":null,"map_lng":null,"jarak":"8.1","waktu":"14","kecepatan":"20-60 km\/jam"},{"id_kegiatan":"8","id_perjalanan_dinas":"2","nama_kegiatan":"Rm Lem Bakri - Gor Harapan Bangsa","tanggal":"2018-12-14","keterangan":"Penyerahan sertifikat wakaf","kode_prop":"11","kode_kab":"1171","kode_kec":"1171041","kode_desa":"1171041004","lokasi":"Jl. Prof. Ali Hasyimi, Lamteh, Ulee Kareng, Kota Banda Aceh, Aceh 23127","map_lat":null,"map_lng":null,"jarak":"11.8","waktu":"19","kecepatan":"20-60 km\/jam"},{"id_kegiatan":"9","id_perjalanan_dinas":"2","nama_kegiatan":"Gor Harapan Bangsa - Ground breaking","tanggal":"2018-12-14","keterangan":"Peresmian proyek proyek strategis di aceh","kode_prop":"11","kode_kab":"1110","kode_kec":"1110101","kode_desa":"1110101013","lokasi":"Jl. Banda Aceh, Lhok Nga, Kuta Blang, Kabupaten Bireuen, Aceh 24356","map_lat":null,"map_lng":null,"jarak":"15.5","waktu":"23","kecepatan":"20-60 km\/jam"},{"id_kegiatan":"10","id_perjalanan_dinas":"2","nama_kegiatan":"Ground breaking - Bandara SIM","tanggal":"2018-12-14","keterangan":"Menuju bandara Bandara SIM","kode_prop":"11","kode_kab":"1108","kode_kec":"1108081","kode_desa":"","lokasi":"BLANG BINTANG, KABUPATEN ACEH BESAR, ACEH, INDONESIA","map_lat":null,"map_lng":null,"jarak":"2.7","waktu":"8","kecepatan":" 20 - 40 KM\/Jam "}]}}}}';
    }

    public function titlePickYm($pick_ym)
	{
        $part = explode('-', $pick_ym);
        $bulan_indo['01'] = 'JANUARI';
        $bulan_indo['02'] = 'FEBRUARI';
        $bulan_indo['03'] = 'MARET';
        $bulan_indo['04'] = 'APRIL';
        $bulan_indo['05'] = 'MEI';
        $bulan_indo['06'] = 'JUNI';
        $bulan_indo['07'] = 'JULI';
        $bulan_indo['08'] = 'AGUSTUS';
        $bulan_indo['09'] = 'SEPTEMBER';
        $bulan_indo['10'] = 'OKTOBER';
        $bulan_indo['11'] = 'NOVEMBER';
        $bulan_indo['12'] = 'DESEMBER';
        
        return $bulan_indo[$part[1]].' '.$part[0];
    }
}