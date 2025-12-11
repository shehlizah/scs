<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class KoneksicctvController extends ControllerBase
{
    public function indexAction($param=false)
    {
        if ($this->request->get('action') == 'subscribe_datang') {
            $json_body = '
            {
                "address": "192.168.8.123",
                "port": 443,
                "timeOut": 0,
                "httpsEnable": 1,
                "metadataURL": "/api/datang",
                "digUserName": "",
                "digUserPwd": ""
            }
            ';

            $url = "https://192.168.8.2/SDCAPI/V2.0/Metadata/Subscription";
                            
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
            curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('cctv_datang_username')->value.":".Config::findFirstByKey('cctv_datang_password')->value);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'POST');
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $json_body);

            $resp = curl_exec($ch);
            curl_close();

            $_resp = json_decode($resp, true);

            $this->flashSession->success("CCTV Datang berhasil disambungkan".$resp); 
            $this->response->redirect("/koneksicctv");
        }

        $this->view->setVar("data",(object)$data);
    }
}