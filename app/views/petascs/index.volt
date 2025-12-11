{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}
<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box">
            <div class="page-title-right">
                <!-- 
                    <a href="/tickets/add" class="btn btn-info waves-effect waves-light"><i class="mdi mdi-plus-circle me-1"></i> Tambah Penyuluh</a>
                -->
            </div>
            <h4 class="page-title">{{page.access.access_title}}</h4>
        </div>
    </div>
</div>     
<!-- end page title --> 
<style>
#map {
    width: 100%;
    height: calc(85vh - 85px);
}    
</style>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                {{ flashSession.output() }}
                <div class="row mb-2">
                    <div class="col-sm-12">
                        <h4 class="header-title">Kabupaten/Kota</h4>
                        <form method="GET" class="row g-3">
                            <div class="col-xl-2 col-md-3">
                                <?php
                                $kabkota=$this->db->fetchAll("select * from ref_kabkota order by urutan asc"); 
                                ?>
                                <select name="list_kabkota" id="list_kabkota" class="form-select form-select-sm" data-plugin="selectpicker" data-style="btn-primary">
									<?php 
                                    foreach($kabkota as $pr){
                                        $selected = ($pr['nama_kabkota']==$data->kabkota) ? 'selected' : '';
                                        ?>
                                        <option value="<?=$pr['nama_kabkota']?>" map_lat="<?=$pr['map_lat']?>" map_lng="<?=$pr['map_lng']?>" <?php echo $selected; ?>  ><?=$pr['tipe_kabkota']?> <?=$pr['nama_kabkota']?></option>
									    <?php 
                                    } ?> 
								</select>
                            </div>
                            
                        </form>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                
                <div id="map"></div>

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                {{ flashSession.output() }}
                <div class="row mb-2">
                    <div class="col-sm-12">
                        <h4 class="header-title">CCTV Sekolah</h4>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                <style>
                    .video-container {
                        display: flex;
                        flex-wrap: wrap;
                        justify-content: space-around;
                    }
                    .video-wrapper {
                        margin: 10px;
                        flex: 1 1 45%;
                        max-width: 45%;
                    }
                    video {
                        width: 100%;
                        height: auto;
                    }
                </style>
                
                <div class="video-container">
                    <?php
                    // Array of HLS URLs
                    $hls_urls = [
                        "https://gateway.disdiksulsel.id/sman0demo/cctv_ai_1/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv_ai_1/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv_ai_2/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv1/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv2/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv3/output.m3u8",
                        "https://gateway.disdiksulsel.id/sman1bulukumba/cctv4/output.m3u8"
                    ];
            
                    // Generate video elements
                    foreach ($hls_urls as $index => $url) {
                        echo "<div class='video-wrapper'>";
                        echo "<video id='video$index' controls></video>";
                        echo "<script>
                                if(Hls.isSupported()) {
                                    var video = document.getElementById('video$index');
                                    var hls = new Hls();
                                    hls.loadSource('$url');
                                    hls.attachMedia(video);
                                    hls.on(Hls.Events.MANIFEST_PARSED,function() {
                                        video.play();
                                    });
                                }
                            </script>";
                        echo "</div>";
                    }
                    ?>
                </div>                
                

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

{% endblock %}