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
                                <label for="sekolah" class="form-label">Tahun Ajaran</label>
                                {{data.dropdown_tahun_ajaran}}
                            </div>
                            
                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="rombel" class="form-label">Rombel</label>
                                {{data.dropdown_rombel}}
                            </div>

                            <div class="mb-3">
                                <label for="nisn" class="form-label">NISN</label>
                                {{data.dropdown_nisn}}
                            </div>
                            
                            <div class="mb-3">
                                <label for="file_erapor" class="form-label">File e-Rapor</label>
                                <input type="file" name="file_erapor" data-plugins="dropify" data-max-file-size="5M" required />                              
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