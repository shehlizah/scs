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
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}/{{data.row.id}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-6">

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Sekolah</label>
                                <input 
                                    type="text" 
                                    name="sekolah" 
                                    id="sekolah" 
                                    class="form-control" 
                                    value="{{data.row.sekolah}}"
                                    disabled
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="nama_lengkap" class="form-label">Rombel</label>
                                <input 
                                    type="text" 
                                    name="rombel" 
                                    id="rombel" 
                                    class="form-control" 
                                    value="{{data.row.rombel}}"
                                    disabled
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nisn" class="form-label">NISN</label>
                                <input 
                                    type="text" 
                                    name="nisn" 
                                    id="nisn" 
                                    class="form-control" 
                                    value="{{data.row.nisn}}"
                                    disabled
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="nisn" class="form-label">Nama Siswa</label>
                                <input 
                                    type="text" 
                                    name="nama_siswa" 
                                    id="nama_siswa" 
                                    class="form-control" 
                                    value="{{data.row.nama_siswa}}"
                                    disabled
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="tgl_request" class="form-label">Tanggal Pengajuan</label>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="tgl_request" 
                                                id="tgl_request" 
                                                value="{{data.row.tgl_request}}"
                                                disabled
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
                                <label for="nisn" class="form-label">Jenis Izin</label>
                                <input 
                                    type="text" 
                                    name="nama_siswa" 
                                    id="nama_siswa" 
                                    class="form-control" 
                                    value="{{data.row.request_type}}"
                                    disabled
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="nisn" class="form-label">Keterangan</label>
                                <textarea id="keterangan" name="keterangan" class="form-control" disabled rows="4" required>{{data.row.keterangan}}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="nisn" class="form-label">Status Pengajuan</label>
                                <input 
                                    type="text" 
                                    name="nama_siswa" 
                                    id="nama_siswa" 
                                    class="form-control" 
                                    value="{{data.row.status_type}}"
                                    disabled
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="file_surat" class="form-label">Surat Keterangan</label>
                                {{data.file_surat}}
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <?php
                            if ($data->row->status_type == 'BELUM DISETUJUI') {
                                ?>
                                <div class="mb-3">
                                    <button type="submit" class="btn btn-success waves-effect waves-light">SETUJUI</button>
                                    <a href="/<?php echo $page->access->resources_name; ?>" class="btn btn-danger waves-effect waves-light">ABAIKAN</a>
                                </div>                                
                                <?php
                            }
                            else {
                                ?>
                                <div class="mb-3">
                                    <a href="/<?php echo $page->access->resources_name; ?>" class="btn btn-info waves-effect waves-light">KEMBALI</a>
                                </div>
                                <?php
                            }
                            ?>

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