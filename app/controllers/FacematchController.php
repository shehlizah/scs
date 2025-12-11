<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class FacematchController extends ControllerBase
{
    protected $apiOut;

    public function indexAction($param=false)
    {
        if ($this->request->isAjax()) {
			$this->view->disable(); 
			if (method_exists(__CLASS__,$param)) {
				$this->{$param}(); 
			} 
            else { 
				throw new Exception("Method tidak tersedia"); 
			}
		} 
        else {
            $this->view->setVar("data",(object)$page);
        }        
    }

    private function all_data()
	{ 
		$builder = $this->modelsManager->createBuilder()  
			->columns('
                 id
				,uuid
				,device_id
				,created_at
				,type
				,face_id
				,gender_code
				,image_id_1
				,shot_time_1
				,image_path_1
				,image_id_2
				,shot_time_2
				,image_path_2
				,synclocal_at
				,image64
				,facematch_at
				,face_id_match
				,nis
				,image64_match
				,fm_status
				,fm_similarity
			') 
			->from('Facematch'); 
		$dataTables = new DataTable(); 
		$dataTables->fromBuilder($builder)->sendResponse();
	}    

    public function masterAction($param=false)
    {
        $out=[];
        $data=[];
		$data['cookie'] = $this->session->get('set-cookie');
		$data['xcsrftoken'] = $this->session->get('x-csrftoken');

		$cookie=explode(";",$data['cookie']);
		$session=str_replace("session=","",$cookie[0]);

        // $post_field=[
        //     'data'=>[
        //         'StartTime'=>"2023-12-18 00:00:00",
        //         'EndTime'=>"2023-12-18 23:00:00",
        //         'Count'=>10,
        //     ],
        // ];
        
        $post_field=[
            'data'=>[
                "Count"=> 1000,
                'StartTime'=>"2023-12-18 00:00:00",
                'EndTime'=>"2023-12-18 23:00:00",                
                // "SimpleInfo"=>0,
                // "SimpleImage"=> 0,
                // "WithFaceInfo"=> 0,
                // "WithBodyImage"=> 0,
                // "WithBackground"=> 0,
                // "WithFeature"=>0
            ],
        ];

        $url="https://".Config::findFirstByKey('nvr_ip')->value.'/API/AI/SnapedFaces/GetByIndex';
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post_field));
        
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
        $out['snaped_faces']=$resp;

        
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
        }         

        $q = "select distinct(rombel) as rombel from siswa order by rombel asc";
        $res = $this->db->query($q);
        $rombel = $res->fetchAll();
        $out['list_rombel']=$rombel;

        // $q_condition="face_id_match is not null";
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
            'order'=>'shot_time_1 desc'
        ];

        $siswa = Facematch::find($model);

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

    public function byidAction($id)
    {
        $data=[];
		$data['cookie'] = $this->session->get('set-cookie');
		$data['xcsrftoken'] = $this->session->get('x-csrftoken');

		$cookie=explode(";",$data['cookie']);
		$session=str_replace("session=","",$cookie[0]);

        $q = "select * from facematch where id=$id";
        $res = $this->db->query($q);

        $resData = $res->fetchAll();
        $i= (int) 1;

        $payload=[];
        foreach ($resData as $k => $v) {

            $post_field=[
                'data'=>[
                    'Engine'=>0,
                    'Similarity'=>80,
                    'FaceInfo'=>[
                        [
                            // "Image"=>base64_encode(file_get_contents($v['image_path_2']))
                            "Image"=>$v['image64']
                        ]
                    ],
                ],
            ];
    
            $url="https://".Config::findFirstByKey('nvr_ip')->value.Config::findFirstByKey('nvr_api_facematching')->value."?".date('YmdHis');
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 30);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post_field));
            
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
    
            $data['curl_respone_2']=json_decode($resp,true);
            $_response=json_decode($resp,true);
            
            if($_response['data']['MatchInfo'][0]['FaceId'] > 0) {
                $match=Siswa::findFirstByFrId($_response['data']['MatchInfo'][0]['FaceId']);
                $siswa=$match;
                $payload['facematch_result'] = $_response['data']['MatchInfo'][0]['FaceId'];
                $payload['facematch_result_similarity'] = $_response['data']['MatchInfo'][0]['Similarity'];
                
                $update=Facematch::findFirstById($v['id']);
                $fm=$update;
                $update->facematch_at=date('Y-m-d H:i:s');
                $update->image_path_2=$match->image_path;
                $update->face_id_match=$_response['data']['MatchInfo'][0]['FaceId'];
                $update->fm_similarity=$_response['data']['MatchInfo'][0]['Similarity'];
                $update->image64_match="<strong>$match->nama_lengkap</strong><br>NIS : $match->nisn<br>$match->tingkat - $match->rombel";
                $update->fm_status="Match with ".$match->name." - ".$_response['data']['MatchInfo'][0]['FaceId'];
                $update->save();

                // push data to cloud
                /*
                $curl = curl_init();

                $image_datang=base64_encode(file_get_contents($v['image_path_2']));

                $postfield=[
                    'path' => 'attendance/' . str_replace(' ','',$match->sekolah) . '/' . substr($fm->shot_time_1,0,6),
                    // 'path' => 'attendance/SMAN1GOWA/' . substr($fm->shot_time_1,0,6),
                    'img64' => $image_datang,
                    // 'filename' => preg_replace('/[[:^print:]]/', '', $match->nisn) . '_' . $fm->shot_time_1 . '.jpg',
                    'filename' =>  $siswa->id. '_' . $fm->shot_time_1 . '.jpg',
                ];

                curl_setopt_array($curl, array(
                    CURLOPT_URL => Config::findFirstByKey('scs_url')->value.Config::findFirstByKey('scs_api_syncphoto')->value,
                    CURLOPT_RETURNTRANSFER => true,
                    CURLOPT_ENCODING => '',
                    CURLOPT_MAXREDIRS => 10,
                    CURLOPT_TIMEOUT => 0,
                    CURLOPT_FOLLOWLOCATION => true,
                    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                    CURLOPT_CUSTOMREQUEST => 'POST',
                    CURLOPT_POSTFIELDS => json_encode($postfield),
                    CURLOPT_HTTPHEADER => array(
                        'Content-Type: application/json'
                    ),
                ));
                
                $response = curl_exec($curl);

                // echo $response;
                // echo "gogon";
                // exit();

                curl_close($curl);

                // sent wa by picture
                $response_file = json_decode($response, true);

                $curl = curl_init();
                curl_setopt_array($curl, array(
                    CURLOPT_URL => 'https://api.fonnte.com/send',
                    CURLOPT_RETURNTRANSFER => true,
                    CURLOPT_ENCODING => '',
                    CURLOPT_MAXREDIRS => 10,
                    CURLOPT_TIMEOUT => 0,
                    CURLOPT_FOLLOWLOCATION => true,
                    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                    CURLOPT_CUSTOMREQUEST => 'POST',
                    CURLOPT_POSTFIELDS => array(
                        'target' => $match->nomor_orangtua,
                        'message' => "*$siswa->nama_lengkap*\n" 
                                     ."$siswa->sekolah\n" 
                                     ."NISN : ".preg_replace('/[[:^print:]]/', '', $match->nisn)."\n"
                                     ."Kelas : $siswa->rombel\n"
                                     ."Tanggal : ".$this->tglindo($fm->shot_time_1)."\n"
                                     ."Jam Kedatangan : ".$this->jamindo($fm->shot_time_1)."\n", 
                        'url' => $response_file['url'], 
                        'filename' => preg_replace('/[[:^print:]]/', '', $match->nisn) . '_' . $fm->shot_time_1 . '.jpg',
                        'countryCode' => '62',
                        ),
                    CURLOPT_HTTPHEADER => array(
                        'Authorization: '.Config::findFirstByKey('wa_token')->value //change TOKEN to your actual token
                    ),
                ));
                
                $response = curl_exec($curl);
                
                curl_close($curl);
                */          


                $this->flashSession->success($resp . ' ' .$response); 
				$this->response->redirect("/facematch"); 
            } 
            else {
                $payload['facematch_result'] = $_response['data']['MatchInfo'][0]['FaceId'];
                $payload['facematch_result_similarity'] = $_response['data']['MatchInfo'][0]['Similarity'];

                $update=Facematch::findFirstById($v['id']);
                $update->facematch_at=date('Y-m-d H:i:s');
                // $update->face_id_match=$_response['data']['MatchInfo'][0]['FaceId'];
                // $update->image64_match=$match->image64;
                $update->fm_status="Not Match";
                $update->save();
                
                $this->flashSession->error($resp); 
				$this->response->redirect("/facematch");
            }

            // $payload['curl_respone_2'] = $data['curl_respone_2'];
            // $payload['output'] = $post_field;
            // $payload[$i]['uuid'] = $v['uuid'];
            // $payload[$i]['device_id'] = $v['device_id'];
          
            // $payload[$i]['image64'] = base64_encode(file_get_contents($v['image_path_2']));            
            

            // $i ++;
        }

        // $this->content=$payload;
    }

    private function tglindo($time)
    {
        $year='20'.substr($time,0,2);
        $month=substr($time,2,2);
        $day=substr($time,4,2);
        $bulan['01']='Jan';
        $bulan['02']='Feb';
        $bulan['03']='Mar';
        $bulan['04']='Apr';
        $bulan['05']='Mei';
        $bulan['06']='Jun';
        $bulan['07']='Jul';
        $bulan['08']='Ags';
        $bulan['09']='Sep';
        $bulan['10']='Okt';
        $bulan['11']='Nov';
        $bulan['12']='Des';

        return $day . ' ' . $bulan[$month] . ' ' . $year;
    }

    private function jamindo($time)
    {
        // 230929205816204

        $hour=substr($time,6,2);
        $min=substr($time,8,2);
        $sec=substr($time,10,2);

        return $hour . ':' . $min . ':' . $sec;
    }
}
