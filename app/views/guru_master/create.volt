{% extends "layout_scs/base.volt" %}
{% block content %}
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Data Guru </h3>
        </div>
        <div class="col-md-7 align-self-center">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
            <a href="javascript:void(0)">Home</a>
            </li>
            <li class="breadcrumb-item active">Data Guru</li>
        </ol>
        </div>
    </div>
    <div class="container-fluid">
    <div class="row">
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title m-b-0">Penugasan</h4>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="inputEmail">Nomor Surat Tugas</label>
						<input type="text" name="nomor_surat_tugas" value="" class="form-control">
					</div>
					<div class="form-group">
						<label for="inputEmail">Tanggal Surat Tugas</label>
						<div class="input-group date">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right datepickerfull" name="tanggal_surat_tugas" data-date-format="yyyy-mm-dd" value="">
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="card">
				<div class="card-header">
					<h4 class="card-title m-b-0">Diisi saat sudah keluar</h4>
				</div>
				<div class="card-body">
					<div class="form-group">
						<label for="inputEmail">Keluar Karena</label>
						<select name="jeniskeluar" class="form-control">
							<option value="">-- Pilih --</option>
														<option value="8">Alih Fungsi</option>
														<option value="3">Dikeluarkan</option>
														<option value="7">Hilang</option>
														<option value="Z">Lainnya</option>
														<option value="4">Mengundurkan diri</option>
														<option value="2">Mutasi</option>
														<option value="9">Pensiun</option>
														<option value="6">Wafat</option>
													</select>
					</div>
					<div class="form-group">
						<label for="inputEmail">Tanggal Keluar</label>
						<div class="input-group date">
							<div class="input-group-addon">
								<i class="fa fa-calendar"></i>
							</div>
							<input type="text" class="form-control pull-right datepickerfull" name="tglptkkeluar" data-date-format="yyyy-mm-dd" value="">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

    <div class="container-fluid">
        <!-- Hover Table -->
        <div class="card">
            <div class="card-header">
                <h4 class="card-title m-b-0">Tambah Data Guru</h4>
            </div>
            <div class="card-body">
                <form method="post" action="/guru/create" name="">
                    <input type="hidden" name="submitdata" value="simpan">
                    <div class="form-group">
                        <label for="inputEmail">Nama Guru</label>
                        <input type="text" class="form-control" value="" name="nama_lengkap" required>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">NIP</label>
                        <input type="text" class="form-control" value="" name="nip">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">NIK</label>
                        <input type="text" class="form-control" value="" name="nik" required>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">NUPTK</label>
                        <input type="text" class="form-control" value="" name="nuptk">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Jenis Kelamin</label>
                        <div class="form-group checksetkelas">
                            <label>
                                <input type="radio" name="jenkel" value="P" class="minimal">
                                <span>Perempuan</span>
                            </label> &nbsp;&nbsp;&nbsp; <label>
                                <input type="radio" name="jenkel" value="L" class="minimal">
                                <span>Laki-laki</span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Tempat Lahir</label>
                        <input type="text" class="form-control" name="tempat_lahir" value="" required>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Tanggal Lahir</label>
                        <div class="input-group date">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <input type="text" class="form-control pull-right datepickerfull" name="tgllahir" data-date-format="yyyy-mm-dd" value="" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Status Kepegawaian</label>
                        <select name="statuskepegawaianid" class="form-control">
                            <option value="">--Pilih--</option>
                            <option value="10">CPNS</option>
                            <option value="4">GTY/PTY</option>
                            <option value="7">Guru Bantu Pusat</option>
                            <option value="8">Guru Honor Sekolah</option>
                            <option value="5">Honor Daerah TK.I Provinsi</option>
                            <option value="6">Honor Daerah TK.II Kab/Kota</option>
                            <option value="51">Kontrak Kerja WNA</option>
                            <option value="99">Lainnya</option>
                            <option value="1">PNS</option>
                            <option value="3">PNS Depag</option>
                            <option value="2">PNS Diperbantukan</option>
                            <option value="9">Tenaga Honor Sekolah</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Pangkat Golongan</label>
                        <select name="golonganid" class="form-control">
                            <option value="">--Pilih--</option>
                            <option value="99">Golongan -</option>
                            <option value="1">Golongan I/a</option>
                            <option value="2">Golongan I/b</option>
                            <option value="3">Golongan I/c</option>
                            <option value="4">Golongan I/d</option>
                            <option value="5">Golongan II/a</option>
                            <option value="6">Golongan II/b</option>
                            <option value="7">Golongan II/c</option>
                            <option value="8">Golongan II/d</option>
                            <option value="9">Golongan III/a</option>
                            <option value="10">Golongan III/b</option>
                            <option value="11">Golongan III/c</option>
                            <option value="12">Golongan III/d</option>
                            <option value="13">Golongan IV/a</option>
                            <option value="14">Golongan IV/b</option>
                            <option value="15">Golongan IV/c</option>
                            <option value="16">Golongan IV/d</option>
                            <option value="17">Golongan IV/e</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Jenis PTK</label>
                        <select name="jenisptkid" class="form-control" required>
                            <option value="">--Pilih--</option>
                            <option value="5">Guru BK</option>
                            <option value="6">Guru Inklusi</option>
                            <option value="3">Guru Kelas</option>
                            <option value="13">Guru Magang</option>
                            <option value="4">Guru Mapel</option>
                            <option value="12">Guru Pendamping</option>
                            <option value="14">Guru TIK</option>
                            <option value="20">Kepala Sekolah</option>
                            <option value="54">Kindergarten Teacher</option>
                            <option value="56">Play Group Teacher</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Agama</label>
                        <select name="agama" class="form-control">
                            <option value="">--Pilih--</option>
                            <option value="1">Islam</option>
                            <option value="2">Kristen</option>
                            <option value="3">Katholik</option>
                            <option value="4">Hindu</option>
                            <option value="5">Buddha</option>
                            <option value="6">Konghuchu</option>
                            <option value="7">Kepercayaan kpd Tuhan YME</option>
                            <option value="98">Tidak diisi</option>
                            <option value="99">Lainnya</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Alamat</label>
                        <textarea class="form-control" name="alamat" rows="5" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Telepon</label>
                        <input type="text" class="form-control" name="telepon" value="">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">HP</label>
                        <input type="text" class="form-control" name="hp" value="">
                    </div>
                    <div class="form-group">
                        <label for="inputEmail">Email</label>
                        <input type="email" class="form-control" name="email" value="" required>
                    </div>
                    <!--
