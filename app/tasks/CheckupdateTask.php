<?php

class CheckupdateTask extends \Phalcon\Cli\Task
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
        
        // unzip -o <filepath/zipfile.zip> -d <path where you want files>
        // tar -cvzf backup_intranet_20220604.tar.gz -C /jet/www/default/ .
        // # tar -cvzf ~/backup_dnpipersonal_20220604.tar.gz -C /home/dnpaipersonal/web_dev/ .
        // tar -cvzf portal_asshiddiqiyah_karawang_191029.tar.gz -C  /home/coder/asshiddiqiyah-krw.id/www-portal .
        
        $resp = shell_exec("unzip -o /home/scs/webdev/scs/public/update_scs_20240221.zip -d /home/scs/webdev/scs/app/");

        // $zip = new ZipArchive;
        // if ($zip->open('/home/scs/webdev/scs/public/update_scs_20240221.zip') === TRUE) {
        //     $zip->extractTo('/home/scs/webdev/scs/app/');
        //     $zip->close();
        //     $resp = 'ok';
        // } else {
        //     $resp = 'failed';
        // }
        $response .= $resp;          
        
        $this->writeLog("task_checkupdate_".date('Ymd'), $response);        
    }
}