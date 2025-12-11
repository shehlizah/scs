<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class AbsenguruController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($param=false)
    {
        $out=[];
        $currentPage = $this->request->getQuery('page', 'int');
        $varPost=[];
        $bind=[];
        $data=[];

        if($this->request->isPost()){
            if($this->request->getPost('simpancapture') == 'simpan') {
                $data['cookie'] = $this->session->get('set-cookie');
                $data['xcsrftoken'] = $this->session->get('x-csrftoken');
                $cookie=explode(";",$data['cookie']);
                $session=str_replace("session=","",$cookie[0]);

                $img64=str_replace("data:image/jpeg;base64,","",$this->request->getPost('captureimage'));
                $siswa=Siswa::findFirstByNisn($this->request->getPost('id'));

                // $enroll="{
                //     "data": {
                //         "FaceInfo": [
                //         {
                //             "GrpId": 19,
                //             "Sex": 1,
                //             "Age": 33,
                //             "Image": "",
                //             "Feature": "",
                //             "FtVersion": 141188,
                //             "Name": "Rafyudhi",
                //             "Country": "Indonesia",
                //             "NativePlace": "Bandung Lur",
                //             "IdCode": "",
                //             "Job": "Software",
                //             "Phone": "8888888",
                //             "Email": "abcd@163.com",
                //             "Domicile": "Bandung Slur",
                //             "Remark": "Detail of this person.....",
                //             "EnableChnAlarm": [
                //             255,
                //             255,
                //             255,
                //             255
                //             ]
                //         }]
                //     }
                // }";

                $enroll=[
                    'data'=>[
                        'FaceInfo'=>[
                            0=>[
                                "GrpId" => 8,
                                "Sex" => 1,
                                // "Age"=> 33,
                                "Image" => $img64,
                                "Feature" => "",
                                "FtVersion" => 141188,
                                "Name" => $siswa->nama_lengkap,
                                "Country" => $siswa->provinsi,
                                "NativePlace" => $siswa->kabkota,
                                "IdCode" => $siswa->tgl_lahir,
                                "Job" => "Siswa",
                                // "Phone" => $siswa->nik,
                                // "Email" => $siswa->nisn.'@sulsel.id',
                                "Domicile" => $siswa->sekolah,
                                "Remark" => "",
                                "EnableChnAlarm" => [255,255,255,255],
                            ]
                        ]
                    ]
                ];


                $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_enroll')->value."?".date('YmdHis');
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($enroll));
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

                // {
                //     "data": {
                //       "Count": 1,
                //       "Result": [
                //         0
                //       ],
                //       "ResultReason": [
                //         "Successful"
                //       ],
                //       "Id": [
                //         40
                //       ],
                //       "MD5": [
                //         "E65DC85572CE558DD0E91C4608138209"
                //       ]
                //     }
                // }                

                if($_resp['data']['Count'] == 1 && $_resp['data']['ResultReason'][0] == 'Successful' && strlen($_resp['data']['Id'][0]) > 0 && strlen($_resp['data']['MD5'][0]) > 0) {
                    $upload_dir = 'memberdir/'.str_replace(" ","",$siswa->sekolah);
					if(!is_dir($upload_dir))
					{
						mkdir($upload_dir, 0755, true);
					}

                    $data = base64_decode($img64);
                    $file = $upload_dir . '/' . $siswa->nisn . '.jpg';
                    $success = file_put_contents($file, $data);

                    $e=Siswa::findFirstByNisn($this->request->getPost('id'));
                    $e->fr_enroll_at=date('Y-m-d H:i:s');
                    $e->fr_enroll=$img64;
                    $e->fr_id=$_resp['data']['Id'][0];
                    $e->fr_md5=$_resp['data']['MD5'][0];
                    $e->image_path=$file;
                    $e->save();
                    
                    $this->flashSession->success("Status Enroll NVR Berhasil : ".$resp); 
                    $this->response->redirect("/editsiswa/?skelas=".$this->request->get('skelas')."&snamasiswa=".$this->request->get('snamasiswa')."&page=".$this->request->get('page'));
                } else {
                    $this->flashSession->error("Enroll NVR ERROR, Message ".$resp); 
                    $this->response->redirect("/editsiswa/?skelas=".$this->request->get('skelas')."&snamasiswa=".$this->request->get('snamasiswa')."&page=".$this->request->get('page'));
                }
                

            }

            if($this->request->getPost('simpanfoto') == 'simpan') {
                $data['cookie'] = $this->session->get('set-cookie');
                $data['xcsrftoken'] = $this->session->get('x-csrftoken');
                $cookie=explode(";",$data['cookie']);
                $session=str_replace("session=","",$cookie[0]);

                // $img64=str_replace("data:image/jpeg;base64,","",$this->request->getPost('captureimage'));
                $siswa=Siswa::findFirstByNisn($this->request->getPost('nisn'));
                
                if ($this->request->hasFiles() == true) {
					$upload_dir = 'memberdir/'.str_replace(" ","",$siswa->sekolah);
					if(!is_dir($upload_dir)) {
						mkdir($upload_dir, 0755, true);
					}

					foreach ($this->request->getUploadedFiles() as $file) {
						$filename=$siswa->nisn . '.' .$file->getExtension();
						$upload_file=$upload_dir . '/' . $filename;
						
                        if($file->moveTo($upload_file)) {
                            $img64 = base64_encode(file_get_contents($upload_file));
                            // $enroll="{
                            //     "data": {
                            //         "FaceInfo": [
                            //         {
                            //             "GrpId": 19,
                            //             "Sex": 1,
                            //             "Age": 33,
                            //             "Image": "",
                            //             "Feature": "",
                            //             "FtVersion": 141188,
                            //             "Name": "Rafyudhi",
                            //             "Country": "Indonesia",
                            //             "NativePlace": "Bandung Lur",
                            //             "IdCode": "",
                            //             "Job": "Software",
                            //             "Phone": "8888888",
                            //             "Email": "abcd@163.com",
                            //             "Domicile": "Bandung Slur",
                            //             "Remark": "Detail of this person.....",
                            //             "EnableChnAlarm": [
                            //             255,
                            //             255,
                            //             255,
                            //             255
                            //             ]
                            //         }]
                            //     }
                            // }";

                            $enroll=[
                                'data'=>[
                                    'FaceInfo'=>[
                                        0=>[
                                            "GrpId" => 19,
                                            "Sex" => 1,
                                            // "Age"=> 33,
                                            "Image" => $img64,
                                            "Feature" => "",
                                            "FtVersion" => 141188,
                                            "Name" => $siswa->nama_lengkap,
                                            "Country" => $siswa->provinsi,
                                            "NativePlace" => $siswa->kabkota,
                                            "IdCode" => $siswa->tgl_lahir,
                                            "Job" => "Siswa",
                                            // "Phone" => $siswa->nik,
                                            // "Email" => $siswa->nisn.'@sulsel.id',
                                            "Domicile" => $siswa->sekolah,
                                            "Remark" => "",
                                            "EnableChnAlarm" => [255,255,255,255],
                                        ]
                                    ]
                                ]
                            ];


                            $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_enroll')->value."?".date('YmdHis');
                            $ch = curl_init();
                            curl_setopt($ch, CURLOPT_URL, $url);
                            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($enroll));
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

                            // {
                            //     "data": {
                            //       "Count": 1,
                            //       "Result": [
                            //         0
                            //       ],
                            //       "ResultReason": [
                            //         "Successful"
                            //       ],
                            //       "Id": [
                            //         40
                            //       ],
                            //       "MD5": [
                            //         "E65DC85572CE558DD0E91C4608138209"
                            //       ]
                            //     }
                            // }                

                            if($_resp['data']['Count'] == 1 && $_resp['data']['ResultReason'][0] == 'Successful' && strlen($_resp['data']['Id'][0]) > 0 && strlen($_resp['data']['MD5'][0]) > 0) {
                                $upload_dir = 'memberdir/'.str_replace(" ","",$siswa->sekolah);

                                $e=Siswa::findFirstByNisn($this->request->getPost('nisn'));
                                $e->fr_enroll_at=date('Y-m-d H:i:s');
                                $e->fr_enroll=$img64;
                                $e->fr_id=$_resp['data']['Id'][0];
                                $e->fr_md5=$_resp['data']['MD5'][0];
                                $e->image_path=$upload_file;
                                $e->save();
                                
                                $this->flashSession->success("Status Enroll NVR Berhasil : ".$resp); 
                                $this->response->redirect("/editsiswa/?skelas=".$this->request->get('skelas')."&snamasiswa=".$this->request->get('snamasiswa')."&page=".$this->request->get('page'));
                            } else {
                                $this->flashSession->error("Enroll NVR ERROR, Message ".$resp); 
                                $this->response->redirect("/editsiswa/?skelas=".$this->request->get('skelas')."&snamasiswa=".$this->request->get('snamasiswa')."&page=".$this->request->get('page'));
                            }                            
                        }
                    }
                }
            }
        }         

        $q = "select distinct(rombel) as rombel from siswa order by rombel asc";
        $res = $this->db->query($q);
        $rombel = $res->fetchAll();
        $out['list_rombel']=$rombel;

        $q_condition="";
        $and="";

        if(strlen($this->request->get('skelas')) > 0) {
            $q_condition.="rombel=:skelas:";
            $bind['skelas']=$this->request->get('skelas');
        }

        if(strlen($q_condition) > 0) {
            $and=" and ";
        }
        
        if(strlen($this->request->get('snamasiswa')) > 0) {
            $q_condition.=$and."(nama_lengkap like :snamasiswa: or nisn like :snamasiswa:)";
            $bind['snamasiswa']="%".$this->request->get('snamasiswa')."%";
        }
        

        $model=[
            'conditions' => $q_condition,
            'bind' => $bind,
            'order'=>'nama_lengkap asc'
        ];

        $siswa = Siswa::find($model);

        $paginator = new PaginatorModel(
            [
                'data'  => $siswa,
                'limit' => 10,
                'page'  => $currentPage,
            ]
        );

        $page = $paginator->getPaginate();

        $out['model_siswa']=$model;
        // $out['posts']=$this->request->getPost();
        
        $this->view->setVar("data",(object)$page);
        $this->view->setVar("var_post",$varPost);
        $this->view->setVar("out",(object)$out);
    }
    
}
