{% extends "layout_scs/base.volt" %}
{% block content %}
<style>
    .btnfilter{
        margin-top: 27px;
        height: 40px;
    }
    .titlecharttbl{
        font-weight: 600;
        margin: 0px 0px 20px;
        font-size: 16px;
        color: #000;
        float: left;
    }
    .tablejadwal thead th{
        font-weight: 600 !important;
        color: #ffffff;
        background: #0084ff;
    }
    .tablejadwal tbody td.clmteacher{
        padding: 12px 15px;
        vertical-align: middle;
        background: #ffefc3;
        color: #424242;
    }
    .printjadwalarr{
        margin-bottom: 25px;
        display: table;
        margin-left: auto;
        float: right;
    }
    .tablejadwal tbody td:first-child{
        text-align: center;
    }
    .formfilter{
        margin: 0px 25px;
        margin-bottom: 10px;
        margin-top: 0px;
        padding-bottom: 15px;
    }
    .formfilter .form-group label{
        line-height: 36px;
        font-size: 14px;
        margin-bottom: 0px;
    }
    .formfilter .form-group .form-control{
        float: right;
        width: 225px;
    }
    .jadwalpage .formfilter{
        float: left;
        margin-left: 0px;
    }
    .jadwalpage .form-group label{
        display: block;
    }
</style>
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Jadwal Kelas </h3>
        </div>
        <div class="col-md-7 align-self-center">
        <!-- <ol class="breadcrumb">
            <li class="breadcrumb-item">
            <a href="javascript:void(0)">Home</a>
            </li>
            <li class="breadcrumb-item active">Absensi Guru</li>
        </ol> -->
        </div>
    </div>
    <div class="container-fluid">
        <!-- Hover Table -->
        <div class="card">
            <div class="card-header">
                <h4 class="card-title m-b-0">Edit Jadwal</h4>
            </div>
            <div class="card-body">
                <form method="post" action="#" name="saveformdrop">
                    <input type="hidden" name="submitdata" value="simpan">
                    <div class="form-group">
                        <label for="inputEmail">Hari</label>
                        <input type="text" name="hari" value="Senin" class="form-control" disabled="" required="">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Kelas</label>
                        <input type="text" name="kelas" value="Kelas X 1" class="form-control" disabled="" required="">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Mata Pelajaran</label>
                        <select class="form-control select2 select2-hidden-accessible" id="mapelselect" name="mapelid" data-placeholder="-- Pilih Mata Pelajaran --" style="width: 100%;" required="" data-select2-id="mapelselect" tabindex="-1" aria-hidden="true">
                            <option value="">-- Pilih Mata Pelajaran --</option>
                                                <option value="409">Matematika - Demo Sekolah - Sisa Jam : 2</option>
                                                <option value="444">Bahasa Arab -  - Sisa Jam : 2</option>
                                                <option value="405">Bahasa Arab - Jenab Sopiah, S.Pd.I. - Sisa Jam : 2</option>
                                                <option value="418">tahfiz - Rika Safirah, S.Pd. - Sisa Jam : 2</option>
                                                <option value="450">Dasar Desain Grafis -  - Sisa Jam : 4</option>
                                                <option value="472">Bahasa Inggris - Guru Demo 1 - Sisa Jam : 1</option>
                                                <option value="448">Kimia -  - Sisa Jam : 2</option>
                                                <option value="445">Fisika -  - Sisa Jam : 2</option>
                                                <option value="449">Simulasi dan Komunikasi Digital -  - Sisa Jam : 4</option>
                                                <option value="408">Seni Budaya - Andya Pratama, S.Kom., M.Pd. - Sisa Jam : 1</option>
                                                <option value="412">Desain Grafis - Iffah Afkarina, S.Ds - Sisa Jam : 6</option>
                                                <option value="404" selected="" data-select2-id="2">Informatika - Andya Pratama, S.Kom., M.Pd. - Sisa Jam : 4</option>
                                                <option value="469">Ritual Buddhis - Guru Baru - Sisa Jam : 2</option>
                                            </select><span class="select2 select2-container select2-container--default" dir="ltr" data-select2-id="1" style="width: 100%;"><span class="selection"><span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-labelledby="select2-mapelselect-container"><span class="select2-selection__rendered" id="select2-mapelselect-container" role="textbox" aria-readonly="true" title="Informatika - Andya Pratama, S.Kom., M.Pd. - Sisa Jam : 4">Informatika - Andya Pratama, S.Kom., M.Pd. - Sisa Jam : 4</span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="inputEmail">Jam mulai</label>
                                <input type="text" name="jam_mulai" value="1" class="form-control" disabled="" required="">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="inputEmail">Lama Pembelajaran</label>
                                <select class="form-control" name="jumlahjam" id="jumlahjam" required="">
                                                                <option value="1">1 jam pelajaran</option>
                                                                <option value="2" selected="">2 jam pelajaran</option>
                                                            </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Ruangan</label>
                        <select class="form-control select2 select2-hidden-accessible" id="prasarana_id" name="prasarana_id" data-placeholder="-- Pilih Ruangan --" style="width: 100%;" required="" data-select2-id="prasarana_id" tabindex="-1" aria-hidden="true">
                            <option value="">-- Pilih Ruangan --</option>
                                                <option value="2">R. Teori UGM</option>
                                                <option value="3" selected="" data-select2-id="4">ITB</option>
                                                <option value="4">KAMAR MANDI LAKI LAKI</option>
                                                <option value="5">KAMAR MANDI PEREMPUAN</option>
                                                <option value="6">RUANG GURU</option>
                                                <option value="8">RUANG KAMAD</option>
                                                <option value="9">RUANG OSIS</option>
                                                <option value="10">RUANG LITERASI</option>
                                                <option value="11">RUANG TATA USAHA</option>
                                                <option value="12">RUANG UKS</option>
                                                <option value="13">POS SECURITY</option>
                                                <option value="14">LAPANGAN</option>
                                                <option value="15">R. UNY</option>
                                                <option value="16">R. UIN</option>
                                                <option value="17">Ruang Teori 1</option>
                                            </select><span class="select2 select2-container select2-container--default" dir="ltr" data-select2-id="3" style="width: 100%;"><span class="selection"><span class="select2-selection select2-selection--single" role="combobox" aria-haspopup="true" aria-expanded="false" tabindex="0" aria-labelledby="select2-prasarana_id-container"><span class="select2-selection__rendered" id="select2-prasarana_id-container" role="textbox" aria-readonly="true" title="ITB">ITB</span><span class="select2-selection__arrow" role="presentation"><b role="presentation"></b></span></span></span><span class="dropdown-wrapper" aria-hidden="true"></span></span>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-save"></i> Simpan</button>
                        <button type="button" onclick="location.href='/jadwalkelas'" class="btn btn-warning"><i class="fa fa-reply"></i> Kembali</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- ./Hover Table -->
    </div>
{% endblock %}