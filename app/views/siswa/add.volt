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
                    <form
                        class="form"
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-6">
                            
                            <div class="mb-3">
                                <label for="nisn" class="form-label">NISN</label>
                                <input 
                                    type="text" 
                                    name="nisn" 
                                    id="nisn" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nama_lengkap" class="form-label">Nama Lengkap</label>
                                <input 
                                    type="text" 
                                    name="nama_lengkap" 
                                    id="nama_lengkap" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nik" class="form-label">NIK</label>
                                <input 
                                    type="text" 
                                    name="nik" 
                                    id="nik" 
                                    class="form-control" 
                                    
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Tingkat</label>
                                <input 
                                    type="text" 
                                    name="tingkat" 
                                    id="tingkat" 
                                    class="form-control" 
                                    
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="rombel" class="form-label">Rombongan Belajar (Rombel)</label>
                                <input 
                                    type="text" 
                                    name="rombel" 
                                    id="rombel" 
                                    class="form-control" 
                                    
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="tgl_lahir" class="form-label">Tanggal Lahir</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tgl_lahir" 
                                                id="tgl_lahir" 
                                                
                                                class="form-control datepicker_dmy" 
                                                >   
                                            <span class="input-group-text" id="basic-addon1">
                                                <i class="fe-calendar"></i>
                                            </span>
                                        </div>                                 
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="nomor_orangtua" class="form-label">Nomor Orang Tua</label>
                                <input 
                                    type="text" 
                                    name="nomor_orangtua" 
                                    id="nomor_orangtua" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="nama_ibu_kandung" class="form-label">Nama Ibu Kandung</label>
                                <input 
                                    type="text" 
                                    name="nama_ibu_kandung" 
                                    id="nama_ibu_kandung" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary waves-effect waves-light">Simpan Data</button>
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