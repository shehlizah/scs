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
                                        value="<?php echo date('Y-m-d'); ?>" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-calendar-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="image_path" class="form-label">Foto Hasil Kegiatan</label>
                                {{ data.image_path }}
                                <input type="file" name="foto_visit" required data-plugins="dropify" data-max-file-size="5M"  />                              
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