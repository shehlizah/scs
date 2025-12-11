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
                                <label for="sekolah" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="mapel" class="form-label">Mata Pelajaran</label>
                                {{data.dropdown_mapel}}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Tingkat Kelas</label>
                                {{data.dropdown_tingkat}}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Rombel</label>
                                {{data.dropdown_rombel}}
                            </div>

                            <div class="mb-3">
                                <label for="tgl_test" class="form-label">Tanggal Test</label>
                                <div class="input-group">
                                    <input 
                                        type="text" 
                                        name="tgl_test" 
                                        id="tgl_test" 
                                        class="form-control datepicker_dmy" 
                                        value="<?php echo date('Y-m-d'); ?>" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-calendar-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="jam_mulai" class="form-label">Jam Mulai</label>
                                <div class="input-group clockpicker" data-placement="top" data-align="top" data-autoclose="true">
                                    <input 
                                        type="text" 
                                        name="jam_mulai" 
                                        id="jam_mulai" 
                                        class="form-control" 
                                        value="08:00" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-clock-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="soal_bobot" class="form-label">Durasi</label>
                                {{data.dropdown_durasi}}
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan dan Pilih Soal</button>
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