<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Endroid\QrCode\QrCode;

class Dashboard2024Controller extends ControllerBase
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
            $data['pick_ymd'] = $pick_ymd;
            $data['title_ymd'] = $this->titlePickYmd($pick_ymd);
            // $data['rekap_scs'] = $resData;

            $pick_year = 2024;


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

            // get list rekap heartbeat
            // $rekap_scs = HeartbeatScs::find([
            //     'conditions' => 'tanggal = :tanggal: and sekolah is not null and app_version is not null',
            //     'bind' => [
            //         'tanggal' => $pick_ymd
            //     ],
            //     'order' => 'kabkota asc, sekolah asc',
            // ]);

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
                ->where("HeartbeatScs.tanggal = '$pick_ymd' and RefSekolah.tahun_kegiatan=2024 and HeartbeatScs.sekolah is not null")
                ->orderBy('RefSekolah.kab_kota asc, RefSekolah.urutan asc')
                ->getQuery();

            $rekap_scs = $q_rekap_scs->execute();
            $data['list_heartbeat'] = $rekap_scs;
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
