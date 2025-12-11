{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}
<script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
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
                    <form
                        class="form"
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}/{{data.row.id}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-6">

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="pic" class="form-label">PIC</label>
                                {{data.dropdown_pic}}
                            </div>

                            <div class="mb-3">
                                <label for="date_action" class="form-label">Tanggal Perbaikan</label>
                                <div class="input-group">
                                    <input 
                                        type="text" 
                                        name="date_action" 
                                        id="date_action" 
                                        class="form-control datepicker_dmy" 
                                        value="{{ data.row.date_action }}" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-calendar-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
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

                                <div class='video-wrapper'>
                                        <video id='video-<?php echo $data->row->id; ?>' controls></video>
                                        <script>
                                                if(Hls.isSupported()) {
                                                    var video = document.getElementById('video-<?php echo $data->row->id; ?>');
                                                    var hls = new Hls();
                                                    hls.loadSource('<?php echo $data->row->uri; ?>');
                                                    hls.attachMedia(video);
                                                    hls.on(Hls.Events.MANIFEST_PARSED,function() {
                                                        video.play();
                                                    });
                                                }
                                            </script>
                                        </div>
                                </div>    

                            </div>

                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan</button>
                                <a href="/<?php echo $page->access->resources_name; ?>" class="btn btn-secondary waves-effect waves-light">Batal Simpan</a>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- end row-->
            </div> <!-- end card-body -->
        </div> <!-- end card -->
    </div><!-- end col -->
</div>
<!-- end row -->
{% endblock %}