<div id="mapellist"><div class="form-group"><label>Mapel</label><select class="form-control select2" id="mapelchoose" multiple="multiple" name="mapel[]" data-placeholder="-- Pilih Mapel --" style="width: 100%;"><option value="0">-- Pilih --</option></select></div></div>
-->
                    <div class="form-group">
                        <label for="inputEmail">Tanggal Masuk</label>
                        <div class="input-group date">
                            <div class="input-group-addon">
                                <i class="fa fa-calendar"></i>
                            </div>
                            <input type="text" class="form-control pull-right datepickerfull" name="tglmasuk" data-date-format="yyyy-mm-dd" value="" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputStatus">Aktif</label>
                        <div class="onoffswitch">
                            <input type="checkbox" name="aktif" class="onoffswitch-checkbox" id="aktif" value="1" checked>
                            <label class="onoffswitch-label label-primary" for="aktif">
                                <span class="onoffswitch-inner"></span>
                                <span class="onoffswitch-switch"></span>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-save"></i> Simpan </button>
                        <button type="button" onclick="location.href='/guru'" class="btn btn-warning">
                            <i class="fa fa-reply"></i> Kembali </button>
                    </div>
                </form>
            </div>
        </div>
        <!-- ./Hover Table -->
    </div>
{% endblock %}