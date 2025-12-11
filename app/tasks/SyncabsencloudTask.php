<?php

class SyncabsencloudTask extends \Phalcon\Cli\Task
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
        $absen = AbsensiSiswa::findFirst([
            'conditions' => 'snapped_at is not null and sync_at is null',
            'order' => 'start_time asc',
        ]);

        $_absensiswa = [];
        
        if ($absen) {
            $siswa = Siswa::findFirstByFrId($absen->matched_face_id);
            $snapped_image = AbsensiSiswaSnapped::findFirstByUuid($absen->uuid);

            if ($snapped_image) {
                $uuid_siswa=$siswa->nisn.'_'.$siswa->nik.'_'.$siswa->sekolah;
                
                $_absensiswa['uuid'] = $absen->uuid 
                    . '_' 
                    . $absen->tgl_absen 
                    . '_' 
                    . $absen->sekolah;
                    
                $_absensiswa['uuid_siswa'] = $uuid_siswa;
                $_absensiswa['sekolah'] = $siswa->sekolah;
                $_absensiswa['start_time'] = $absen->start_time;
                $_absensiswa['jenis_absensi'] = $absen->jenis_absensi;
                $_absensiswa['siswa_nama'] = $siswa->nama_lengkap;
                $_absensiswa['siswa_tingkat'] = $siswa->tingkat;
                $_absensiswa['siswa_rombel'] = $siswa->rombel;
                $_absensiswa['siswa_nisn'] = $siswa->nisn;
                $_absensiswa['siswa_nik'] = $siswa->nik;
                $_absensiswa['tgl_absen'] = $absen->tgl_absen;
                $_absensiswa['jam_absen'] = $absen->jam_absen;
                $_absensiswa['status_absen'] = $absen->status_absen;
                $_absensiswa['absen_delay'] = $absen->absen_delay;
                $_absensiswa['foto_absen64'] = $snapped_image->image_64;

                $curl = curl_init();
                
                curl_setopt_array($curl, array(
                CURLOPT_URL => 'https://api.disdiksulsel.id/sync-absen-siswa',
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYHOST => false,
                CURLOPT_SSL_VERIFYPEER => false,
                CURLOPT_ENCODING => '',
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 0,
                CURLOPT_FOLLOWLOCATION => true,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => 'POST',
                CURLOPT_POSTFIELDS => json_encode($_absensiswa),
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
                    $u_absen = AbsensiSiswa::findFirstByUuid($absen->uuid);
                    $u_absen->sync_at = date('Y-m-d H:i:s');
                    $u_absen->save();

                    $u_snapped = AbsensiSiswaSnapped::findFirstByUuid($absen->uuid);
                    $u_snapped->sync_at = date('Y-m-d H:i:s');
                    $u_snapped->save();
                }
                else {

                }

                // $update_absen = AbsensiSiswa::findFirstByUuid($siswa->uuid);
                // $update_absen->snapped_at = date('Y-m-d H:i:s');
                // $update_absen->save();
                
                $response .= '__'.$error_msg.'__'.$resp;
            }
            
            $response .= $resp;          
        }
        
        $this->writeLog("task_syncabsencloud_".date('Ymd'), $response);        
    }
}