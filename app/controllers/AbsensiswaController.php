<?php

use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class AbsensiswaController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($date_ymd=false)
    {   
        $pick_ym = date('Y-m');
        
        if (strlen($this->request->get('pick_ym')) > 0) {
            $pick_ym = $this->request->get('pick_ym');
        }

        $date_pick = $pick_ym.'-'.date('d');

        $date_part = explode('-', $date_pick);
        $days=cal_days_in_month(CAL_GREGORIAN,$date_part[1],$date_part[0]);

        // $absensi = AbsensiSiswa::find([
        //     'conditions' => 'tgl_absen = :tgl_absen:',
        //     'bind' => [
        //         'tgl_absen' => $date_pick,
        //     ]
        // ]);
        
        $rombel = [];
        $rombel_urut = [];
        $q1="SELECT DISTINCT(rombel) AS rombel FROM siswa ORDER BY rombel ASC";
        $dt=$this->db->fetchAll($q1);
        foreach($dt as $val){
            $rombel[$val['rombel']]=$val['rombel'];
            $rombel_urut[]=$val['rombel'];
        }

        $rombel_pick = $rombel_urut[0];

        if (strlen($this->request->get('rombel')) > 0) {
            $rombel_pick = $this->request->get('rombel');
        }

        $siswa = $this->modelsManager->createBuilder()  
			->columns('
				 Siswa.nama_lengkap
				,Siswa.sex
				,Siswa.tgl_lahir
				,Siswa.nik
				,Siswa.nisn
				,Siswa.tingkat
				,Siswa.rombel
				,Siswa.image_path
			')
			->where('Siswa.rombel = :rombel_pick:')
			->from('Siswa')
            ->orderBy('Siswa.nama_lengkap ASC')
            ->getQuery()
            ->execute(['rombel_pick' => $rombel_pick]);

        $absensi = $this->modelsManager->createBuilder()  
			->columns('
				 AbsensiSiswa.uuid
				,AbsensiSiswa.sekolah
				,AbsensiSiswa.matched_face_id
				,AbsensiSiswa.start_time
				,AbsensiSiswa.tgl_absen
				,AbsensiSiswa.jam_absen
				,AbsensiSiswa.jenis_absensi
				,AbsensiSiswa.status_absen
				,AbsensiSiswa.absen_delay
				,Siswa.nama_lengkap
				,Siswa.sex
				,Siswa.tgl_lahir
				,Siswa.nik
				,Siswa.nisn
				,Siswa.tingkat
				,Siswa.rombel
				,Siswa.image_path
			')
			->where("AbsensiSiswa.jenis_absensi = :jenis_absensi: and AbsensiSiswa.tgl_absen like '$pick_ym%' ")
			->Join('Siswa','AbsensiSiswa.matched_face_id=Siswa.fr_id','Siswa')
			->from('AbsensiSiswa')
            ->orderBy('Siswa.nama_lengkap asc')
            ->getQuery()
            ->execute(['jenis_absensi' => 'datang']);

        $absen_by_nisn_tgl_absen_datang = [];
        foreach ($absensi as $k => $v) {
            $absen_by_nisn_tgl_absen_datang[$v->nisn.'_'.$v->tgl_absen] = substr($v->jam_absen, 0, 5).'_'.$v->status_absen.'_'.$v->absen_delay;
        }
        
        $data['absen_by_nisn_tgl_absen_datang'] = $absen_by_nisn_tgl_absen_datang;
        $data['date_pick'] = $date_pick;
        $data['days'] = $days;
        $data['date_part'] = $date_part;
        $data['pick_ym_title'] = $this->titlePickYm($pick_ym);

        $absensi_pulang = $this->modelsManager->createBuilder()  
			->columns('
				 AbsensiSiswa.uuid
				,AbsensiSiswa.sekolah
				,AbsensiSiswa.matched_face_id
				,AbsensiSiswa.start_time
				,AbsensiSiswa.tgl_absen
				,AbsensiSiswa.jam_absen
				,AbsensiSiswa.jenis_absensi
				,AbsensiSiswa.status_absen
				,AbsensiSiswa.absen_delay
				,Siswa.nama_lengkap
				,Siswa.sex
				,Siswa.tgl_lahir
				,Siswa.nik
				,Siswa.nisn
				,Siswa.tingkat
				,Siswa.rombel
				,Siswa.image_path
			')
			->where("AbsensiSiswa.jenis_absensi = :jenis_absensi: and AbsensiSiswa.tgl_absen like '$pick_ym%' ")
			->Join('Siswa','AbsensiSiswa.matched_face_id=Siswa.fr_id','Siswa')
			->from('AbsensiSiswa')
            ->orderBy('Siswa.nama_lengkap asc')
            ->getQuery()
            ->execute(['jenis_absensi' => 'pulang']);

        $absen_by_nisn_tgl_absen_pulang = [];
        foreach ($absensi_pulang as $k => $v) {
            $absen_by_nisn_tgl_absen_pulang[$v->nisn.'_'.$v->tgl_absen] = substr($v->jam_absen, 0, 5).'_'.$v->status_absen.'_'.$v->absen_delay;
        }
        
        $data['absen_by_nisn_tgl_absen_pulang'] = $absen_by_nisn_tgl_absen_pulang;

        if (count($absensi) > count($absensi_pulang)) {
            $data['absensi'] = $absensi;
        } 
        else {
            $data['absensi'] = $absensi_pulang;
        }

        $data['siswa'] = $siswa;
        $data['rombel_pick'] = $rombel_pick;
        $data['list_rombel'] = $rombel;

        $data['dropdown_pick_ym']=$this->dropdownBulanTahun($pick_ym)->render(
			'pick_ym',
			[
				'class'=>'form-select',
				'required'=>''
			]
		);

        $this->view->setVar("data",(object)$data);
    }

    public function dropdownBulanTahun($def_val=null)
	{
        $form = new Form();
		$result = [];
		$bulan_indo = [];

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
        
        $year = date('Y');

        for ($x = 1; $x <= 12; $x++) {
            $x = (strlen($x) == 1) ? '0'.$x : $x;
            $result[$year.'-'.$x] = $bulan_indo[$x].' '.$year;
        }
        
        $select = new Select("pick_ym",$result,["useEmpty"  =>  true,]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
		
        return $form->add($select);
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

    public function importcctvdatangAction($date_ymd=false) 
    {
        $date_pick = date('Y-m-d');
        

        if (strlen($date_ymd) > 0) {
            $date_pick = $date_ymd;
        }

        $data=[];
        $data['cookie'] = $this->session->get('set-cookie');
        $data['xcsrftoken'] = $this->session->get('x-csrftoken');
        $cookie=explode(";",$data['cookie']);
        $session=str_replace("session=","",$cookie[0]);

        $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_search')->value."?".date('YmdHis');
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POSTFIELDS, '
        {
            "data":{
                   "StartTime":"'.$date_pick.' '.Config::findFirstByKey('cctv_datang_capture_start')->value.'",
                   "EndTime":"'.$date_pick.' '.Config::findFirstByKey('cctv_datang_capture_end')->value.'",
                   "Chn":['.Config::findFirstByKey('cctv_datang_ch')->value.'],
                   "Engine":1
            }
        }        
        ');
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
        
        $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_get_index')->value."?".date('YmdHis');
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POSTFIELDS, '
        {
            "data":{
                "Engine":1,                                              
                "StartIndex":0,                                          
                "Count":5000                                  
            }
        }      
        ');
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

        $log_filename='api_absen_datang_'.$date_pick.'.log';

        if(!file_exists("../app/logs/$log_filename")):
            fopen("../app/logs/$log_filename", "w");
        endif;
        
        $myfile = fopen("../app/logs/$log_filename", "w") or die("Unable to open file!");
        $txt=$resp;
        fwrite($myfile, $txt);
        fclose($myfile);

        $_datang = json_decode($resp, true);

        if (count($_datang['data']['SnapedFaceInfo']) > 0) {
            $absen=[];
            $uuid=[];

            foreach ($_datang['data']['SnapedFaceInfo'] as $k => $v) {
                if (strlen($v['MatchedFaceId']) > 0) {
                    $absen[$v['MatchedFaceId']]=$v['StartTime'];
                    $uuid[$v['MatchedFaceId'].'_'.$v['StartTime']]=$v['UUId'];
                }
            }

            foreach ($absen as $k=>$v) {
                $start_datetime = new DateTime(date('Y-m-d').' '.Config::findFirstByKey('scs_jam_datang')->value); 
                $diff = $start_datetime->diff(new DateTime($v)); 
                $absen_delay=$diff->i;
                $hitung_telat=$diff->format("%r%i");
                
                if ($hitung_telat > 0) {
                    $status_absen = 'telat';
                }
                else {
                    $status_absen = 'normal';
                }

                $old = AbsensiSiswa::findFirstByUuid($uuid[$k.'_'.$v]);

                if ($old) {
                    $waktu_absen = explode(" ", $v);
                    $old->uuid = $uuid[$k.'_'.$v];
                    $old->matched_face_id = $k;
                    $old->start_time = $v;
                    $old->cctv_channel = 0;
                    $old->jenis_absensi = 'datang';
                    $old->tgl_absen = $waktu_absen[0];
                    $old->jam_absen = $waktu_absen[1];
                    $old->absen_delay = $absen_delay;
                    $old->status_absen = $status_absen;
                    $old->sekolah = Config::findFirstByKey('scs_sekolah')->value;
                    $old->save();
                } 
                else {
                    $waktu_absen = explode(" ", $v);
                    $new = new AbsensiSiswa();
                    $new->uuid = $uuid[$k.'_'.$v];
                    $new->matched_face_id = $k;
                    $new->start_time = $v;
                    $new->cctv_channel = 0;
                    $new->jenis_absensi = 'datang';
                    $new->tgl_absen = $waktu_absen[0];
                    $new->jam_absen = $waktu_absen[1];
                    $old->absen_delay = $absen_delay;
                    $old->status_absen = $status_absen;
                    $old->sekolah = Config::findFirstByKey('scs_sekolah')->value;
                    $new->save(); 
                }                

            }
        }

        $this->flashSession->success("Absen Datang Berhasil diinput ".json_encode($absen)."__".json_encode($uuid)); 
        $this->response->redirect("/absensiswa");
    }
    
    public function importcctvpulangAction($date_ymd=false) 
    {
        $date_pick = date('Y-m-d');

        if (strlen($date_ymd) > 0) {
            $date_pick = $date_ymd;
        }

        $data=[];
        $data['cookie'] = $this->session->get('set-cookie');
        $data['xcsrftoken'] = $this->session->get('x-csrftoken');
        $cookie=explode(";",$data['cookie']);
        $session=str_replace("session=","",$cookie[0]);

        $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_search')->value."?".date('YmdHis');
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POSTFIELDS, '
        {
            "data":{
                   "StartTime":"'.$date_pick.' '.Config::findFirstByKey('cctv_pulang_capture_start')->value.'",
                   "EndTime":"'.$date_pick.' '.Config::findFirstByKey('cctv_pulang_capture_end')->value.'",
                   "Chn":['.Config::findFirstByKey('cctv_pulang_ch')->value.'],
                   "Engine":1
            }
        }        
        ');
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
        
        $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_get_index')->value."?".date('YmdHis');
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POSTFIELDS, '
        {
            "data":{
                "Engine":1,                                              
                "StartIndex":0,                                          
                "Count":5000                                  
            }
        }      
        ');
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

        $log_filename='api_absen_pulang_'.$date_pick.'.log';

        if(!file_exists("../app/logs/$log_filename")):
            fopen("../app/logs/$log_filename", "w");
        endif;
        
        $myfile = fopen("../app/logs/$log_filename", "a") or die("Unable to open file!");
        $txt=$resp;
        fwrite($myfile, $txt);
        fclose($myfile);

        $_pulang = json_decode($resp, true);

        if (count($_pulang['data']['SnapedFaceInfo']) > 0) {
            $absen=[];
            $uuid=[];

            foreach ($_pulang['data']['SnapedFaceInfo'] as $k => $v) {
                if (strlen($v['MatchedFaceId']) > 0) {
                    $absen[$v['MatchedFaceId']]=$v['StartTime'];
                    $uuid[$v['MatchedFaceId'].'_'.$v['StartTime']]=$v['UUId'];
                }
            }

            foreach ($absen as $k=>$v) {
                $start_datetime = new DateTime(date('Y-m-d').' '.Config::findFirstByKey('scs_jam_pulang')->value); 
                $diff = $start_datetime->diff(new DateTime($v)); 
                $absen_delay=$diff->i;
                $hitung_telat=$diff->format("%r%i");
                
                if ($hitung_telat > 0) {
                    $status_absen = 'normal';
                }
                else {
                    $status_absen = 'telat';
                }

                $old = AbsensiSiswa::findFirstByUuid($uuid[$k.'_'.$v]);

                if ($old) {
                    $waktu_absen = explode(" ", $v);
                    $old->uuid = $uuid[$k.'_'.$v];
                    $old->matched_face_id = $k;
                    $old->start_time = $v;
                    $old->cctv_channel = 0;
                    $old->jenis_absensi = 'pulang';
                    $old->tgl_absen = $waktu_absen[0];
                    $old->jam_absen = $waktu_absen[1];
                    $old->absen_delay = $absen_delay;
                    $old->status_absen = $status_absen;
                    $old->sekolah = Config::findFirstByKey('scs_sekolah')->value;
                    $old->save();
                } 
                else {
                    $waktu_absen = explode(" ", $v);
                    $new = new AbsensiSiswa();
                    $new->uuid = $uuid[$k.'_'.$v];
                    $new->matched_face_id = $k;
                    $new->start_time = $v;
                    $new->cctv_channel = 0;
                    $new->jenis_absensi = 'pulang';
                    $new->tgl_absen = $waktu_absen[0];
                    $new->jam_absen = $waktu_absen[1];
                    $old->absen_delay = $absen_delay;
                    $old->status_absen = $status_absen;
                    $old->sekolah = Config::findFirstByKey('scs_sekolah')->value;
                    $new->save(); 
                }                

            }
        }        

        $this->flashSession->success("Absen Pulang Berhasil diinput"); 
        $this->response->redirect("/absensiswa");
    }
}
