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
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-6">

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Sekolah</label>
                                {{data.dropdown_sekolah}}
                            </div>

                            <div class="mb-3">
                                <label for="tingkat" class="form-label">Tingkat Kelas</label>
                                {{data.dropdown_tingkat}}
                            </div>

                            <div class="mb-3">
                                <label for="mapel" class="form-label">Mata Pelajaran</label>
                                {{data.dropdown_mapel}}
                            </div>
                            
                            <div class="mb-3">
                                <label for="soal_text" class="form-label">Soal</label>
                                <textarea 
                                    class="form-control" 
                                    id="soal_text" 
                                    name="soal_text" 
                                    rows="5"></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="soal_foto" class="form-label">Soal Gambar</label>
                                <input type="file" name="soal_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="soal_bobot" class="form-label">Bobot</label>
                                <input 
                                    type="number" 
                                    name="soal_bobot" 
                                    id="soal_bobot" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab1_text" class="form-label">Jawaban A : Text</label>
                                <input 
                                    type="text" 
                                    name="jawab1_text" 
                                    id="jawab1_text" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab1_foto" class="form-label">Jawaban A : Gambar</label>
                                <input type="file" name="jawab1_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="jawab2_text" class="form-label">Jawaban B : Text</label>
                                <input 
                                    type="text" 
                                    name="jawab2_text" 
                                    id="jawab2_text" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab2_foto" class="form-label">Jawaban B : Gambar</label>
                                <input type="file" name="jawab2_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="jawab3_text" class="form-label">Jawaban C : Text</label>
                                <input 
                                    type="text" 
                                    name="jawab3_text" 
                                    id="jawab3_text" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab3_foto" class="form-label">Jawaban C : Gambar</label>
                                <input type="file" name="jawab3_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="jawab4_text" class="form-label">Jawaban D : Text</label>
                                <input 
                                    type="text" 
                                    name="jawab4_text" 
                                    id="jawab4_text" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab4_foto" class="form-label">Jawaban D : Gambar</label>
                                <input type="file" name="jawab4_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="jawab5_text" class="form-label">Jawaban E : Text</label>
                                <input 
                                    type="text" 
                                    name="jawab5_text" 
                                    id="jawab5_text" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="jawab5_foto" class="form-label">Jawaban E : Gambar</label>
                                <input type="file" name="jawab5_foto" data-plugins="dropify" data-max-file-size="5M"  />                              
                            </div>

                            <div class="mb-3">
                                <label for="mapel" class="form-label">Jawaban Benar</label>
                                {{data.dropdown_jawaban_benar}}
                            </div>

                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan Data</button>
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