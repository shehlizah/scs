<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class PlaygroundcctvController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($param=false)
    {
        if ($this->request->isPost()) {
            $data=[];
            $data['cookie'] = $this->session->get('set-cookie');
            $data['xcsrftoken'] = $this->session->get('x-csrftoken');
            $cookie=explode(";",$data['cookie']);
            $session=str_replace("session=","",$cookie[0]);

            $url = "https://".$this->request->getpost('ip_cctv').$this->request->getpost('api_cctv');

            // echo $url;
                            
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
            curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('cctv_datang_username')->value.":".Config::findFirstByKey('cctv_datang_password')->value);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $this->request->getpost('api_method'));
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $this->request->getpost('json_body'));

            $resp = curl_exec($ch);
            curl_close();

            // if(curl_errno($ch)){
            //     echo 'Curl error: ' . curl_error($ch).'<br/>';
            // }

            // echo "<pre>";
            // print_r(curl_getinfo($ch));
            // echo "</pre>";

            $_resp = json_decode($resp, true);
            // var_dump($_resp);
            // die();

            $this->flashSession->success("Response API : ".$resp); 
            $this->response->redirect("/playgroundcctv/index");           
        }

        $this->view->setVar("data",(object)$data);
    }
}