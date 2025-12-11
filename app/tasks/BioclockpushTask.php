<?php

class BioclockpushTask extends \Phalcon\Cli\Task
{
    public function writeLog($filename, $response) {
        $log_filename = $filename.'.log';
        // $dir_log = "/home/scs/webdev/scs/app/logs/";
        $dir_log = "/application/public/scs/app/logs/";
    
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
        echo "anjing";
        $response = '';
        $var_arr = [
            "biohook" => "restart",
            "biopush" => [
                  "device" => "CN99221060279",
                  "biokey" => "KTCuOlKh/XPskyUunbWjf1U"
            ]
        ];

        $payload = json_encode($var_arr);
        $urlweb = 'https://bioclock.id/pushsdk/biohook'
        
        $ch = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => $urlweb,
            CURLOPT_RETURNTRANSFER => true,
            // CURLOPT_SSL_VERIFYHOST => false,
            // CURLOPT_SSL_VERIFYPEER => false,
            // CURLOPT_ENCODING => '',
            // CURLOPT_MAXREDIRS => 10,
            // CURLOPT_TIMEOUT => 0,
            // CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_HTTPHEADER => ['Content-Type:application/json'],
            // CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($payload),
        ));
        
        $resp = curl_exec($curl);
        
        if (curl_errno($curl)) {
            $error_msg = curl_error($curl);
        }
        
        curl_close($curl);
        
        // $response .= '__'.$error_msg.'__'.$resp;

        // echo 'anjing'

        // $this->writeLog("task_bioclockpush_".date('Ymd'), $response);        
    }
}