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
                    <!-- <div class="col-sm-12">
                        <a href="/guru/add" class="btn btn-info waves-effect waves-light"><i class="mdi mdi-plus-circle me-1"></i> Tambah Guru</a>
                    </div> -->
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                
                <table id="dataRows" class="table nowrap w-100 table-striped">
                    <thead>
                        <tr>
                            <th>Aksi</th>
                            <th>Sekolah</th>
                            <th>Foto</th>
                            <th>Nama Guru</th>
                            <th>NIP</th>
                            <th>NIK</th>
                            <th>NUPTK</th>
                            <th>Status Kepegawaian</th>
                            <th>Sync Cloud</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

{% endblock %}