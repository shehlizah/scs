<?php
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
class AuthController extends Controller
{

    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        if($this->session->has('auth') && $dispatcher->getActionName() !='logout')
        {
            $this->dispatcher->forward(
                [
                    "controller" => "start",
                    "action"     => "index",
                ]
            );
        }
    }
    public function afterExecuteRoute(Dispatcher $dispatcher)
    {
        $this->assets_login();
    }

    public function indexAction()
	{
		$this->dispatcher->forward(
            [
                "controller" => "auth",
                "action"     => "login",
            ]
        );
	}

    public function loginAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $msg='';
            $username=$this->request->getPost('username');
            $password=$this->request->getPost('password');
            $status=1;
            $session=[];
            if($username !='' && $password !='')
            {
                
                $users=MUsers::findFirst(
                    [
                        "(username = :username: OR email = :email:) AND status = :status:",
                        "bind"=>
                            [
                                "username"=>$username,
                                "email"=>$username,
                                "status"=>$status
                            ]
                    ]
                );
                
                if($users)
                {
                    if($this->security->checkHash($password, $users->password))
                    {
                        $session['sekolah']=null;

                        if($users->roles == 'sekolah') {
                            $session['sekolah']=$users->fullname;
                        }
                        elseif ($users->roles == 'siswa') {
                            $siswa = Siswa::findFirstByNisn($users->username);
                            $session['sekolah']=$siswa->sekolah;
                        }
                        else {
                            $session['sekolah']=null;
                        }

                        $session['username']=$users->username;
                        $session['roles']=$users->roles;
                        $session['email']=$users->email;
                        $session['module']=null;
                        $session['module_id']=null;
                        $session['user_id']=$users->id;
                        $this->session->set('auth',(object)$session);

                        $q1="SHOW COLUMNS FROM siswa LIKE 'sync_at'";
                        $dt=$this->db->fetchAll($q1);
            
                        if (count($dt) == 0) {
                            $q1="ALTER TABLE siswa ADD sync_at datetime";
                            $dt=$this->db->query($q1);
                        }

                        //$this->flashSession->success("Login berhasil...");
                    }
                    else
                    {
                        $this->flashSession->error("username dan password salah");
                    }
                }
                else
                {
                    $this->flashSession->error("username dan password salah");
                }
            }
            else
            {
                $this->flashSession->error("username dan password tidak boleh kosong");
            }
            
            $this->response->redirect('/');
        }
        else
        {
            $this->view->setVar("data",(object)$data);
			$this->view->pick('auth/index');
        }
    }
    
    private function assets_login()
    {
        $this->myassets->formValidation();
    }

    public function logoutAction()
    {
        $this->view->disable();
        $this->session->destroy();
        $this->response->redirect('/');
    }
}
