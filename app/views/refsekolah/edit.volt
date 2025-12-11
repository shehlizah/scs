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
                        <div class="col-lg-6">

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Kabupaten/Kota</label>
                                {{data.dropdown_kabkota}}
                            </div>

                            <div class="mb-3">
                                <label for="sekolah" class="form-label">Nama Sekolah</label>
                                <input 
                                    type="text" 
                                    name="sekolah" 
                                    id="sekolah" 
                                    class="form-control" 
                                    value="{{ data.row.sekolah }}"
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="map_lat" class="form-label">Titik Latitude</label>
                                <input 
                                    type="text" 
                                    name="map_lat" 
                                    id="map_lat" 
                                    class="form-control" 
                                    value="{{ data.row.map_lat }}"
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="map_lng" class="form-label">Titik Longitude</label>
                                <input 
                                    type="text" 
                                    name="map_lng" 
                                    id="map_lng" 
                                    class="form-control" 
                                    value="{{ data.row.map_lng }}"
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="alamat" class="form-label">Alamat</label>
                                <input 
                                    type="text" 
                                    name="alamat" 
                                    id="alamat" 
                                    class="form-control" 
                                    value="{{ data.row.alamat }}"
                                    
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="no_telp" class="form-label">No. Telp</label>
                                <input 
                                    type="text" 
                                    name="no_telp" 
                                    id="no_telp" 
                                    class="form-control" 
                                    value="{{ data.row.no_telp }}"
                                    
                                    >
                            </div>

                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-info waves-effect waves-light">Simpan</button>
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