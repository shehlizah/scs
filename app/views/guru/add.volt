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
                                <label for="nip" class="form-label">NIP</label>
                                <input 
                                    type="text" 
                                    name="nip" 
                                    id="nip" 
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
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nuptk" class="form-label">NUPTK</label>
                                <input 
                                    type="text" 
                                    name="nuptk" 
                                    id="nuptk" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Pangkat Golongan</label>
                                {{ data.dropdown_pangkat_golongan }}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Status Kepegawaian</label>
                                {{ data.dropdown_status_kepegawaian }}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Jenis PTK</label>
                                {{ data.dropdown_jenis_ptk }}
                            </div>
                            
                            <div class="mb-3">
                                <label for="tempat_lahir" class="form-label">Tempat Lahir</label>
                                <input 
                                    type="text" 
                                    name="tempat_lahir" 
                                    id="tempat_lahir" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="tgllahir" class="form-label">Tanggal Lahir</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tgllahir" 
                                                id="tgllahir" 
                                                required
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
                                <label for="tglmasuk" class="form-label">Tanggal Masuk</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tglmasuk" 
                                                id="tglmasuk" 
                                                
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
                                <label for="tgl_surat_tugas" class="form-label">Tanggal Surat Tugas</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tgl_surat_tugas" 
                                                id="tgl_surat_tugas" 
                                                
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
                                <label for="no_surat_tugas" class="form-label">Nomor Surat Tugas</label>
                                <input 
                                    type="text" 
                                    name="no_surat_tugas" 
                                    id="no_surat_tugas" 
                                    class="form-control" 
                                    
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="alamat" class="form-label">Alamat</label>
                                <input 
                                    type="text" 
                                    name="alamat" 
                                    id="alamat" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="telepon" class="form-label">Telepon</label>
                                <input 
                                    type="text" 
                                    name="telepon" 
                                    id="telepon" 
                                    class="form-control" 
                                    
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="hp" class="form-label">Nomor Handphone</label>
                                <input 
                                    type="text" 
                                    name="hp" 
                                    id="hp" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input 
                                    type="text" 
                                    name="email" 
                                    id="email" 
                                    class="form-control" 
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