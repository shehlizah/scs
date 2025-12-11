<?php

class SnappedfaceTask extends \Phalcon\Cli\Task
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
                    // 'conditions' => 'tgl_absen = :tgl_absen: and snapped_at IS NULL',
                    'conditions' => 'snapped_at IS NULL',
                    // 'bind' => ['tgl_absen' => date('Y-m-d')],
                    'order' => 'start_time asc',
                ]);

                if ($absen) {
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
                            "UUIds":["'.$absen->uuid.'"]           
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
                    
                    $response .= $resp;          
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
        
            $response .= $resp;
        }
        
        $this->writeLog("task_snappedface_".date('Ymd'), $response);        
    }
}