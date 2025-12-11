<?php
use Phalcon\Mvc\Controller;
class ApiController extends Controller
{
    protected $content;

    public function beforeExecuteRoute()
    {
        $this->view->disable();
    }
    
    public function indexAction()
    {
        
        
        $this->content=[
            'smc'=>date('YmdHis'),
            'response_facematch'=>$_response,
            'xcsrftoken'=>$this->session->get('x-csrftoken'),
            'nvr_cookie'=>$this->session->get('set-cookie'),
        ];

        // Executed after every found action
        $log_filename='api_'.date('Ymd').'.log';

        if(!file_exists("../app/logs/$log_filename")):
            fopen("../app/logs/$log_filename", "w");
        endif;
        
        $myfile = fopen("../app/logs/$log_filename", "a") or die("Unable to open file!");
        $txt ="catch at: ".date('Y-m-d H:i:s')."\n";
        $txt.="uri: ".$this->router->getControllerName()."/".$this->router->getActionName()."\n";
        $txt.="ip: ".$this->request->getClientAddress()."\n";
        $txt.="get: ".json_encode($this->request->getQuery())."\n";
        $txt.="post: ".json_encode($this->request->getPost())."\n";
        $txt.="server: ".json_encode($_SERVER)."\n";
        $txt.="request: ".json_encode($_REQUEST)."\n";
        // $txt.="header: ".json_encode(getallheaders())."\n";
        // $txt.="phpinput: ".json_decode(file_get_contents('http://php://input'),true)."\n";
        
        $txt.="phpinput_decode: ".json_decode(file_get_contents("php://input"), TRUE)."\n";
        $txt.="phpinput: ".file_get_contents('php://input')."\n";

        $txt.="response: ".json_encode($this->content)."\n";
        $txt.="-----------------------------------------------------------------\n";
        fwrite($myfile, $txt);
        fclose($myfile);        
    }

    public function synckafkaAction()
    {
        $p=$this->request->getJsonRawBody();

        try {
            $conf = new \RdKafka\Conf();
            // $conf->set('metadata.broker.list', 'localhost:9092');
            // $conf->set('metadata.broker.list', 'kafka:9092');
            $conf->set('metadata.broker.list', '10.184.0.6:9094');

            $producer = new \RdKafka\Producer($conf);
            if (!$producer) {
                throw new \Exception('Kafka producer gagal dibuat.');
            }

            $topic = $producer->newTopic('absen-siswa');

            $dummyData = [
                'uuid' => date('YmdHis'),
                'nama' => 'Test Kafka',
                'timestamp' => date('Y-m-d H:i:s'),
            ];

            $topic->produce(RD_KAFKA_PARTITION_UA, 0, json_encode($dummyData));
            // $producer->flush(1000);
            $result = $producer->flush(3000);

            if ($result === RD_KAFKA_RESP_ERR_NO_ERROR) {
                echo "✅ Message sent to Kafka\n";
            } else {
                echo "❌ Failed to flush message (code: $result)\n";
            }            

            $this->content = [
                'status' => 1,
                'message' => 'Berhasil kirim ke Kafka',
                'data' => $dummyData
            ];

        } catch (\Exception $e) {
            $this->content = ['message' => 'Gagal kirim ke Kafka: ' . $e->getMessage()];
        }

        // if (class_exists('\RdKafka\Conf')) {
        //     echo 'Class RdKafka\Conf terdeteksi ✅';
        // } else {
        //     echo 'Class RdKafka\Conf TIDAK TERDETEKSI ❌';
        // }
    }    

    public function rombelbysekolahAction()
    {
        $sekolah = $this->request->get('uid_sekolah');
        $rows = SekolahRombel::find([
            'conditions' => 'sekolah = :sekolah:',
            'bind' => [
                'sekolah' => $sekolah
            ],
            'order' => 'rombel asc'
        ]);

        $i = 1;
        $result = [];
        $result[0]['uid'] = '';
        $result[0]['nama'] = 'Pilih Rombel';

        foreach ($rows as $k => $v) {
            $result[$i]['uid'] = $v->rombel;
            $result[$i]['nama'] = $v->rombel;
            $i ++;
        }

        $this->content = $result;
    }

