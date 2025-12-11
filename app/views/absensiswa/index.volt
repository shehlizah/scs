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
                <!-- 
                    <div><?php echo json_encode($data->absen_by_nisn_tgl_absen_datang); ?></div>
                    <div><?php echo json_encode($data->absen_by_nisn_tgl_absen_pulang); ?></div> 
                -->
                <div class="row mb-2">
                    <div class="col-sm-12 mb-3">
                        <a 
                            href="/{{page.access.resources_name}}/importcctvdatang/<?php echo date('Y-m-d'); ?>" 
                            class="btn btn-info waves-effect waves-light"><i class="mdi mdi-plus-circle me-1"></i> Import Datang
                        </a>

                        <a 
                            href="/{{page.access.resources_name}}/importcctvpulang/<?php echo date('Y-m-d'); ?>" 
                            class="btn btn-info waves-effect waves-light"><i class="mdi mdi-plus-circle me-1"></i> Import Pulang
                        </a>
                    </div>
                    <div class="col-sm-12">
                        <div class="col-auto">

                            <form class="form-horizontal">
                                <div class="row mb-3">
                                    <label for="inputEmail3" class="col-1 col-form-label">Periode</label>
                                    <div class="col-2">
                                        {{ data.dropdown_pick_ym }}
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <label for="inputEmail3" class="col-1 col-form-label">Kelas</label>
                                    <div class="col-2">
                                    <select class="form-select my-1 my-md-0" id="rombel_pick">
                                        <?php
                                        foreach ($data->list_rombel as $k => $v) {
                                            $selected = ($v == $data->rombel_pick) ? " selected " : "";
                                            echo "<option $selected value='$v'>$v</option>";
                                        }
                                        ?>
                                    </select>
                                    </div>
                                </div>
                            </form>
                        </div>

                    </div><!-- end col-->
                 <div id="table-scroll" class="table-scroll">
                  <div class="table-wrap">
                <div class="table-responsive tableresabsen">

                <?php 
                // echo json_encode($data->absen_by_nisn_tgl_absen_datang); 
                ?>

                <table class="table table-bordered tableabsent main-table clone">
                        <thead>
                            <tr>
                                <th rowspan="2" class="text-center fixed-side">No</th>
                                <th rowspan="2" class="fixed-side">Nama</th>
                                <th colspan="{{data.days}}" class="text-center">
                                    <?php echo $data->pick_ym_title; ?>
                                </th>
                            </tr>
                            <tr>
                                <?php
                                for ($x = 1; $x <= $data->days; $x++) {
                                    $day = (strlen($x) == 1) ? '0'.$x : $x;
                                    ?>
                                    <th class="text-center" style="cursor: pointer;"><?php echo $day; ?></th>
                                    <?php
                                }
                                ?>
                            </tr>
                        </thead>
                        <tbody>
                        <?php
                        $no=1;
                        foreach ($data->siswa as $k => $v) {
                        ?>
                        <tr>
                            <td class="text-center fixed-side"><?php echo $no; ?></td>
                            <td class="fixed-side">
                                <a href="#"><?php echo strtoupper($v->nisn); ?> - <?php echo strtoupper($v->nama_lengkap); ?></a>
                            </td>

                            <?php
                            $data_part = $data->date_part;
                            for ($x = 1; $x <= $data->days; $x++) {
                                
                                $day = (strlen($x) == 1) ? '0'.$x : $x;
                                $date = $data_part[0].'-'.$data_part[1].'-'.$day;
                                $datetime = DateTime::createFromFormat('Y-m-d', $date);

                                $background = '';

                                if (in_array($datetime->format('D'),['Sat','Sun'])) {
                                    $background = ' style="background-color: #ebebeb" ';
                                }
                                
                                // datang
                                if (strlen($data->absen_by_nisn_tgl_absen_datang[$v->nisn.'_'.$date]) > 0) {
                                    $jam_datang_part = explode('_',$data->absen_by_nisn_tgl_absen_datang[$v->nisn.'_'.$date]);

                                    if ($jam_datang_part[1] == 'telat') {
                                        $status='bg-danger';
                                    }
                                    else {
                                        $status='bg-success';    
                                    }

                                    $jam_datang='D '.$jam_datang_part[0];
                                }
                                else {
                                    $jam_datang='';
                                    $status='';
                                }

                                // pulang
                                if (strlen($data->absen_by_nisn_tgl_absen_pulang[$v->nisn.'_'.$date]) > 0) {
                                    $jam_pulang_part = explode('_',$data->absen_by_nisn_tgl_absen_pulang[$v->nisn.'_'.$date]);
                                    
                                    if ($jam_pulang_part[1] == 'telat') {
                                        $status_pulang='bg-danger';
                                    }
                                    else {
                                        $status_pulang='bg-success';    
                                    }

                                    $jam_pulang='P '.$jam_pulang_part[0];
                                }
                                else {
                                    $jam_pulang='';
                                    $status_pulang='';
                                }


                                
                                ?>
                                <td class="text-center abcent" <?php echo $background; ?>>
                                    <?php
                                    if (strlen($jam_datang) > 0) {
                                        ?>
                                        <span class="badge <?php echo $status; ?> float-end mb-1">
                                            <?php echo $jam_datang; ?>
                                        </span>
                                        <?php
                                    }
                                    else {

                                    }
                                    ?>
                                    <?php
                                    if (strlen($jam_pulang) > 0) {
                                        ?>
                                        <span class="badge <?php echo $status_pulang; ?> float-end">
                                            <?php echo $jam_pulang; ?>
                                        </span>
                                        <?php
                                    }
                                    else {

                                    }
                                    ?>
                                </td>
                                <?php
                            }
                            ?>


                        </tr>
                        <tr>
                        <?php
                            $no++;
                        }
                        ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
{% endblock %}