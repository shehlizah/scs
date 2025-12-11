{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box">
            <div class="page-title-right">
            </div>
            <h4 class="page-title">{{page.access.access_title}}</h4>
        </div>
    </div>
</div>     
<!-- end page title -->

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    {{ flashSession.output() }}
                    <table class="table mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>Jenis</th>
                                <th>IP CCTV</th>
                                <th>IP Sinkronisasi</th>
                                <th>End Point Sinkronisasi</th>
                                <th>Status</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th scope="row">1</th>
                                <td>Datang</td>
                                <td><?php echo Config::findFirstByKey('cctv_datang_ip')->value; ?></td>
                                <?php
                                if (strlen(Config::findFirstByKey('cctv_datang_ip')->value) > 0) {
                                    $url = "https://".Config::findFirstByKey('cctv_datang_ip')->value.Config::findFirstByKey('cctv_api_cek_subscribe')->value;

                                    // echo $url;
                                                    
                                    $ch = curl_init();
                                    curl_setopt($ch, CURLOPT_URL, $url);
                                    curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
                                    curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('cctv_datang_username')->value.":".Config::findFirstByKey('cctv_datang_password')->value);
                                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                                    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
                                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                                    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                                    curl_setopt($ch, CURLOPT_POSTFIELDS, '{}');
                        
                                    $resp = curl_exec($ch);
                                    curl_close();

                                    $_resp = json_decode($resp, true);

                                    if (count($_resp) == 0) {
                                        $ip_sinkron='-';
                                        $endpoint_sinkron='-';
                                        $status='<span class="btn btn-danger waves-effect waves-light">DISCONNECTED</span>';
                                        $tombol_aksi='<a href="/koneksicctv/index?action=subscribe_datang" class="btn btn-success waves-effect waves-light">CONNECT<a>';
                                    }
                                    else {
                                        $ip_sinkron=$_resp['subscriptions'][0]['address'].':'.$_resp['subscriptions'][0]['port'];
                                        $endpoint_sinkron=$_resp['subscriptions'][0]['metadataURL'];
                                        $status='<span class="btn btn-success waves-effect waves-light">CONNECTED</span>';
                                        $tombol_aksi='';
                                    }
                                } 
                                else {
                                    $ip_sinkron='-';
                                    $endpoint_sinkron='-';
                                    $status='<span class="btn btn-error waves-effect waves-light">NOT AVAILABLE</span>';
                                    $tombol_aksi='';                                    
                                }
                                ?>
                                <td><?php echo $ip_sinkron; ?></td>
                                <td><?php echo $endpoint_sinkron; ?></td>
                                <td><?php echo $status; ?></td>
                                <td><?php echo $tombol_aksi; ?></td>
                            </tr>
                            <tr>
                                <th scope="row">1</th>
                                <td>Pulang</td>
                                <td><?php echo Config::findFirstByKey('cctv_pulang_ip')->value; ?></td>
                                <?php
                                if (strlen(Config::findFirstByKey('cctv_pulang_ip')->value) > 0) {
                                    $url = "https://".Config::findFirstByKey('cctv_pulang_ip')->value.Config::findFirstByKey('cctv_api_cek_subscribe')->value;

                                    // echo $url;
                                                    
                                    $ch = curl_init();
                                    curl_setopt($ch, CURLOPT_URL, $url);
                                    curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_DIGEST);
                                    curl_setopt($ch, CURLOPT_USERPWD, Config::findFirstByKey('cctv_pulang_username')->value.":".Config::findFirstByKey('cctv_pulang_password')->value);
                                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                                    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'GET');
                                    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
                                    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                                    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
                                    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
                                    curl_setopt($ch, CURLOPT_POSTFIELDS, '{}');
                        
                                    $resp = curl_exec($ch);
                                    curl_close();

                                    $_resp = json_decode($resp, true);

                                    if (count($_resp) == 0) {
                                        $ip_sinkron='-';
                                        $endpoint_sinkron='-';
                                        $status='<span class="btn btn-danger waves-effect waves-light">DISCONNECTED</span>';
                                        $tombol_aksi='<a href="/koneksicctv/index?action=subscribe_pulang" class="btn btn-success waves-effect waves-light">CONNECT<a>';
                                    }
                                    else {
                                        $ip_sinkron=$_resp['subscriptions'][0]['address'].':'.$_resp['subscriptions'][0]['port'];
                                        $endpoint_sinkron=$_resp['subscriptions'][0]['metadataURL'];
                                        $status='<span class="btn btn-success waves-effect waves-light">CONNECTED</span>';
                                        $tombol_aksi='';
                                    }
                                } 
                                else {
                                    $ip_sinkron='-';
                                    $endpoint_sinkron='-';
                                    $status='<span class="btn btn-error waves-effect waves-light">NOT AVAILABLE</span>';
                                    $tombol_aksi='';                                    
                                }
                                ?>
                                <td><?php echo $ip_sinkron; ?></td>
                                <td><?php echo $endpoint_sinkron; ?></td>
                                <td><?php echo $status; ?></td>
                                <td><?php echo $tombol_aksi; ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- end row-->
            </div> <!-- end card-body -->
        </div> <!-- end card -->
    </div><!-- end col -->
</div>
<!-- end row -->
{% endblock %}