    public function siswabysekolahbyrombelAction()
    {
        $sekolah = $this->request->get('uid_sekolah');
        $rombel = $this->request->get('uid_rombel');
        $rows = Siswa::find([
            'conditions' => 'sekolah = :sekolah: and rombel = :rombel:',
            'bind' => [
                'sekolah' => $sekolah,
                'rombel' => $rombel,
            ],
            'order' => 'nama_lengkap asc'
        ]);

        $i = 1;
        $result = [];
        $result[0]['uid'] = '';
        $result[0]['nama'] = 'Pilih Siswa';
        foreach ($rows as $k => $v) {
            $result[$i]['uid'] = $v->nisn;
            $result[$i]['nama'] = $v->nisn.' - '.$v->nama_lengkap;
            $i ++;
        }

        $this->content = $result;
    }
    
    public function rombelbysekolahbytingkatAction()
    {
        $sekolah = $this->request->get('uid_sekolah');
        $tingkat = $this->request->get('uid_tingkat');
        
        $rows = SekolahRombel::find([
            'conditions' => 'sekolah = :sekolah: and tingkat = :tingkat:',
            'bind' => [
                'sekolah' => $sekolah,
                'tingkat' => $tingkat,
            ],
            'order' => 'rombel asc'
        ]);

        $i = 1;
        $result = [];
        $result[0]['uid'] = '';
        $result[0]['nama'] = 'Pilih Rombel';
        foreach ($rows as $k => $v) {
            $result[$i]['uid'] = $v->rombel;
            $result[$i]['nama'] = $v->rombel;
            $i ++;
        }

        $this->content = $result;
    }

    public function datangAction()
    {
        // $data=[];
        // $data['cookie'] = $this->session->get('set-cookie');
        // $data['xcsrftoken'] = $this->session->get('x-csrftoken');
        // $this->content=$_REQUEST;
        $varNvr=json_decode(file_get_contents("php://input"), TRUE);

        $upload_dir = 'absensi/SMKN3MAKASSAR/datang/'.date('Y').'/'.date('m').'/'.date('d');
        if(!is_dir($upload_dir))
        {
            mkdir($upload_dir, 0755, true);
        }

        $row=new Facematch();        
            $row->id = $v['id'];
            $row->uuid = $v['uuid'];
            $row->type = 'datang';
            $row->device_id = $varNvr['metadataObject']['common']['deviceID'];
            $row->created_at = date('Y-m-d H:i:s');
            $row->gender_code = $varNvr['metadataObject']['targetList'][0]['genderCode'];
            $row->shot_time_1 = $varNvr['metadataObject']['targetList'][0]['subImageList'][0]['shotTime'];
            // $row->shot_time_2 = $varNvr['metadataObject']['targetList'][0]['subImageList'][1]['shotTime'];
            // $row->face_id = $varNvr['metadataObject']['targetList'][0]['faceID'];
            // $row->image_id_1 = $v['image_id_1'];
            // $row->image_path_1 = $v['image_path_1'];
            // $row->image_id_2 = $v['image_id_2'];
            $row->image64 = $varNvr['metadataObject']['targetList'][0]['subImageList'][0]['data'];
            
            // $fileName=$row->shot_time_2.'_'.$varNvr['metadataObject']['targetList'][0]['faceID'].'.jpeg';
            // $filePath=$upload_dir.'/'.$fileName;
            // file_put_contents($filePath, base64_decode($varNvr['metadataObject']['targetList'][0]['subImageList'][0]['data']));

            // $row->image_path_2 = $filePath;
            $row->synclocal_at = date('Y-m-d H:i:s');
            // $row->image64 = null;
        $row->save();
        
        $this->content=[
            'smc'=>date('YmdHis'),
            'response_facematch'=>$_response,
            'xcsrftoken'=>$this->session->get('x-csrftoken'),
            'nvr_cookie'=>$this->session->get('set-cookie'),
        ];

        // Executed after every found action
        $log_filename='api_nvr_datang_'.date('Ymd').'.log';

        if(!file_exists("../app/logs/$log_filename")):
            fopen("../app/logs/$log_filename", "w");
        endif;
        
        $myfile = fopen("../app/logs/$log_filename", "a") or die("Unable to open file!");
        $txt ="catch at: ".date('Y-m-d H:i:s')."\n";
        $txt.="uri: ".$this->router->getControllerName()."/".$this->router->getActionName()."\n";
        $txt.="ip: ".$this->request->getClientAddress()."\n";
        $txt.="get: ".json_encode($this->request->getQuery())."\n";
        $txt.="post: ".json_encode($this->request->getPost())."\n";
        $txt.="server: ".json_encode($_SERVER)."\n";
        $txt.="request: ".json_encode($_REQUEST)."\n";
        // $txt.="header: ".json_encode(getallheaders())."\n";
        // $txt.="phpinput: ".json_decode(file_get_contents('http://php://input'),true)."\n";
        
        $txt.="phpinput_decode: ".json_decode(file_get_contents("php://input"), TRUE)."\n";
        $txt.="phpinput: ".file_get_contents('php://input')."\n";

        $txt.="response: ".json_encode($this->content)."\n";
        $txt.="-----------------------------------------------------------------\n";
        fwrite($myfile, $txt);
        fclose($myfile);        
    }

