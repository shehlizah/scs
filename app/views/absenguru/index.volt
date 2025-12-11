{% extends "layout_scs/base.volt" %}
{% block content %}
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Absensi Guru </h3>
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
                <h4 class="card-title m-b-0">Data Absensi Guru</h4>
            </div>
            <div class="card-body">
                <form class="formfilter" action="#" method="post">
                    <div class="row">
                        <div class="col-md-2 col-sm-6">
                            <div class="form-group">
                                <select class="form-control" name="smatpel">
                                    <option value="">-- Pilih Mata Pelajaran --</option>
                                                                <option value="Al Qur'an Hadits">Al Qur'an Hadits</option>
                                                                <option value="Aqidah Akhlak">Aqidah Akhlak</option>
                                                                <option value="Bahasa Arab">Bahasa Arab</option>
                                                                <option value="Bahasa Indonesia">Bahasa Indonesia</option>
                                                                <option value="Bahasa Inggris">Bahasa Inggris</option>
                                                                <option value="Dasar Desain Grafis">Dasar Desain Grafis</option>
                                                                <option value="Dasar Grafis Percetakan">Dasar Grafis Percetakan</option>
                                                                <option value="Dasar Multimedia">Dasar Multimedia</option>
                                                                <option value="Desain Grafis">Desain Grafis</option>
                                                                <option value="Desain Media Interaktif">Desain Media Interaktif</option>
                                                                <option value="Fiqih">Fiqih</option>
                                                                <option value="Fisika">Fisika</option>
                                                                <option value="Fotografi">Fotografi</option>
                                                                <option value="Informatika">Informatika</option>
                                                                <option value="Kimia">Kimia</option>
                                                                <option value="Matematika">Matematika</option>
                                                                <option value="Pemrograman Dasar">Pemrograman Dasar</option>
                                                                <option value="Pendidikan Agama Islam dan Budi Pekerti">Pendidikan Agama Islam dan Budi Pekerti</option>
                                                                <option value="Pendidikan Jasmani, olah raga, &amp; Kesehatan">Pendidikan Jasmani, olah raga, &amp; Kesehatan</option>
                                                                <option value="Pendidikan Pancasila dan Kewarganegaraan">Pendidikan Pancasila dan Kewarganegaraan</option>
                                                                <option value="Produk Kreatif dan Kewirausahaan">Produk Kreatif dan Kewirausahaan</option>
                                                                <option value="Produk Kreatif dan Kewirausahaan">Produk Kreatif dan Kewirausahaan</option>
                                                                <option value="Ritual Buddhis">Ritual Buddhis</option>
                                                                <option value="Seni Budaya">Seni Budaya</option>
                                                                <option value="Simulasi dan Komunikasi Digital">Simulasi dan Komunikasi Digital</option>
                                                                <option value="SKI">SKI</option>
                                                                <option value="tahfiz">tahfiz</option>
                                                                <option value="Teknik Pengolahan Audio dan Video">Teknik Pengolahan Audio dan Video</option>
                                                                <option value="Videografi">Videografi</option>
                                                                <option value="Virtual Reality">Virtual Reality</option>
                                                            </select>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6">
                            <div class="form-group">
                                <select class="form-control" name="sbulan" required="">
                                    <option value="">-- Pilih Bulan --</option>
                                                                <option value="01">Januari</option>
                                                                <option value="02">Februari</option>
                                                                <option value="03" selected="">Maret</option>
                                                                <option value="04">April</option>
                                                                <option value="05">Mei</option>
                                                                <option value="06">Juni</option>
                                                                <option value="07">Juli</option>
                                                                <option value="08">Agustus</option>
                                                                <option value="09">September</option>
                                                                <option value="10">Oktober</option>
                                                                <option value="11">November</option>
                                                                <option value="12">Desember</option>
                                                            </select>
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6">
                            <div class="form-group">
                                <select class="form-control" name="stahun" required="">
                                    <option value="">-- Pilih Tahun --</option>
                                                                <option value="2017">2017</option>
                                                                <option value="2018">2018</option>
                                                                <option value="2019">2019</option>
                                                                <option value="2020">2020</option>
                                                                <option value="2021">2021</option>
                                                                <option value="2022" selected="">2022</option>
                                                                <option value="2023">2023</option>
                                                            </select>
                            </div>
                        </div>
                        <div class="col-md-3 col-sm-6">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Nama Guru" name="snamaguru" value="">
                            </div>
                        </div>
                        <div class="col-md-2 col-sm-6">
                            <div class="form-group">
                                <button type="submit" name="filterdata" value="simpan" class="btn btn-info"><i class="fa fa-search"></i> Filter</button>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- Modal -->
                <br>
                <br>
                <div class="infoabsent">
                    <div class="singleinfo">
                        <span class="prescolor"></span> Hadir
                    </div>
                    <div class="singleinfo">
                        <span class="sickcolor"></span> Sakit
                    </div>
                    <div class="singleinfo">
                        <span class="permcolor"></span> Izin
                    </div>
                    <div class="singleinfo">
                        <span class="dispencolor"></span> Dispensasi
                    </div>
                    <div class="singleinfo">
                        <span class="alpacolor"></span> Tidak Ada Keterangan
                    </div>
                    <div class="singleinfo">
                        <span class="preslate"></span> Terlambat
                    </div>
                    <div class="singleinfo">
                        <span class="offcolor"></span> Hari Libur
                    </div>
                </div>
                <div id="table-scroll" class="table-scroll">
                  <div class="table-wrap">
                <div class="table-responsive tableresabsen">
                    <table class="table table-bordered tableabsent main-table">
                        <thead>
                            <tr>
                                <th rowspan="2" class="text-center fixed-side">No</th>
                                <th rowspan="2" class="fixed-side">Nama</th>
                                <th colspan=" 31 " class="text-center">Maret</th>
                            </tr>
                            <tr>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-1'" style="cursor: pointer;">1</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-2'" style="cursor: pointer;">2</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-3'" style="cursor: pointer;">3</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-4'" style="cursor: pointer;">4</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-5'" style="cursor: pointer;">5</th>
                                                        <th class="text-center">6</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-7'" style="cursor: pointer;">7</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-8'" style="cursor: pointer;">8</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-9'" style="cursor: pointer;">9</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;">10</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;">11</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;">12</th>
                                                        <th class="text-center">13</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;">14</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;">15</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;">16</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;">17</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;">18</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;">19</th>
                                                        <th class="text-center">20</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;">21</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;">22</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;">23</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;">24</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;">25</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;">26</th>
                                                        <th class="text-center">27</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;">28</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;">29</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;">30</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-31'" style="cursor: pointer;">31</th>
                                                    </tr>
                        </thead>
                        <tbody>
                                                <tr>
                                <td class="text-center fixed-side" rowspan="2">1</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/27?sbulan=03&amp;stahun=2022">Agung Rizki Laksono</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:03</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:50</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">2</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/1?sbulan=03&amp;stahun=2022">Andya Pratama</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">09:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">3</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/25?sbulan=03&amp;stahun=2022">Andya Pratama, S.Kom., M.Pd.</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-05'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">4</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/5?sbulan=03&amp;stahun=2022">Asep Lukman Arip Hidayat, S.Kom.</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">5</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/33?sbulan=03&amp;stahun=2022">Cucu, S.Pd</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-05'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">6</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/12?sbulan=03&amp;stahun=2022">Demo Sekolah</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">7</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/11?sbulan=03&amp;stahun=2022">Fikry Bermaki, S.Pd.</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">8</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/53?sbulan=03&amp;stahun=2022">Guru Baru</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">9</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/56?sbulan=03&amp;stahun=2022">Guru Demo 1</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">10</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/57?sbulan=03&amp;stahun=2022">Guru Demo 2</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">11</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/58?sbulan=03&amp;stahun=2022">Guru Demo 3</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">12</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/59?sbulan=03&amp;stahun=2022">Guru Demo 4</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">13</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/60?sbulan=03&amp;stahun=2022">Guru Demo 5</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">14</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/21?sbulan=03&amp;stahun=2022">Ibnu Rasyid</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">15</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/32?sbulan=03&amp;stahun=2022">Iffah Afkarina, S.Ds</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">16</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/62?sbulan=03&amp;stahun=2022">Ilham Rizki</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">17</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/8?sbulan=03&amp;stahun=2022">Jenab Sopiah, S.Pd.I.</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">18</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/10?sbulan=03&amp;stahun=2022">Maesaroh, S.E.</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">19</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/6?sbulan=03&amp;stahun=2022">Ricky Hakiqi Elmaturidy, S.Ag.</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">20</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/20?sbulan=03&amp;stahun=2022">Rika Safirah, S.Pd.</a>
                                </td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:12</td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent ">07:18</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">21</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/29?sbulan=03&amp;stahun=2022">Riko Ali Saputra</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">22</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/31?sbulan=03&amp;stahun=2022">Rizqy Amelia</a>
                                </td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:00</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:09</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">23</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/52?sbulan=03&amp;stahun=2022">Tes</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                </tbody>
                    </table>
                <table class="table table-bordered tableabsent main-table clone">
                        <thead>
                            <tr>
                                <th rowspan="2" class="text-center fixed-side">No</th>
                                <th rowspan="2" class="fixed-side">Nama</th>
                                <th colspan=" 31 " class="text-center">Maret</th>
                            </tr>
                            <tr>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-1'" style="cursor: pointer;">1</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-2'" style="cursor: pointer;">2</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-3'" style="cursor: pointer;">3</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-4'" style="cursor: pointer;">4</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-5'" style="cursor: pointer;">5</th>
                                                        <th class="text-center">6</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-7'" style="cursor: pointer;">7</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-8'" style="cursor: pointer;">8</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-9'" style="cursor: pointer;">9</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;">10</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;">11</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;">12</th>
                                                        <th class="text-center">13</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;">14</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;">15</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;">16</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;">17</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;">18</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;">19</th>
                                                        <th class="text-center">20</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;">21</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;">22</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;">23</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;">24</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;">25</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;">26</th>
                                                        <th class="text-center">27</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;">28</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;">29</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;">30</th>
                                                        <th class="text-center" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-31'" style="cursor: pointer;">31</th>
                                                    </tr>
                        </thead>
                        <tbody>
                                                <tr>
                                <td class="text-center fixed-side" rowspan="2">1</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/27?sbulan=03&amp;stahun=2022">Agung Rizki Laksono</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:03</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:50</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">2</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/1?sbulan=03&amp;stahun=2022">Andya Pratama</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">09:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">3</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/25?sbulan=03&amp;stahun=2022">Andya Pratama, S.Kom., M.Pd.</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-05'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">4</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/5?sbulan=03&amp;stahun=2022">Asep Lukman Arip Hidayat, S.Kom.</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">5</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/33?sbulan=03&amp;stahun=2022">Cucu, S.Pd</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-05'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-12'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-19'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-26'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">6</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/12?sbulan=03&amp;stahun=2022">Demo Sekolah</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">7</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/11?sbulan=03&amp;stahun=2022">Fikry Bermaki, S.Pd.</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">09:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">8</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/53?sbulan=03&amp;stahun=2022">Guru Baru</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">9</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/56?sbulan=03&amp;stahun=2022">Guru Demo 1</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">10</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/57?sbulan=03&amp;stahun=2022">Guru Demo 2</a>
                                </td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">11</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/58?sbulan=03&amp;stahun=2022">Guru Demo 3</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">12</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/59?sbulan=03&amp;stahun=2022">Guru Demo 4</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">13</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/60?sbulan=03&amp;stahun=2022">Guru Demo 5</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">14</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/21?sbulan=03&amp;stahun=2022">Ibnu Rasyid</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">15</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/32?sbulan=03&amp;stahun=2022">Iffah Afkarina, S.Ds</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">16</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/62?sbulan=03&amp;stahun=2022">Ilham Rizki</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">17</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/8?sbulan=03&amp;stahun=2022">Jenab Sopiah, S.Pd.I.</a>
                                </td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">06:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">18</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/10?sbulan=03&amp;stahun=2022">Maesaroh, S.E.</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">19</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/6?sbulan=03&amp;stahun=2022">Ricky Hakiqi Elmaturidy, S.Ag.</a>
                                </td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">20</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/20?sbulan=03&amp;stahun=2022">Rika Safirah, S.Pd.</a>
                                </td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:45</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:12</td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="1" class="text-center abcent ">07:18</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:15</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:30</td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-04'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-11'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-18'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-25'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">21</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/29?sbulan=03&amp;stahun=2022">Riko Ali Saputra</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="2">22</td>
                                <td class="fixed-side" rowspan="2">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/31?sbulan=03&amp;stahun=2022">Rizqy Amelia</a>
                                </td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-01'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:00</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">08:00</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-08'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">08:09</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-10'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-15'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent abcentlate ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-17'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:30</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-22'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent ">07:00</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-24'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-29'" style="cursor: pointer;" class="text-center  "></td>
                                                        <td rowspan="1" class="text-center abcent ">07:15</td>
                                                        <td rowspan="2" class="text-center  dayoff"></td>
                                                    </tr>
                                                <tr>
                                                                                                                                <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-02'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-07'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-09'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-14'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-16'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-21'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-23'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-28'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                                                        <td rowspan="1" onclick="location.href='?sbulan=03&amp;stahun=2022&amp;tglchoose=2022-03-30'" style="cursor: pointer;" class="text-center  "></td>
                                                                                                                            </tr>
                                                                    <tr>
                                <td class="text-center fixed-side" rowspan="1">23</td>
                                <td class="fixed-side" rowspan="1">
                                    <a href="https://demo.sekolahan.id/absenguru/detail/52?sbulan=03&amp;stahun=2022">Tes</a>
                                </td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                        <td class="text-center  dayoff"></td>
                                                    </tr>
                                                                </tbody>
                    </table></div>
            </div>
        </div>
                    </div>
        </div>
        <!-- ./Hover Table -->
    </div>
{% endblock %}