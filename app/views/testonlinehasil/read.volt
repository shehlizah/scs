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
                    <form
                        class="form"
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-10">
                            <div class="mb-3">


                                <table class="table table-bordered mb-0">
                                    <tbody>
                                        <tr>
                                            <th scope="row">Sekolah</th>
                                            <td>{{data.row.sekolah}}</td>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row">Tingkat</th>
                                            <td>
                                                {{data.row.tingkat}}
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Mata Pelajaran</th>
                                            <td>{{data.mapel}}</td>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row">Soal Text</th>
                                            <td>
                                                <?php echo str_replace("\n", '<br />',  $data->row->soal_text); ?>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Soal Gambar</th>
                                            <td>{{data.soal_foto}}</td>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row">Bobot</th>
                                            <td>{{data.row.soal_bobot}}</td>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban A - Text</th>
                                            <td>{{data.row.jawab1_text}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban A - Foto</th>
                                            <td>{{data.jawab1_foto}}</td>
                                        </tr>
                                        
                                        <tr>
                                            <th scope="row">Jawaban B - Text</th>
                                            <td>{{data.row.jawab2_text}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban B - Foto</th>
                                            <td>{{data.jawab2_foto}}</td>
                                        </tr>

                                        <tr>
                                            <th scope="row">Jawaban C - Text</th>
                                            <td>{{data.row.jawab3_text}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban C - Foto</th>
                                            <td>{{data.jawab3_foto}}</td>
                                        </tr>

                                        <tr>
                                            <th scope="row">Jawaban D - Text</th>
                                            <td>{{data.row.jawab4_text}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban D - Foto</th>
                                            <td>{{data.jawab4_foto}}</td>
                                        </tr>

                                        <tr>
                                            <th scope="row">Jawaban E - Text</th>
                                            <td>{{data.row.jawab5_text}}</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Jawaban E - Foto</th>
                                            <td>{{data.jawab5_foto}}</td>
                                        </tr>

                                        <tr>
                                            <th scope="row">Jawaban Benar</th>
                                            <td>{{data.jawab_benar}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                               <a 
                                href="/<?php echo $page->access->resources_name; ?>" 
                                class="btn btn-secondary waves-effect waves-light">Kembali</a> 
                                <a 
                                href="/banksoal/edit/{{data.row.id}}" 
                                class="btn btn-success waves-effect waves-light">Edit Soal</a>
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