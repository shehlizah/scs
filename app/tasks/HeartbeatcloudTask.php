<?php

class HeartbeatcloudTask extends \Phalcon\Cli\Task
{
    public function writeLog($filename, $response) {
        $log_filename = $filename.'.log';
        $dir_log = "/home/scs/webdev/scs/app/logs/";
        // $dir_log = "/application/public/scs/app/logs/";
    
        if (!file_exists($dir_log.$log_filename)) {
            fopen($dir_log.$log_filename, "w");
        }
    
        $myfile = fopen($dir_log.$log_filename, "a") or die("Unable to open file!");
    
        $txt ="catch at: ".date('Y-m-d H:i:s')."\n";
        $txt.="response: ".$response."\n";
        $txt.="-----------------------------------------------------------------\n";
        fwrite($myfile, $txt);
        fclose($myfile);
    }

    public function mainAction()
    {
        $v = date('Y-m-d');
        // $v = '2024-02-02';
        $_data = [];
        
        $alist_datang = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='datang'")['total'];

        $alist_pulang = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='pulang'")['total'];

        $alist_datang_ontime = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='datang' AND absensi_siswa.status_absen='normal'")['total'];

        $alist_datang_late = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='datang' AND absensi_siswa.status_absen='telat'")['total'];

        $alist_pulang_ontime = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='pulang' AND absensi_siswa.status_absen='normal'")['total'];

        $alist_pulang_late = (int) $this->db->fetchOne("SELECT COUNT(1) AS total FROM absensi_siswa "
            . "WHERE absensi_siswa.tgl_absen='$v' "
            ."AND absensi_siswa.jenis_absensi='pulang' AND absensi_siswa.status_absen='telat'")['total'];        

        $_data['sekolah'] = Config::findFirstByKey('scs_sekolah')->value;
        $_data['tanggal'] = $v;
        $_data['total_siswa'] = $this->db->fetchOne("SELECT COUNT(1) AS total FROM siswa")['total'];
        $_data['total_siswa_fr'] =  $this->db->fetchOne("SELECT COUNT(1) AS total FROM siswa WHERE fr_id IS NOT NULL")['total'];
        $_data['total_siswa_datang'] = $alist_datang;
        $_data['total_siswa_pulang'] = $alist_pulang;
        $_data['total_siswa_datang_ontime'] = $alist_datang_ontime;
        $_data['total_siswa_datang_late'] = $alist_datang_late;
        $_data['total_siswa_pulang_ontime'] = $alist_pulang_ontime;
        $_data['total_siswa_pulang_late'] = $alist_pulang_late;
        $_data['total_guru'] = $this->db->fetchOne("SELECT COUNT(1) AS total FROM guru")['total'];

        $curl = curl_init();
        
        curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://api.disdiksulsel.id/heartbeat-scs',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_ENCODING => '',
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 0,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode($_data),
        CURLOPT_HTTPHEADER => array(
            'token: afd81048-145c-4b14-85ea-d10c615cc4d0-20240109232230',
            'Content-Type: application/json'
        ),
        ));
        
        $resp = curl_exec($curl);
        
        if (curl_errno($curl)) {
            $error_msg = curl_error($curl);
        }
        
        curl_close($curl);
        
        $_resp = json_decode($resp, true);

        if ($_resp['status'] == 1) {
            $status = 'berhasil';
        }
        else {
            $status = 'gagal';
        }
        
        $response .= '__'.$error_msg.'__'.$resp.'__'.$status;
        $response .= $resp;          
        
        $this->writeLog("task_heartbeatscscloud_".date('Ymd'), $response);        
    }
}