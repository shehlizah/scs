<?php

class MainTask extends \Phalcon\Cli\Task
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

    public function mainAction(array $params) 
    {
        echo "param1 : ".$params[0].", param2 : ".$params[1].", param3 : ".$params[2];
    }

    public function importabsendatangAction()
    {
        $date_pick = date('Y-m-d');

        if (strlen(Config::findFirstByKey('task_cookie')->value) > 0 && strlen(Config::findFirstByKey('task_csrftoken')->value) > 0) {
            $data=[];
            $data['cookie'] = Config::findFirstByKey('task_cookie')->value;
            $data['xcsrftoken'] = Config::findFirstByKey('task_csrftoken')->value;
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

            $log_filename='task_absen_datang_'.$date_pick.'.log';
            $_datang = json_decode($resp, true);
            $this->writeLog($log_filename, $_datang)

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
        }
        
        // echo "ga ada uy";
    }

    public function importabsenpulangAction()
    {
        echo "running importabsenpulangAction";
    }

    public function snappedfaceAction()
    {
        $response = '';

        if (strlen(Config::findFirstByKey('task_cookie')->value) > 0 && strlen(Config::findFirstByKey('task_csrftoken')->value) > 0) {
            $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_heartbeat')->value;
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_POSTFIELDS, '{"data":{"keep_alive":true}}');
        
            curl_setopt($ch, CURLOPT_HTTPHEADER,
                [
                    'X-csrftoken: '.Config::findFirstByKey('task_csrftoken')->value,
                    'Cookie: '.Config::findFirstByKey('task_cookie')->value,
                    'Content-Type: application/json'
                ]
            );
        
            $resp = curl_exec($ch);
            // $this->writeLog("task_heartbeat_".date('Ymd'), json_encode($config).'__'.$resp);
            $response .= $resp;
            curl_close();
            $_resp = json_decode($resp, true);
        
            if ($_resp['result'] != 'success') {
                $url = "https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_login')->value;
        
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
                curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('nvr_task_username')->value.":".Config::findFirstByKey('nvr_task_password')->value);
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
                    $edit=Config::findFirstByKey('task_cookie');
                    $edit->value = $headers['set-cookie'][0];
                    $edit->save();

                    $edit=Config::findFirstByKey('task_csrftoken');
                    $edit->value = $headers['x-csrftoken'][0];
                    $edit->save();
                }
                else {
                
                }
            
                // $this->writeLog("task_heartbeat_".date('Ymd'), $resp.'__'.json_encode($config));
                $response .= $resp.'__'.json_encode($config);
            }
            else {
                $hearbeat = json_encode(
                    ["message" => "hearbeat is oke"]
                );
        
                $response .= $hearbeat;
        
                $cookie=explode(";",Config::findFirstByKey('task_cookie')->value);
                $session=str_replace("session=","",$cookie[0]);
                
                $absen = AbsensiSiswa::findFirst([
                    'conditions' => 'tgl_absen = :tgl_absen: and snapped_at IS NULL',
                    'bind' => ['tgl_absen' => date('Y-m-d')],
                    'order' => 'start_time asc',
                ]);

                if ($absen) {
                    // $config=[];
                    // while ($row = $result->fetch_assoc()) {
                        // $config[$row['key']] = $row['value'];
                        $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_snapped_face_by_id')->value;
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
                                "UUIds":["'.$snapped->uuid.'"]           
                            }
                        }    
                        ');
                        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
                        curl_setopt($ch, CURLOPT_HTTPHEADER,
                            [
                                'X-csrftoken: '.Config::findFirstByKey('task_csrftoken')->value,
                                'Content-Type: application/json',
                                'Cookie: session='.$session
                            ]
                        );
                
                        $resp = curl_exec($ch);
                        curl_close($ch);
        
                        $_resp = json_decode($resp, true);
        
                        if ($_resp['data']['Result'] == 0 && $_resp['data']['ResultReason'] == 'Successful') {
                            // $sql = "SELECT absensi_siswa_snapped.uuid FROM absensi_siswa_snapped WHERE absensi_siswa_snapped.uuid = '".$row['uuid']."'";
                            // $result = $conn->query($sql);

                            $snapped_image = AbsensiSiswaSnapped::findFirstByUuid($absen->uuid);
        
                            if (!$snapped_image) {
                                // do insert
                                $insert = new AbsensiSiswaSnapped();
                                $insert->uuid = $absen->uuid;
                                $insert->matched_face_id = $absen->matched_face_id;
                                $insert->matched_md5 = $absen->matched_md5;
                                $insert->start_time = $absen->start_time;
                                $insert->cctv_channel = $absen->cctv_channel;
                                $insert->jenis_absensi = $absen->jenis_absensi;
                                $insert->image_64 = $_resp['data']['SnapedFaceInfo'][0]['FaceImage'];
                                $insert->save();
                            } 
                            else {
                                // do update
                                $update = AbsensiSiswaSnapped::findFirstByUuid($absen->uuid);
                                $update->matched_face_id = $absen->matched_face_id;
                                $update->matched_md5 = $absen->matched_md5;
                                $update->start_time = $absen->start_time;
                                $update->cctv_channel = $absen->cctv_channel;
                                $update->jenis_absensi = $absen->jenis_absensi;
                                $update->image_64 = $_resp['data']['SnapedFaceInfo'][0]['FaceImage'];
                                $update->save();
                            }
                            
                            $update_absen = AbsensiSiswa::findFirstByUuid($absen->uuid);
                            $update_absen->snapped_at = date('Y-m-d H:i:s');
                            $update_absen->save();
                        }
                        
                        // $this->writeLog("task_heartbeat_".date('Ymd'), json_encode($config).'__'.$resp);
                
                        $response .= $resp;
                    // }            
                }
            }
        }
        else {
            $url = "https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_login')->value;
        
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
            curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('nvr_task_username')->value.":".Config::findFirstByKey('nvr_task_password')->value);
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
                $edit=Config::findFirstByKey('task_cookie');
                $edit->value = $headers['set-cookie'][0];
                $edit->save();

                $edit=Config::findFirstByKey('task_csrftoken');
                $edit->value = $headers['x-csrftoken'][0];
                $edit->save();
            }
            else {
            
            }
        
            // $this->writeLog("task_heartbeat_".date('Ymd'), $resp.'__'.json_encode($config));
            $response .= $resp;
        }
        
        $this->writeLog("task_heartbeat_".date('Ymd'), $response);        
    }
}