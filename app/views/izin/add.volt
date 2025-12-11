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
                                <label for="nama_lengkap" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="nama_lengkap" class="form-label">Rombel</label>
                                {{data.dropdown_rombel}}
                            </div>
                            
                            <div class="mb-3">
                                <label for="nisn" class="form-label">NISN</label>
                                <select id="nisn" name="nisn" class="form-control select2 select2_tag_add_new">
                                    <option value="">Pilih NISN Siswa</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="tgl_request" class="form-label">Tanggal Izin</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tgl_request" 
                                                id="tgl_request" 
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
                                <label for="nisn" class="form-label">Keterangan</label>
                                <textarea id="keterangan" name="keterangan" class="form-control" rows="4" required></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="nama_lengkap" class="form-label">Status Izin</label>
                                {{data.dropdown_status_type}}
                            </div>

                            <div class="mb-3">
                                <label for="file_surat" class="form-label">File Surat Keterangan</label>
                                <input type="file" name="file_surat" data-plugins="dropify" data-max-file-size="5M" required  />                              
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan Data</button>
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