    public function pulangAction()
    {
        // $data=[];
        // $data['cookie'] = $this->session->get('set-cookie');
        // $data['xcsrftoken'] = $this->session->get('x-csrftoken');
        // $this->content=$_REQUEST;
        $varNvr=json_decode(file_get_contents("php://input"), TRUE);

        $upload_dir = 'absensi/SMKN3MAKASSAR/pulang/'.date('Y').'/'.date('m').'/'.date('d');
        if(!is_dir($upload_dir))
        {
            mkdir($upload_dir, 0755, true);
        }

        $row=new Facematch();        
        $row->id = $v['id'];
        $row->uuid = $v['uuid'];
        $row->type = 'pulang';
        $row->device_id = $varNvr['metadataObject']['common']['deviceID'];
        $row->created_at = date('Y-m-d H:i:s');
        $row->gender_code = $varNvr['metadataObject']['targetList'][0]['genderCode'];
        $row->shot_time_1 = $varNvr['metadataObject']['targetList'][0]['subImageList'][0]['shotTime'];
        // $row->shot_time_2 = $varNvr['metadataObject']['targetList'][0]['subImageList'][1]['shotTime'];
        // $row->face_id = $varNvr['metadataObject']['targetList'][0]['faceID'];
        // $row->image_id_1 = $v['image_id_1'];
        // $row->image_path_1 = $v['image_path_1'];
        // $row->image_id_2 = $v['image_id_2'];
        $row->image64 = $varNvr['metadataObject']['targetList'][0]['subImageList'][0]['data'];
        
        // $fileName=$row->shot_time_2.'_'.$varNvr['metadataObject']['targetList'][0]['faceID'].'.jpeg';
        // $filePath=$upload_dir.'/'.$fileName;
        // file_put_contents($filePath, base64_decode($varNvr['metadataObject']['targetList'][0]['subImageList'][0]['data']));

        // $row->image_path_2 = $filePath;
        $row->synclocal_at = date('Y-m-d H:i:s');
        // $row->image64 = null;
        $row->save();
        
        $this->content=[
            'smc'=>date('YmdHis'),
            'response_facematch'=>$_response,
            'xcsrftoken'=>$this->session->get('x-csrftoken'),
            'nvr_cookie'=>$this->session->get('set-cookie'),
        ];

        // Executed after every found action
        $log_filename='api_nvr_pulang_'.date('Ymd').'.log';

        if(!file_exists("../app/logs/$log_filename")):
            fopen("../app/logs/$log_filename", "w");
        endif;
        
        $myfile = fopen("../app/logs/$log_filename", "a") or die("Unable to open file!");
        $txt ="catch at: ".date('Y-m-d H:i:s')."\n";
        $txt.="uri: ".$this->router->getControllerName()."/".$this->router->getActionName()."\n";
        $txt.="ip: ".$this->request->getClientAddress()."\n";
        $txt.="get: ".json_encode($this->request->getQuery())."\n";
        $txt.="post: ".json_encode($this->request->getPost())."\n";
        $txt.="server: ".json_encode($_SERVER)."\n";
        $txt.="request: ".json_encode($_REQUEST)."\n";
        // $txt.="header: ".json_encode(getallheaders())."\n";
        // $txt.="phpinput: ".json_decode(file_get_contents('http://php://input'),true)."\n";
        
        $txt.="phpinput_decode: ".json_decode(file_get_contents("php://input"), TRUE)."\n";
        $txt.="phpinput: ".file_get_contents('php://input')."\n";

        $txt.="response: ".json_encode($this->content)."\n";
        $txt.="-----------------------------------------------------------------\n";
        fwrite($myfile, $txt);
        fclose($myfile);        
    }

