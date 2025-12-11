<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class ConfignvrcctvController extends ControllerBase
{
    public function indexAction($param=false)
    {
        if ($this->request->isPost()) {
            $update = Config::findFirstByKey('scs_sekolah');
            $update->value = strtoupper($this->request->getpost('scs_sekolah'));
            $update->save();
            
            $update = Config::findFirstByKey('scs_ip_server_lokal');
            $update->value = $this->request->getpost('scs_ip_server_lokal');
            $update->save();
            
            $update = Config::findFirstByKey('scs_jam_datang');
            $update->value = $this->request->getpost('scs_jam_datang');
            $update->save();
            
            $update = Config::findFirstByKey('scs_jam_pulang');
            $update->value = $this->request->getpost('scs_jam_pulang');
            $update->save();
            
            $update = Config::findFirstByKey('nvr_ip');
            $update->value = $this->request->getpost('nvr_ip');
            $update->save();
            
            $update = Config::findFirstByKey('nvr_password');
            $update->value = $this->request->getpost('nvr_password');
            $update->save();
            
            $update = Config::findFirstByKey('nvr_user1_password');
            $update->value = $this->request->getpost('nvr_user1_password');
            $update->save();
            
            $update = Config::findFirstByKey('nvr_user2_password');
            $update->value = $this->request->getpost('nvr_user2_password');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_ip');
            $update->value = $this->request->getpost('cctv_datang_ip');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_ch');
            $update->value = $this->request->getpost('cctv_datang_ch');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_username');
            $update->value = $this->request->getpost('cctv_datang_username');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_password');
            $update->value = $this->request->getpost('cctv_datang_password');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_capture_start');
            $update->value = $this->request->getpost('cctv_datang_capture_start');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_datang_capture_end');
            $update->value = $this->request->getpost('cctv_datang_capture_end');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_pulang_ip');
            $update->value = $this->request->getpost('cctv_pulang_ip');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_pulang_ch');
            $update->value = $this->request->getpost('cctv_pulang_ch');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_pulang_username');
            $update->value = $this->request->getpost('cctv_pulang_username');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_pulang_password');
            $update->value = $this->request->getpost('cctv_pulang_password');
            $update->save();

            $update = Config::findFirstByKey('cctv_pulang_capture_start');
            $update->value = $this->request->getpost('cctv_pulang_capture_start');
            $update->save();
            
            $update = Config::findFirstByKey('cctv_pulang_capture_end');
            $update->value = $this->request->getpost('cctv_pulang_capture_end');
            $update->save();            

            $this->flashSession->success("Konfigurasi berhasil diupdate."); 
            $this->response->redirect("/confignvrcctv/index");           
        }

        $this->view->setVar("data",(object)$data);
    }
}