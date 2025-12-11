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
                        <h4 class="header-title">Tanggal Absen</h4>
                        <form method="GET" class="row g-3">
                            <div class="col-xl-2 col-md-3">
                                <div class="input-group">
                                    <input 
                                        type="text" 
                                        name="pick_date" 
                                        id="pick_date" 
                                        value="{{data.pick_date}}" 
                                        class="form-control datepicker_dmy" 
                                        required>   
                                    <span class="input-group-text" id="basic-addon1">
                                        <i class="fe-calendar"></i>
                                    </span>
                                </div>  
                            </div>
                            <div class="col-xl-2 col-md-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Tampilkan Data Absensi</button>
                            </div>
                        </form>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                
                <table id="dataRows" class="table nowrap w-100 table-striped">
                    <thead>
                        <tr>
                            <th>Waktu</th>
                            <th>Sekolah</th>
                            <th>Device Absen</th>
                            <th>Foto Absen</th>
                            <th>Foto Siswa</th>
                            <th>NISN</th>
                            <th>Nama Lengkap</th>
                            <th>Area</th>
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