    public function heartbeatAction()
    {
        $data=[];
        $data['cookie'] = $this->session->get('set-cookie');
        $data['xcsrftoken'] = $this->session->get('x-csrftoken');
        
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
                'X-csrftoken: '.$this->session->get('x-csrftoken'),
                'Cookie: '.$this->session->get('set-cookie'),
                'Content-Type: application/json'
            ]
        );

        $resp = curl_exec($ch);
        curl_close();

        
        $data['output_heartbeat'] = json_decode($resp, true);
        
        // if($data['output_heartbeat']['result']=='success')
        // {
        //     $update=Config::findFirstByKey('nvr_xcsrftoken');
        //     $update->value=$this->session->get('x-csrftoken');
        //     $update->save();

        //     $update=Config::findFirstByKey('nvr_cookie');
        //     $update->value=$this->session->get('set-cookie');
        //     $update->save();
        // }

        $this->content=$data['output_heartbeat'];
    }

    public function heartbeatfacematchAction()
    {
		$cookie=explode(";",$data['cookie']);
		$session=str_replace("session=","",$cookie[0]);

        $q = "select * from facematch where facematch_at is null order by shot_time_1 desc limit 0,1";
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
                    'X-csrftoken: '.Config::findFirstByKey('xcsrftoken')->value,
                    'Content-Type: application/json',
                    'Cookie: session='.$session
                ]
            );
    
            $resp = curl_exec($ch);
            curl_close($ch);
    
            $data['curl_respone_2']=json_decode($resp,true);
            $_response=json_decode($resp,true);            

            if($_response['data']['MatchInfo'][0]['FaceId'] > 0) {
                $match=FaceEnroll::findFirstById($_response['data']['MatchInfo'][0]['FaceId']);
                $payload['facematch_result'] = $_response['data']['MatchInfo'][0]['FaceId'];
                $payload['facematch_result_similarity'] = $_response['data']['MatchInfo'][0]['Similarity'];
                
                $update=Facematch::findFirstById($v['id']);
                $update->facematch_at=date('Y-m-d H:i:s');
                $update->face_id_match=$_response['data']['MatchInfo'][0]['FaceId'];
                $update->image64_match=$match->image64;
                $update->fm_status="Match with ".$match->name." - ".$_response['data']['MatchInfo'][0]['FaceId'];
                $update->save();
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
            }

            $payload['curl_respone_2'] = $data['curl_respone_2'];
            $payload['output'] = $post_field;
            // $payload[$i]['uuid'] = $v['uuid'];
            // $payload[$i]['device_id'] = $v['device_id'];
          
            // $payload[$i]['image64'] = base64_encode(file_get_contents($v['image_path_2']));            
            
            // $update=Facematch::findFirstById($v['id']);
            // $update->synclocal_at=date('Y-m-d H:i:s');
            // $update->save();

            $i ++;
        }

        $this->content=$payload;        
    }

    public function heartbeatabsensiAction()
    {
        $data=[];
		$data['cookie'] = $this->session->get('set-cookie');
		$data['xcsrftoken'] = $this->session->get('x-csrftoken');

		$cookie=explode(";",$data['cookie']);
		$session=str_replace("session=","",$cookie[0]);

        $q = "select * from facematch where facematch_at is null order by shot_time_1 desc limit 0,1";
        $res = $this->db->query($q);

        $resData = $res->fetchAll();
        $i= (int) 1;

        $payload=[];
        foreach ($resData as $k => $v) {

            $post_field=[
                'data'=>[
                    'Engine'=>0,
                    'Similarity'=>75,
                    'FaceInfo'=>[
                        [
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
                $update->face_id_match=$_response['data']['MatchInfo'][0]['FaceId'];
                $update->fm_similarity=$_response['data']['MatchInfo'][0]['Similarity'];
                $update->image64_match=$match->image64;
                $update->fm_status="Match with ".$match->name." - ".$_response['data']['MatchInfo'][0]['FaceId'];
                $update->save();

                // push data to cloud
                $curl = curl_init();

                $postfield=[
                    'path' => 'attendance/' . str_replace(' ','',$match->sekolah) . '/' . substr($fm->shot_time_1,0,6),
                    'img64' => $v['image64'],
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
                        'target' => '085173210512',
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


                // $this->flashSession->success($resp . ' ' .$response); 
				// $this->response->redirect("/facematch?page=".$this->request->get('page')); 
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
                
                // $this->flashSession->error($resp); 
				// $this->response->redirect("/facematch?page=".$this->request->get('page'));
            }

            // $payload['curl_respone_2'] = $data['curl_respone_2'];
            // $payload['output'] = $post_field;
            // $payload[$i]['uuid'] = $v['uuid'];
            // $payload[$i]['device_id'] = $v['device_id'];
          
            // $payload[$i]['image64'] = base64_encode(file_get_contents($v['image_path_2']));            
            

            // $i ++;
        }

        $this->content=$payload;
    }
    
    public function heartbeatcekabsenAction()
    {
        $data=[];
		$data['cookie'] = $this->session->get('set-cookie');
		$data['xcsrftoken'] = $this->session->get('x-csrftoken');

		$cookie=explode(";",$data['cookie']);
		$session=str_replace("session=","",$cookie[0]);

        $q = "select * from facematch where facematch_at is null order by shot_time_1 asc limit 0,1";
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
                            "Image"=>base64_encode(file_get_contents($v['image_path_2']))
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
                $update->face_id_match=$_response['data']['MatchInfo'][0]['FaceId'];
                $update->fm_similarity=$_response['data']['MatchInfo'][0]['Similarity'];
                $update->image64_match=$match->image64;
                $update->fm_status="Match with ".$match->name." - ".$_response['data']['MatchInfo'][0]['FaceId'];
                $update->save();

                // push data to cloud
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
            }
        }
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

    public function sentwabynumberAction($no)
    {
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
        'target' => $no,
        'message' => 'test message', 
        'url' => $url, 
        'filename' => 'Foto Thariq', //optional, only works on file and audio
        'countryCode' => '62', //optional
        ),
          CURLOPT_HTTPHEADER => array(
            'Authorization: '.Config::findFirstByKey('wa_token')->value //change TOKEN to your actual token
          ),
        ));
        
        $response = curl_exec($curl);
        
        curl_close($curl);
        // echo $response;
        
        $this->content=json_decode($response, true);
    }

    public function afterExecuteRoute()
    {           
        $this->response->setContentType("application/json", "UTF-8");        
        $this->response->setJsonContent($this->content);
        $this->response->send();       
    }

    public function changepasswordAction()
    {
        if($this->request->isAjax()) {

            $users=MUsers::findFirstByusername($this->session->get('auth')->username);
            if($this->security->checkHash($this->request->getPost('password_lama'), $users->password))
            {
                $users->password=$this->security->hash($this->request->getPost('password_baru'));
                $users->updated_at=date('Y-m-d H:i:s');
                $users->updated_by=$this->session->get('auth')->username;
                $users->save();

                $this->content['status'] = (int) 1;
                $this->content['error'] = null;
                $this->content['message'] = 'Passwor Anda berhasil diupdate :)';
            }
            else
            {
                $this->content['status'] = (int) 0;
                $this->content['error'] = true;
                $this->content['message'] = 'Password Lama Anda salah';
            }
		}
    }

    public function getportsekolahAction()
    {
        $sekolah=RefSekolah::findFirstBySekolah($this->request->get('sekolah'));

        if ($sekolah) {
            $this->content=[
                'port_tunnel' => $sekolah->port_tunnel
            ];
        }
        else {
            $this->content=[
                'port_tunnel' => null
            ];
        }
        
    }

    /*
    public function generatelivecctvAction()
    {
		$q = "select * from ref_sekolah where tahun_kegiatan=2024 order by id asc";
        $res = $this->db->query($q);

        $resData = $res->fetchAll();
        $i= (int) 1;

        $payload=[];
        foreach ($resData as $k => $v) {
            $uri_sekolah = str_replace(' ','',$v['sekolah']);
            $uri_sekolah = strtolower($uri_sekolah);

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV AI 1';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv_ai_1/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.101';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();
            
            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV AI 2';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv_ai_2/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.102';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 1';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv1/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.103';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 2';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv2/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.104';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 3';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv3/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.105';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 4';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv4/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.106';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 5';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv5/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.107';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            $cctv = new CctvSekolah();
            $cctv->cctv_name = 'CCTV 6';
            $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv6/output.m3u8';
            $cctv->sekolah = $v['sekolah'];
            $cctv->rombel = null;
            $cctv->tingkat = null;
            $cctv->created_at = date('Y-m-d H:i:s');
            $cctv->created_by = 'system';
            $cctv->ip_address = '192.168.8.108';
            $cctv->publish_port = $v['port_tunnel'];
            $cctv->status_active = 'Y';
            $cctv->save();

            // $payload['curl_respone_2'] = $data['curl_respone_2'];
            // $payload['output'] = $post_field;
            // $payload[$i]['uuid'] = $v['uuid'];
            // $payload[$i]['device_id'] = $v['device_id'];
          
            // $payload[$i]['image64'] = base64_encode(file_get_contents($v['image_path_2']));            
            
            // $update=Facematch::findFirstById($v['id']);
            // $update->synclocal_at=date('Y-m-d H:i:s');
            // $update->save();

            $i ++;
        }
        $this->content=$payload;        
    }
    */

    public function generateaccountsekolahAction()
    {
		$q = "select * from ref_sekolah where tahun_kegiatan in (2023,2024) and sekolah != 'SMAN 2 SELAYAR'  order by id asc";
        $res = $this->db->query($q);

        $resData = $res->fetchAll();
        $i= (int) 1;

        $payload=[];
        foreach ($resData as $k => $v) {
            $uri_sekolah = str_replace(' ','',$v['sekolah']);
            $uri_sekolah = strtolower($uri_sekolah);

            $users=new MUsers();
                $users->username=$uri_sekolah;
                $users->fullname=$v['sekolah'];
                $users->email=$uri_sekolah.'@disdiksulsel.id';
                $users->roles='sekolah';
                $users->status=1;
                $users->no_whatsapp='08123';
                $users->create_at=date('Y-m-d h:i:s');
                $users->password=$this->security->hash('P@ssw0rd');
            $users->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV AI 1';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv_ai_1/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null; 
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.101';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();
            
            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV AI 2';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv_ai_2/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.102';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 1';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv1/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.103';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 2';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv2/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.104';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 3';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv3/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.105';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 4';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv4/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.106';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 5';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv5/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.107';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $cctv = new CctvSekolah();
            // $cctv->cctv_name = 'CCTV 6';
            // $cctv->uri = 'https://gateway.disdiksulsel.id/'.$uri_sekolah.'/cctv6/output.m3u8';
            // $cctv->sekolah = $v['sekolah'];
            // $cctv->rombel = null;
            // $cctv->tingkat = null;
            // $cctv->created_at = date('Y-m-d H:i:s');
            // $cctv->created_by = 'system';
            // $cctv->ip_address = '192.168.8.108';
            // $cctv->publish_port = $v['port_tunnel'];
            // $cctv->status_active = 'Y';
            // $cctv->save();

            // $payload['curl_respone_2'] = $data['curl_respone_2'];
            // $payload['output'] = $post_field;
            // $payload[$i]['uuid'] = $v['uuid'];
            // $payload[$i]['device_id'] = $v['device_id'];
          
            // $payload[$i]['image64'] = base64_encode(file_get_contents($v['image_path_2']));            
            
            // $update=Facematch::findFirstById($v['id']);
            // $update->synclocal_at=date('Y-m-d H:i:s');
            // $update->save();

            $i ++;
        }
        $this->content=$payload;        
    }

}