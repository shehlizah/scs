<?php

class SyncgurucloudTask extends \Phalcon\Cli\Task
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

        $siswa = Guru::findFirst([
            'conditions' => 'fr_id IS NOT NULL AND sync_at IS NULL',
            'order' => 'id asc',
        ]);

        if ($siswa) { 
            $id=$siswa->nik.'_'.$siswa->nuptk.'_'.$siswa->nip.'_'.$siswa->sekolah;
            $_siswa = [];
            $_siswa['id'] = $id;
            $_siswa['provinsi'] = $siswa->provinsi;
            $_siswa['kabkota'] = $siswa->kabkota;
            $_siswa['sekolah'] = $siswa->sekolah;
            $_siswa['nama_lengkap'] = $siswa->nama_lengkap;
            $_siswa['tgllahir'] = $siswa->tgllahir;
            $_siswa['tempatlahir'] = $siswa->tempatlahir;
            $_siswa['nik'] = $siswa->nik;
            $_siswa['nip'] = $siswa->nip;
            $_siswa['nuptk'] = $siswa->nuptk;
            $_siswa['statuskepegawaianid'] = $siswa->statuskepegawaianid;
            $_siswa['golonganid'] = $siswa->golonganid;
            $_siswa['jenisptkid'] = $siswa->jenisptkid;
            $_siswa['alamat'] = $siswa->alamat;
            $_siswa['telepon'] = $siswa->telepon;
            $_siswa['hp'] = $siswa->hp;
            $_siswa['email'] = $siswa->email;
            $_siswa['tglmasuk'] = $siswa->tglmasuk;
            $_siswa['no_surat_tugas'] = $siswa->no_surat_tugas;
            $_siswa['tgl_surat_tugas'] = $siswa->tgl_surat_tugas;
            $_siswa['fr_id'] = $siswa->fr_id;
            $_siswa['fr_enroll_at'] = $siswa->fr_enroll_at;
            $_siswa['image_path'] = $siswa->image_path;
            
            $_siswa['foto_base64'] = base64_encode(file_get_contents('/application/public/scs/public/'.$siswa->image_path));

            $response .= json_encode($_siswa);

            $curl = curl_init();
            
            curl_setopt_array($curl, array(
              CURLOPT_URL => 'https://api-scs.disdiksulsel.id/sync-data-guru',
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
                $update_guru = Guru::findFirstById($siswa->id);
                $update_guru->sync_at = date('Y-m-d H:i:s');
                $update_guru->save();
            }
            else {

            }
            
            $response .= '__'.$error_msg.'__'.$resp;         
        }

        $this->writeLog("task_syncguruloud_".date('Ymd'), $response);        
    }
}