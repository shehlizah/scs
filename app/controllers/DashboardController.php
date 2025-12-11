<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Endroid\QrCode\QrCode;

class DashboardController extends ControllerBase
{
    public function indexAction($param=false)
    {
        if($this->request->isAjax()) {
            $this->view->disable();
            if(method_exists(__CLASS__,$param)) {
                $this->{$param}();
            }
            else {
                throw new Exception("Method tidak tersedia");
            }
        }
        else {

            // $loop_scs = HeartbeatScs::find([
            //     'conditions' => 'tanggal is not null',
            //     'order' => 'tanggal desc',
            // ]);

            // foreach ($loop_scs as $k => $v) {
            //     $update = HeartbeatScs::findFirstById($v->id);
            //     $sekolah = explode(' ', $v->sekolah);
            //     $update->kabkota = $sekolah[2];
            //     $update->save();
            // }
            
            // if (count($data->rekap_scs) > 0) {

            // $data['test_edit'] = date('YmdHis');
            // $data['cctv_masuk_subscribe'] = $resp;

            // hitung dashboard
            $pick_ym = date('Y-m');
            $pick_ymd = date('Y-m-d');

            if (strlen($this->request->get('pick_ymd')) > 0) {
                $pick_ym = $this->request->get('pick_ym');
                $pick_ymd = $this->request->get('pick_ymd');
            }

            $date_pick = $pick_ym.'-'.date('d');
            $date_pick = $pick_ymd;

            $date_part = explode('-', $date_pick);
            $days = cal_days_in_month(CAL_GREGORIAN,$date_part[1],$date_part[0]);
            $data_part = $date_part;

            // $alist_days = [];
            // $alist_datang = [];
            // $alist_pulang = [];

            // for ($x = 1; $x <= $days; $x++) {
            //     $day = (strlen($x) == 1) ? '0'.$x : $x;
            //     $date = $data_part[0].'-'.$data_part[1].'-'.$day;
            //     $datetime = DateTime::createFromFormat('Y-m-d', $date);

            //     $background = '';

            //     if (!in_array($datetime->format('D'),['Sat','Sun'])) {
            //         $alist_days[] = $date;
            //     }
            // }

            // foreach ($alist_days as $k => $v) {
            //     $alist_datang[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='datang'")['total'];

            //     $alist_pulang[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='pulang'")['total'];

            //     $alist_datang_ontime[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='datang' AND absensi_siswa.status_absen='normal'")['total'];

            //     $alist_datang_late[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='datang' AND absensi_siswa.status_absen='telat'")['total'];

            //     $alist_pulang_ontime[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='pulang' AND absensi_siswa.status_absen='normal'")['total'];

            //     $alist_pulang_late[] = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            //         . "WHERE absensi_siswa.tgl_absen='$v' "
            //         ."AND absensi_siswa.jenis_absensi='pulang' AND absensi_siswa.status_absen='telat'")['total'];
            // }

            $data['dropdown_pick_ym']=$this->dropdownBulanTahun($pick_ym)->render(
                'pick_ym',
                [
                    'class'=>'form-select',
                    'required'=>''
                ]
            );

            $data['date_pick'] = $date_pick;
            $data['days'] = $days;
            $data['date_part'] = $date_part;
            $data['pick_ym_title'] = $this->titlePickYm($pick_ym);
            $data['scs_identity'] = Config::findFirstByKey('scs_sekolah')->value;

            // $data['alist_days'] = $alist_days;
            // $data['alist_datang'] = $alist_datang;
            // $data['alist_pulang'] = $alist_pulang;
            // $data['alist_datang_ontime'] = $alist_datang_ontime;
            // $data['alist_datang_late'] = $alist_datang_late;
            // $data['alist_pulang_ontime'] = $alist_pulang_ontime;
            // $data['alist_pulang_late'] = $alist_pulang_late;

            // $query = "SELECT DISTINCT(sekolah) AS sekolah FROM heartbeat_scs WHERE tanggal = '$pick_ymd' ORDER BY SUBSTRING_INDEX(sekolah, ' ', 3) ASC";
            
            // $query = "SELECT heartbeat_scs.sekolah
            // FROM heartbeat_scs 
            // LEFT JOIN ref_sekolah ON heartbeat_scs.sekolah = ref_sekolah.sekolah
            // WHERE heartbeat_scs.tanggal = '$pick_ymd' and heartbeat_scs.sekolah is not null ORDER BY ref_sekolah.kab_kota ASC, ref_sekolah.urutan ASC";

            // $result=$this->db->fetchAll($query);

            // $alist_sekolah = [];
            // $alist_sekolah_rekap = [];
            // $i = 0;
            // foreach ($result as $k => $v) {
            //     $alist_sekolah[] = $v['sekolah'];
            //     $heartbeat = HeartbeatScs::findFirst([
            //         'conditions' => 'sekolah = :sekolah: and tanggal = :tanggal:',
            //         'bind' => [
            //             'sekolah' => $v['sekolah'],
            //             'tanggal' => $pick_ymd
            //         ]
            //     ]);

            //     $alist_total_siswa[] = (int) $heartbeat->total_siswa;
            //     $alist_total_siswa_fr[] = (int) $heartbeat->total_siswa_fr;
            //     $alist_total_siswa_datang[] = (int) $heartbeat->total_siswa_datang;
            //     $alist_total_siswa_datang_ontime[] = (int) $heartbeat->total_siswa_datang_ontime;
            //     $alist_total_siswa_datang_late[] = (int) $heartbeat->total_siswa_datang_late;
            //     $alist_total_siswa_pulang[] = (int) $heartbeat->total_siswa_pulang;
            //     $alist_total_siswa_pulang_ontime[] = (int) $heartbeat->total_siswa_pulang_ontime;
            //     $alist_total_siswa_pulang_late[] = (int) $heartbeat->total_siswa_pulang_late;

            //     $alist_sekolah_rekap[$i]['sekolah'] = $v['sekolah'];
            //     $alist_sekolah_rekap[$i]['total_siswa'] = (int) $heartbeat->total_siswa;
            //     $alist_sekolah_rekap[$i]['total_siswa_fr'] = (int) $heartbeat->total_siswa_fr;
            //     $alist_sekolah_rekap[$i]['total_siswa_datang'] = (int) $heartbeat->total_siswa_datang;
            //     $alist_sekolah_rekap[$i]['total_siswa_datang_ontime'] = (int) $heartbeat->total_siswa_datang_ontime;
            //     $alist_sekolah_rekap[$i]['total_siswa_datang_late'] = (int) $heartbeat->total_siswa_datang_late;
            //     $alist_sekolah_rekap[$i]['total_siswa_pulang'] = (int) $heartbeat->total_siswa_pulang;
            //     $alist_sekolah_rekap[$i]['total_siswa_pulang_ontime'] = (int) $heartbeat->total_siswa_pulang_ontime;
            //     $alist_sekolah_rekap[$i]['total_siswa_pulang_late'] = (int) $heartbeat->total_siswa_pulang_late;

            //     $i ++;    
            // }

            

            // $query_rekap = "SELECT heartbeat_scs.*
            // FROM heartbeat_scs 
            // LEFT JOIN ref_sekolah ON heartbeat_scs.sekolah = ref_sekolah.sekolah
            // WHERE heartbeat_scs.sekolah is not null AND heartbeat_scs.tanggal = '$pick_ymd' ORDER BY ref_sekolah.kab_kota ASC, ref_sekolah.urutan ASC";

            // $res = $this->db->query($query_rekap);
            // $res->setFetchMode(\Phalcon\Db::FETCH_OBJ);
            // $resData = $res->fetchAll();

            // $data['alist_sekolah'] = $alist_sekolah;
            // $data['alist_sekolah_rekap'] = $alist_sekolah_rekap;
            // $data['alist_total_siswa'] = $alist_total_siswa;
            // $data['alist_total_siswa_fr'] = $alist_total_siswa_fr;
            // $data['alist_total_siswa_datang'] = $alist_total_siswa_datang;
            // $data['alist_total_siswa_datang_ontime'] = $alist_total_siswa_datang_ontime;
            // $data['alist_total_siswa_datang_late'] = $alist_total_siswa_datang_late;
            // $data['alist_total_siswa_pulang'] = $alist_total_siswa_pulang;
            // $data['alist_total_siswa_pulang_ontime'] = $alist_total_siswa_pulang_ontime;
            // $data['alist_total_siswa_pulang_late'] = $alist_total_siswa_pulang_late;
            $data['pick_ymd'] = $pick_ymd;
            $data['title_ymd'] = $this->titlePickYmd($pick_ymd);
            // $data['rekap_scs'] = $resData;

            $pick_year = 2023;

            if (strlen($this->request->get('year')) > 0) {
                $pick_year = $this->request->get('year');
            }


            // get all sekolah
            $q_sekolah = $this->modelsManager->createBuilder()
                ->columns([
                     'RefSekolah.sekolah'
                    ,'RefSekolah.kab_kota'
                    ,'RefSekolah.urutan'
                ])
                ->from('RefSekolah')
                ->where("RefSekolah.tahun_kegiatan = $pick_year")
                ->orderBy('RefSekolah.kab_kota asc, RefSekolah.urutan asc')
                ->getQuery();


            $list_sekolah = $q_sekolah->execute();
            $data['list_sekolah'] = $list_sekolah;

            $q_rekap_scs = $this->modelsManager->createBuilder()
                ->columns([
                     'HeartbeatScs.sekolah'
                    ,'HeartbeatScs.tanggal'
                    ,'HeartbeatScs.total_siswa'
                    ,'HeartbeatScs.total_siswa_fr'
                    ,'HeartbeatScs.total_siswa_datang'
                    ,'HeartbeatScs.total_siswa_pulang'
                    ,'HeartbeatScs.total_siswa_datang_ontime'
                    ,'HeartbeatScs.total_siswa_datang_late'
                    ,'HeartbeatScs.total_siswa_pulang_ontime'
                    ,'HeartbeatScs.total_siswa_pulang_late'
                    ,'HeartbeatScs.total_guru'
                    ,'HeartbeatScs.app_version'
                    ,'RefSekolah.tahun_kegiatan'
                    ,'RefSekolah.urutan'
                ])
                ->Join('RefSekolah','HeartbeatScs.sekolah=RefSekolah.sekolah','RefSekolah')
                ->from('HeartbeatScs')
                ->where("HeartbeatScs.tanggal = '$pick_ymd' and RefSekolah.tahun_kegiatan=$pick_year and HeartbeatScs.sekolah is not null")
                ->orderBy('RefSekolah.kab_kota asc, RefSekolah.urutan asc')
                ->getQuery();

            $rekap_scs = $q_rekap_scs->execute();
            $data['list_heartbeat'] = $rekap_scs;

            $count_online_scs = (int) $this->db->fetchOne("SELECT COUNT(1) AS total " 
                        . "FROM heartbeat_scs "
                        . "JOIN ref_sekolah ON heartbeat_scs.sekolah=ref_sekolah.sekolah "
                        . "WHERE heartbeat_scs.tanggal='$pick_ymd' "
                        . "AND ref_sekolah.tahun_kegiatan=$pick_year "
                        . "AND heartbeat_scs.sekolah IS NOT NULL")['total'];

            $count_sekolah_scs = (int) $this->db->fetchOne("SELECT COUNT(1) AS total " 
                        . "FROM ref_sekolah "
                        . "WHERE ref_sekolah.tahun_kegiatan=$pick_year "
                        . "AND ref_sekolah.sekolah IS NOT NULL")['total'];
            $data['count_online_scs'] = $count_online_scs;
            $data['count_sekolah_scs'] = $count_sekolah_scs;

            $this->view->setVar("data",(object)$data);
        }

	}

	private function generateRandomString($length = 6)
	{
	    $characters = '0123456789';
	    $charactersLength = strlen($characters);
	    $randomString = '';
	    for ($i = 0; $i < $length; $i++) {
	        $randomString .= $characters[rand(0, $charactersLength - 1)];
	    }
	    return strtolower($randomString);
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

    public function titlePickYmd($pick_ymd)
	{
        $part = explode('-', $pick_ymd);
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
        
        return $part[2].' '.$bulan_indo[$part[1]].' '.$part[0];
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
}
