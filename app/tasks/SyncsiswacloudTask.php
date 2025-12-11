<?php

class SyncsiswacloudTask extends \Phalcon\Cli\Task
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
        $response = '';

        $siswa = Siswa::findFirst([
            'conditions' => 'fr_id IS NOT NULL AND sync_at IS NULL',
            'order' => 'id asc',
        ]);

        if ($siswa) { 
            $id=$siswa->nisn.'_'.$siswa->nik.'_'.$siswa->sekolah;
            $_siswa = [];
            $_siswa['id'] = $id;
            $_siswa['provinsi'] = $siswa->provinsi;
            $_siswa['kabkota'] = $siswa->kabkota;
            $_siswa['sekolah'] = $siswa->sekolah;
            $_siswa['nama_lengkap'] = $siswa->nama_lengkap;
            $_siswa['tgl_lahir'] = $siswa->tgl_lahir;
            $_siswa['nama_ibu_kandung'] = $siswa->nama_ibu_kandung;
            $_siswa['nik'] = $siswa->nik;
            $_siswa['nisn'] = $siswa->nisn;
            $_siswa['tingkat'] = $siswa->tingkat;
            $_siswa['rombel'] = $siswa->rombel;
            $_siswa['fr_id'] = $siswa->fr_id;
            $_siswa['fr_enroll_at'] = $siswa->fr_enroll_at;
            $_siswa['image_path'] = $siswa->image_path;
            $_siswa['nomor_orangtua'] = $siswa->nomor_orangtua;
            $_siswa['foto_base64'] = base64_encode(file_get_contents('/application/public/scs/public/'.$siswa->image_path));

            $response .= json_encode($_siswa);

            $curl = curl_init();
            
            curl_setopt_array($curl, array(
              CURLOPT_URL => 'https://api-scs.disdiksulsel.id/sync-data-siswa',
              CURLOPT_RETURNTRANSFER => true,
              CURLOPT_SSL_VERIFYHOST => false,
              CURLOPT_SSL_VERIFYPEER => false,
              CURLOPT_ENCODING => '',
              CURLOPT_MAXREDIRS => 10,
              CURLOPT_TIMEOUT => 0,
              CURLOPT_FOLLOWLOCATION => true,
              CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
              CURLOPT_CUSTOMREQUEST => 'POST',
              CURLOPT_POSTFIELDS => json_encode($_siswa),
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
                $update_siswa = Siswa::findFirstById($siswa->id);
                $update_siswa->sync_at = date('Y-m-d H:i:s');
                $update_siswa->save();
            }
            else {

            }

            // $update_absen = AbsensiSiswa::findFirstByUuid($siswa->uuid);
            // $update_absen->snapped_at = date('Y-m-d H:i:s');
            // $update_absen->save();
            
            $response .= '__'.$error_msg.'__'.$resp;         
        }

        // $response = date('Y-m-d H:i:s');
        $this->writeLog("task_syncsiswaloud_".date('Ymd'), $response);        
    }
}