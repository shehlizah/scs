<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class PlaygroundnvrController extends ControllerBase
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

            $url="https://".Config::findFirstByKey('nvr_ip')->value.$this->request->getpost('api_nvr')."?".date('YmdHis');
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $this->request->getpost('json_body'));
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

            $_resp = json_decode($resp, true);

            $this->flashSession->success("Response API ".$this->request->getpost('api_nvr')." : ".$resp); 
            $this->response->redirect("/playgroundnvr/index");           
        }

        $this->view->setVar("data",(object)$data);
    }
}