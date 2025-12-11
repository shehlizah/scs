{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box">
                <div class="page-title-right">
                    <!-- <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">UBold</a></li>
                        <li class="breadcrumb-item"><a href="javascript: void(0);">Dashboards</a></li>
                        <li class="breadcrumb-item active">Dashboard 3</li>
                    </ol> -->
                </div>
                <h4 class="page-title">{{page.access.access_title}}</h4>
            </div>
        </div>
    </div>
    <!-- end page title -->

    
    <div class="row">
        <div class="col-md-6 col-xl-3">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-4">
                            <div class="avatar-lg rounded bg-success">
                                <i class="dripicons-monitor font-24 avatar-title text-white"></i>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="text-end">
                                <h3 class="text-dark mt-1">
                                    <span data-plugin="counterup">
                                        <?php echo $data->count_online_scs; ?>    
                                    </span>
                                </h3>
                                <p class="text-muted mb-1">SERVER SEKOLAH ONLINE</p>
                            </div>
                        </div>
                    </div> <!-- end row-->
                </div>
            </div> <!-- end widget-rounded-circle-->
        </div> <!-- end col-->

        <div class="col-md-6 col-xl-3" style="">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-4">
                        <div class="avatar-lg rounded bg-danger">
                                <i class="dripicons-monitor font-24 avatar-title text-white"></i>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="text-end">
                                <h3 class="text-dark mt-1">
                                    <span data-plugin="counterup">
                                        <?php echo ($data->count_sekolah_scs - $data->count_online_scs); ?>                                        
                                    </span>
                                </h3>
                                <p class="text-muted mb-1">SERVER SEKOLAH OFFLINE</p>
                            </div>
                        </div>
                    </div> <!-- end row-->
                </div>
            </div> <!-- end widget-rounded-circle-->
        </div> <!-- end col-->

        <div class="col-md-6 col-xl-3" style="display:none;">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-4">
                            <div class="avatar-lg rounded bg-dark">
                                <i class="dripicons-wallet font-24 avatar-title text-white"></i>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="text-end">
                                <h3 class="mt-1">
                                    <span data-plugin="counterup">
                                    xx
                                    </span>
                                </h3>
                                <p class="text-muted mb-1 text-truncate">SISWA DATANG HARI INI</p>
                            </div>
                        </div>
                    </div> <!-- end row-->
                </div>
            </div> <!-- end widget-rounded-circle-->
        </div> <!-- end col-->

        <div class="col-md-6 col-xl-3" style="display:none;">
            <div class="widget-rounded-circle card">
                <div class="card-body">
                    <div class="row">
                    <div class="col-4">
                            <div class="avatar-lg rounded bg-dark">
                                <i class="dripicons-wallet font-24 avatar-title text-white"></i>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="text-end">
                                <h3 class="mt-1">
                                    <span data-plugin="counterup">
                                    xx
                                    </span>
                                </h3>
                                <p class="text-muted mb-1 text-truncate">SISWA PULANG HARI INI</p>
                            </div>
                        </div>
                    </div> <!-- end row-->
                </div>
            </div> <!-- end widget-rounded-circle-->
        </div> <!-- end col-->
    </div>

    <div class="row" style="display:none;" >
        <div class="col-xl-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="header-title mb-3">Grafik Absen Datang & Pulang Tanggal {{data.title_ymd}}</h4>                  
                    <div class="mt-3 chartjs-chart">
                        <!-- <div id="container"></div> -->
                        <!-- <div id="container_ontime_late"></div> -->
                    </div>
                </div> <!-- end card-body-->
            </div> <!-- end card-->
        </div> <!-- end col -->
    </div>
    <!-- end row -->

    <div class="row" style="display:none;">
        <div class="col-xl-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="header-title mb-3">Rekapitulasi SCS Tanggal {{data.title_ymd}}</h4>
                    <div class="col-sm-12">
                        <div class="col-auto">
                            <form class="form-horizontal">
                                <div class="row mb-3">
                                    <label for="inputEmail3" class="col-1 col-form-label">Pilih Tanggal</label>
                                    <div class="row">
                                    <div class="col-lg-2">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="pick_ymd" 
                                                id="pick_ymd" 
                                                value="{{data.pick_ymd}}" 
                                                class="form-control datepicker_dmy" 
                                                >   
                                            <span class="input-group-text" id="basic-addon1">
                                                <i class="fe-calendar"></i>
                                            </span>
                                        </div>                                 
                                    </div>
                                </div>
                                </div>
                            </form>
                        </div>
                    </div><!-- end col-->                       
                    <div class="row mb-2">
                        <!-- <div class="col-sm-12">
                            <a href="/dashboardpilpres/printexcelkabkota" target="_blank" class="btn btn-primary waves-effect waves-light">
                                <i class="mdi mdi-plus-circle me-1"></i> Export File Excel</a>
                        </div> -->
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-sm mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Sekolah</th>
                                    <th>Jumlah Siswa</th>
                                    <th colspan=2>Perekaman Wajah</th>
                                    <th colspan=2>Absen Datang</th>
                                    <th colspan=2>Absen Pulang</th>
                                    <th>Datang Tepat</th>
                                    <th>Datang Terlambat</th>
                                    <th>Pulang Tepat</th>
                                    <th>Pulang Terlambat</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                if (count($data->rekap_scs) > 0) {
                                    $i = 1;
                                    $total_siswa = 0;
                                    $total_siswa_fr = 0;
                                    $total_siswa_datang = 0;
                                    $total_siswa_pulang = 0;
                                    $total_siswa_datang_ontime = 0;
                                    $total_siswa_datang_late = 0;
                                    $total_siswa_pulang_ontime = 0;
                                    $total_siswa_pulang_late = 0;
                                    foreach ($data->rekap_scs as $k => $v) {
                                        $total_siswa =+ $total_siswa + $v->total_siswa;
                                        $total_siswa_fr =+ $total_siswa_fr + $v->total_siswa_fr;
                                        $total_siswa_datang =+ $total_siswa_datang + $v->total_siswa_datang;
                                        $total_siswa_pulang =+ $total_siswa_pulang + $v->total_siswa_pulang;
                                        $total_siswa_datang_ontime =+ $total_siswa_datang_ontime + $v->total_siswa_datang_ontime;
                                        $total_siswa_datang_late =+ $total_siswa_datang_late + $v->total_siswa_datang_late;
                                        $total_siswa_pulang_ontime =+ $total_siswa_pulang_ontime + $v->total_siswa_pulang_ontime;
                                        $total_siswa_pulang_late =+ $total_siswa_pulang_late + $v->total_siswa_pulang_late;
                                        ?>
                                        <tr>
                                            <th scope="row">
                                                <?php echo $i; ?>
                                            </th>
                                            <td>
                                                <a href="javascript:void();" uid="3204" nama_kabkota="KABUPATEN BANDUNG" class="">
                                                    <?php echo $v->sekolah; ?>
                                                </a>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa; ?>
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_fr; ?>
                                            </td>
                                            <td>
                                                <?php echo round(($v->total_siswa_fr/$v->total_siswa)*100); ?>%
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa_datang; ?>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo round(($v->total_siswa_datang/$v->total_siswa_fr)*100); ?>%
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_pulang; ?>
                                            </td>
                                            <td>
                                                <?php echo round(($v->total_siswa_pulang/$v->total_siswa_fr)*100); ?>%
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa_datang_ontime; ?>
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_datang_late; ?>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa_pulang_ontime; ?>
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_pulang_late; ?>
                                            </td>
                                        </tr>
                                        <?php
                                        $i ++;
                                    }
                                }
                                ?>
                                                                       
                                <tr>
                                    <th scope="row"></th>
                                    <td>TOTAL</td>
                                    <td style="background-color: #f3f7f9;"><strong><?php echo $total_siswa; ?></strong></td>
                                    <td><strong><?php echo $total_siswa_fr; ?></strong></td>
                                    <td>
                                        <strong>
                                            <?php echo round(($total_siswa_fr/$total_siswa)*100); ?>%
                                        </strong>
                                    </td>
                                    
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_datang; ?>
                                        </strong>
                                    </td>
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo round(($total_siswa_datang/$total_siswa_fr)*100); ?>%
                                        </strong>
                                    </td>

                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_pulang; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo round(($total_siswa_pulang/$total_siswa_fr)*100); ?>%
                                        </strong>
                                    </td>

                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_datang_ontime; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_datang_late; ?>
                                        </strong>
                                    </td>
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_pulang_ontime; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_pulang_late; ?>
                                        </strong>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-xl-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="header-title mb-3">Rekapitulasi SCS Tanggal {{data.title_ymd}}</h4>
                    <div class="col-sm-12">
                        <div class="col-auto">
                            <form class="form-horizontal">
                                <div class="row mb-3">
                                    <label for="inputEmail3" class="col-12 col-form-label">Pilih Tanggal</label>
                                    <div class="row">
                                    <div class="col-lg-2">
                                        <div class="input-group">
                                            <input 
                                                type="text" 
                                                name="pick_ymd" 
                                                id="pick_ymd" 
                                                value="{{data.pick_ymd}}" 
                                                class="form-control datepicker_dmy" 
                                                >   
                                            <span class="input-group-text" id="basic-addon1">
                                                <i class="fe-calendar"></i>
                                            </span>
                                        </div>                                 
                                    </div>
                                </div>
                                </div>
                            </form>
                        </div>
                    </div><!-- end col-->                        
                    <div class="row mb-2">
                        <!-- <div class="col-sm-12">
                            <a href="/dashboardpilpres/printexcelkabkota" target="_blank" class="btn btn-primary waves-effect waves-light">
                                <i class="mdi mdi-plus-circle me-1"></i> Export File Excel</a>
                        </div> -->
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table table-sm mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Sekolah</th>
                                    <th>Server Online</th>
                                    <th>Jumlah Siswa</th>
                                    <th colspan=2>Perekaman Wajah</th>
                                    <th colspan=2>Absen Datang</th>
                                    <th colspan=2>Absen Pulang</th>
                                    <!--
                                    <th>Datang Tepat</th>
                                    <th>Datang Terlambat</th>
                                    <th>Pulang Tepat</th>
                                    <th>Pulang Terlambat</th>
                                    -->
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                if (count($data->list_heartbeat) > 0) {
                                    // re-array rekap scs
                                    $ar_hearbeat = [];
                                    foreach ($data->list_heartbeat as $k=>$v) {
                                        $ar_hearbeat[$v->sekolah]['total_siswa']=$v->total_siswa;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_fr']=$v->total_siswa_fr;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_datang']=$v->total_siswa_datang;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_pulang']=$v->total_siswa_pulang;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_datang_ontime']=$v->total_siswa_datang_ontime;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_datang_late']=$v->total_siswa_datang_late;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_pulang_ontime']=$v->total_siswa_pulang_ontime;
                                        $ar_hearbeat[$v->sekolah]['total_siswa_pulang_late']=$v->total_siswa_pulang_late;
                                    }


                                    $i = 1;
                                    $total_siswa = 0;
                                    $total_siswa_fr = 0;
                                    $total_siswa_datang = 0;
                                    $total_siswa_pulang = 0;
                                    $total_siswa_datang_ontime = 0;
                                    $total_siswa_datang_late = 0;
                                    $total_siswa_pulang_ontime = 0;
                                    $total_siswa_pulang_late = 0;

                                    foreach ($data->list_sekolah as $k => $v) {
                                        $v_total_siswa = (strlen($ar_hearbeat[$v->sekolah]['total_siswa'])>0) ? $ar_hearbeat[$v->sekolah]['total_siswa'] : 0;
                                        $total_siswa =+ $total_siswa + $v_total_siswa;

                                        $v_total_siswa_fr = (strlen($ar_hearbeat[$v->sekolah]['total_siswa'])>0) ? $ar_hearbeat[$v->sekolah]['total_siswa_fr'] : 0;
                                        $total_siswa_fr =+ $total_siswa_fr + $v_total_siswa_fr;

                                        $v_total_siswa_datang = (strlen($ar_hearbeat[$v->sekolah]['total_siswa'])>0) ? $ar_hearbeat[$v->sekolah]['total_siswa_datang'] : 0;
                                        $total_siswa_datang =+ $total_siswa_datang + $v_total_siswa_datang;

                                        $v_total_siswa_pulang = (strlen($ar_hearbeat[$v->sekolah]['total_siswa'])>0) ? $ar_hearbeat[$v->sekolah]['total_siswa_pulang'] : 0;
                                        $total_siswa_pulang =+ $total_siswa_pulang + $v_total_siswa_pulang;

                                        $total_siswa_datang_ontime =+ $total_siswa_datang_ontime + $v->total_siswa_datang_ontime;
                                        $total_siswa_datang_late =+ $total_siswa_datang_late + $v->total_siswa_datang_late;
                                        $total_siswa_pulang_ontime =+ $total_siswa_pulang_ontime + $v->total_siswa_pulang_ontime;
                                        $total_siswa_pulang_late =+ $total_siswa_pulang_late + $v->total_siswa_pulang_late;
                                        ?>
                                        <tr>
                                            <th scope="row">
                                                <?php echo $i; ?>
                                            </th>
                                            <td>
                                                <a href="javascript:void();" uid="3204" nama_kabkota="KABUPATEN BANDUNG" class="">
                                                    <?php echo $v->sekolah; ?>
                                                </a>
                                            </td>
                                            <td>
                                                <a href="javascript:void();" uid="3204" nama_kabkota="KABUPATEN BANDUNG" class="">
                                                <?php echo (strlen($ar_hearbeat[$v->sekolah]['total_siswa'])>0) ? '<span class="badge bg-success">&nbsp;</span>' : '<span class="badge bg-danger">&nbsp;</span>'; ?>
                                                </a>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo ($v_total_siswa == 0) ? '-' : $v_total_siswa; ?>
                                            </td>
                                            <td>
                                                <?php echo ($v_total_siswa_fr == 0) ? '-' : $v_total_siswa_fr; ?>
                                            </td>
                                            <td>
                                                <?php echo ($v_total_siswa_fr == 0) ? '-' : round(($v_total_siswa_fr/$v_total_siswa)*100).'%'; ?>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo ($v_total_siswa_datang== 0) ? '-' : $v_total_siswa_datang; ?>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo ($v_total_siswa_datang== 0) ? '-' : round(($v_total_siswa_datang/$v_total_siswa_fr)*100).'%'; ?>
                                            </td>
                                            <td>
                                                <?php echo ($v_total_siswa_pulang== 0) ? '-' : $v_total_siswa_pulang; ?>
                                            </td>
                                            <td>
                                                <?php echo ($v_total_siswa_pulang== 0) ? '-' : round(($v_total_siswa_pulang/$v_total_siswa_fr)*100).'%'; ?>
                                            </td>
                                            <!--
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa_datang_ontime; ?>
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_datang_late; ?>
                                            </td>
                                            <td style="background-color: #f3f7f9;">
                                                <?php echo $v->total_siswa_pulang_ontime; ?>
                                            </td>
                                            <td>
                                                <?php echo $v->total_siswa_pulang_late; ?>
                                            </td>
                                            -->
                                        </tr>
                                        <?php
                                        $i ++;
                                    }
                                }
                                ?>
                                                                       
                                <tr>
                                    <th scope="row"></th>
                                    <td>TOTAL</td>
                                    <td><strong><?php echo count($data->list_heartbeat); ?></strong></td>
                                    <td style="background-color: #f3f7f9;"><strong><?php echo $total_siswa; ?></strong></td>
                                    <td><strong><?php echo $total_siswa_fr; ?></strong></td>
                                    <td>
                                        <strong>
                                            <?php echo round(($total_siswa_fr/$total_siswa)*100); ?>%
                                        </strong>
                                    </td>
                                    
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_datang; ?>
                                        </strong>
                                    </td>
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo round(($total_siswa_datang/$total_siswa_fr)*100); ?>%
                                        </strong>
                                    </td>

                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_pulang; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo round(($total_siswa_pulang/$total_siswa_fr)*100); ?>%
                                        </strong>
                                    </td>
                                    <!--
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_datang_ontime; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_datang_late; ?>
                                        </strong>
                                    </td>
                                    <td style="background-color: #f3f7f9;">
                                        <strong>
                                            <?php echo $total_siswa_pulang_ontime; ?>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong>
                                            <?php echo $total_siswa_pulang_late; ?>
                                        </strong>
                                    </td>
                                    -->
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>

<style>
    .highcharts-figure,
    .highcharts-data-table table {
        min-width: 310px;
        max-width: 800px;
        margin: 1em auto;
    }

    #container {
        height: 800px;
    }

    .highcharts-data-table table {
        font-family: Verdana, sans-serif;
        border-collapse: collapse;
        border: 1px solid #ebebeb;
        margin: 10px auto;
        text-align: center;
        width: 100%;
        max-width: 500px;
    }

    .highcharts-data-table caption {
        padding: 1em 0;
        font-size: 1.2em;
        color: #555;
    }

    .highcharts-data-table th {
        font-weight: 600;
        padding: 0.5em;
    }

    .highcharts-data-table td,
    .highcharts-data-table th,
    .highcharts-data-table caption {
        padding: 0.5em;
    }

    .highcharts-data-table thead tr,
    .highcharts-data-table tr:nth-child(even) {
        background: #f8f8f8;
    }

    .highcharts-data-table tr:hover {
        background: #f1f7ff;
    }

</style>
{% endblock %}