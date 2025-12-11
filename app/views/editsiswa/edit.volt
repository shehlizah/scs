{% extends "layout_scs/base.volt" %}
{% block content %}
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Data Siswa </h3>
        </div>
        <div class="col-md-7 align-self-center">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
            <a href="javascript:void(0)">Home</a>
            </li>
            <li class="breadcrumb-item active">Data Siswa</li>
        </ol>
        </div>
    </div>

    <div class="container-fluid">
        <!-- Hover Table -->
        <div class="card">
            <div class="card-header">
                <h4 class="card-title m-b-0">Ubah Data Siswa</h4>
            </div>
            <div class="card-body">
                <form method="post" action="/editsiswa/edit/{{data.row.id}}" name="">
                    <input type="hidden" name="submitdata" value="simpan">
                    <div class="form-group">
                        <label for="inputEmail">Nama Siswa</label>
                        <input type="text" class="form-control" value="{{data.row.nama_lengkap}}" name="nama_lengkap" required>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Nomor Orang Tua</label>
                        <input type="text" class="form-control" value="{{data.row.nomor_orangtua}}" name="nomor_orangtua">
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> Simpan </button>
                        <button type="button" onclick="location.href='/editsiswa'" class="btn btn-warning">
                            <i class="fa fa-reply"></i> Kembali </button>
                    </div>
                </form>
            </div>
        </div>
        <!-- ./Hover Table -->
    </div>
{% endblock %}