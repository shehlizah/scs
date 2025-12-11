{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box">
            <div class="page-title-right">
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
                <div class="row">
                    {{ flashSession.output() }}
                    <form
                        class="form"
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}/{{data.row.id}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <input type="hidden" name="id_test" value="{{data.row.id}}" />
                        <div class="col-lg-10">

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="mapel" class="form-label">Mata Pelajaran</label>
                                {{data.dropdown_mapel}}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Tingkat Kelas</label>
                                {{data.dropdown_tingkat}}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Rombel</label>
                                {{data.dropdown_rombel}}
                            </div>

                            <div class="mb-3">
                                <label for="tgl_test" class="form-label">Tanggal Test</label>
                                <div class="input-group">
                                    <input 
                                        type="text" 
                                        name="tgl_test" 
                                        id="tgl_test" 
                                        class="form-control datepicker_dmy" 
                                        value="{{data.row.tgl_test}}" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-calendar-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="jam_mulai" class="form-label">Jam Mulai</label>
                                <div class="input-group clockpicker" data-placement="top" data-align="top" data-autoclose="true">
                                    <input 
                                        type="text" 
                                        name="jam_mulai" 
                                        id="jam_mulai" 
                                        class="form-control" 
                                        value="<?php echo substr($data->row->jam_mulai, 0, 5); ?>" 
                                        required>
                                    <span class="input-group-text"><i class="mdi mdi-clock-outline"></i></span>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="soal_bobot" class="form-label">Durasi</label>
                                {{data.dropdown_durasi}}
                            </div>

                            <h4>List Soal</h4>
                                <div class="col-lg-12">
                                    <div class="mb-3">


                                        <table class="table table-bordered mb-0">
                                            <tbody>                            
                        <?php
                        if (count($data->list_soal) > 0) {
                            $nomor = 1;
                            foreach ($data->list_soal as $k => $v) {
                                ?>


                                                <tr>
                                                    <th scope="row"><?php echo $nomor; ?></th>
                                                    <td>
                                                    <?php echo $v->soal_text; ?>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"></th>
                                                    <td>
                                                        <input type="radio" id="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>A" name="soal<?php echo '['.$v->id; ?>]" value="A" required>
                                                        <label for="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>A">A. <?php echo $v->jawab1_text; ?></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"></th>
                                                    <td>
                                                        <input type="radio" id="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>B" name="soal<?php echo '['.$v->id; ?>]" value="B">
                                                        <label for="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>B">B. <?php echo $v->jawab2_text; ?></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"></th>
                                                    <td>
                                                        <input type="radio" id="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>C" name="soal<?php echo '['.$v->id; ?>]" value="C">
                                                        <label for="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>C">C. <?php echo $v->jawab3_text; ?></label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row"></th>
                                                    <td>
                                                        <input type="radio" id="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>D" name="soal<?php echo '['.$v->id; ?>]" value="D">
                                                        <label for="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>D">D. <?php echo $v->jawab4_text; ?></label>
                                                    </td>
                                                </tr>
                                                <?php
                                                if (strlen($v->jawab5_text) > 1) {
                                                    ?>
                                                    <tr>
                                                        <th scope="row"></th>
                                                        <td>
                                                            <input type="radio" id="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>E" name="soal_<?php echo $v->id_mapel.'['.$v->id; ?>]" value="E">
                                                            <label for="soal_<?php echo $v->id_mapel.'_'.$v->id; ?>E">E. <?php echo $v->jawab5_text; ?></label>
                                                        </td>
                                                    </tr>`                                                  
                                                    <?php

                                                }
                                                ?>
                                <?php
                                $nomor ++;
                            }
                        }
                        ?>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan dan Pilih Soal</button>
                                <a href="/<?php echo $page->access->resources_name; ?>" class="btn btn-secondary waves-effect waves-light">Batal Simpan</a>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- end row-->
            </div> <!-- end card-body -->
        </div> <!-- end card -->
    </div><!-- end col -->
</div>
<!-- end row -->
{% endblock %}