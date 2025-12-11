<?php

class ImportabsendatangTask extends \Phalcon\Cli\Task
{
    public function writeLog($filename, $response) {
        $log_filename = $filename.'.log';
        $dir_log = "/home/scs/webdev/scs/app/logs/";
    
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
        $date_pick = date('Y-m-d');

        $url = "https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_login')->value;
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
        curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('nvr_user1_username')->value.":".Config::findFirstByKey('nvr_user1_password')->value);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        
        curl_setopt($ch, CURLOPT_HEADERFUNCTION,
            function($curl, $header) use (&$headers)
            {
                $len = strlen($header);
                $header = explode(':', $header, 2);
                if (count($header) < 2) // ignore invalid headers
                return $len;
        
                $headers[strtolower(trim($header[0]))][] = trim($header[1]);
                
                return $len;
            }
        );
        
        $resp = curl_exec($ch);
        curl_close();
    
        if(strlen($headers['set-cookie'][0]) > 0 && strlen($headers['x-csrftoken'][0]) > 0) {
            $data=[];
            $data['cookie'] = $headers['set-cookie'][0];
            $data['xcsrftoken'] = $headers['x-csrftoken'][0];
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
                    'X-csrftoken: '.$data['xcsrftoken'],
                    'Content-Type: application/json',
                    'Cookie: session='.$session
                ]
            );

            $resp = curl_exec($ch);
            curl_close($ch);
            $response .= "nvr_api_search : $resp";
            $resp_array = json_decode($resp, true);
            
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
                    'X-csrftoken: '.$data['xcsrftoken'],
                    'Content-Type: application/json',
                    'Cookie: session='.$session
                ]
            );

            $resp = curl_exec($ch);
            curl_close($ch);
            $response .= " nvr_api_get_index : $resp";
            $resp_array = json_decode($resp, true);

            if (count($resp_array['data']['SnapedFaceInfo']) > 0) {
                $absen=[];
                $uuid=[];

                foreach ($resp_array['data']['SnapedFaceInfo'] as $k => $v) {
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

        }

        $this->writeLog("task_importabsendatang_".date('Ymd'), $response);        
    }
}