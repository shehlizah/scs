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
<style>
#map {
    width: 100%;
    height: calc(85vh - 85px);
}    
</style>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                {{ flashSession.output() }}
                <div class="row mb-2">
                    <div class="col-sm-12">
                        <h4 class="header-title">Periode</h4>
                        <form method="GET" class="row g-3">
                            <div class="col-xl-2 col-md-3">
                                {{data.dropdown_pickym}}
                            </div>
                            
                        </form>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>

                <style>
                .table-sm>:not(caption)>*>* {
                padding: .3rem .3rem;
                }                    
                </style>
                    <br/>
                    <h4 class="page-title">Monitoring Perekaman Wajah Siswa</h4>
                    <table class="table table-bordered tableabsent main-table clone table-sm mb-0">
                        <thead>
                            <tr>
                                <th rowspan="2" class="text-center fixed-side">No</th>
                                <th rowspan="2" class="fixed-side">Sekolah</th>
                                <th rowspan="2" class="fixed-side">Total Siswa</th>
                                <th colspan="{{data.days}}" class="text-center">
                                    <?php 
                                    echo $data->pick_ym_title; 
                                    ?>
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
                        
                        // echo json_encode($data->idx_hearbeat_sekolah_tgl);
                        $total = 0;
                        foreach ($data->list_sekolah as $k => $v) {
                        ?>
                        <tr>
                            <td class="text-center fixed-side"><?php echo $no; ?></td>
                            <td class="fixed-side">
                                <a href="#"><?php echo strtoupper($v->sekolah); ?></a>
                            </td>
                            <td class="text-center">
                                <span class="small"><?php echo $data->ar_siswa_per_sekolah[$v->sekolah]; ?></span>
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
                                
                                if ($date <= date('Y-m-d')) {

                                // datang
                                if (strlen($data->idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$date]['total_siswa']) > 0) {
                                    $maintenance = '<span class="small">'.$data->idx_hearbeat_sekolah_tgl[$v->sekolah.'__'.$date]['total_siswa_fr'].'</small>';
                                    $perhari = 1;
                                }
                                else {
                                    $maintenance = '<span class="badge bg-danger">&nbsp;</span>';
                                    $perhari = 0;
                                }

                                ?>
                                <td class="text-center abcent" <?php echo $background; ?>>
                                    <?php echo $maintenance; ?>
                                </td>
                                <?php
                                }
                                else {
                                    ?>
                                    <td class="text-center abcent" <?php echo $background; ?>>
                                        
                                    </td>
                                    <?php
                                }
                            }
                            ?>


                        </tr>
                        <tr>
                        <?php
                            $total += $total + $perhari;
                            $no++;
                        }

                        // echo json_encode($idx_sekolah_tgl);
                        ?>                        
                        </tbody>
                    </table>
            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

{% endblock %}