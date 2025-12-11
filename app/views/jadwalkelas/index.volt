{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}

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

<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                {{ flashSession.output() }}
                <div class="row mb-2">
                    <div class="col-sm-12">
                        <a href="#" class="btn btn-info waves-effect waves-light"><i class="mdi mdi-plus-circle me-1"></i> Import Jadwal Kelas</a>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                
                <div>Jadwal Kelas menunggu import data dari Sinkronisasi Cloud, lengkapi data guru</div>

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

{% endblock %}