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
                            <h5 class="text-uppercase bg-light p-2 mt-0 mb-3">SCS Identity</h5>
                            <div class="mb-3">
                                <label for="scs_sekolah" class="form-label">Nama Sekolah</label>
                                <input 
                                    type="text" 
                                    name="scs_sekolah" 
                                    id="scs_sekolah" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('scs_sekolah')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="scs_ip_server_lokal" class="form-label">IP Server Lokal</label>
                                <input 
                                    type="text" 
                                    name="scs_ip_server_lokal" 
                                    id="scs_ip_server_lokal" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('scs_ip_server_lokal')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="scs_jam_datang" class="form-label">Jam Datang</label>
                                <input 
                                    type="text" 
                                    name="scs_jam_datang" 
                                    id="scs_jam_datang" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('scs_jam_datang')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="scs_jam_pulang" class="form-label">Jam Pulang</label>
                                <input 
                                    type="text" 
                                    name="scs_jam_pulang" 
                                    id="scs_jam_pulang" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('scs_jam_pulang')->value; ?>" 
                                    required
                                    >
                            </div>

                            <h5 class="text-uppercase bg-light p-2 mt-0 mb-3">SCS NVR</h5>
                            
                            <div class="mb-3">
                                <label for="nvr_ip" class="form-label">IP NVR</label>
                                <input 
                                    type="text" 
                                    name="nvr_ip" 
                                    id="nvr_ip" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('nvr_ip')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="nvr_password" class="form-label">Password User apiadmin</label>
                                <input 
                                    type="text" 
                                    name="nvr_password" 
                                    id="nvr_password" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('nvr_password')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nvr_user1_password" class="form-label">Password User user1</label>
                                <input 
                                    type="text" 
                                    name="nvr_user1_password" 
                                    id="nvr_user1_password" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('nvr_user1_password')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nvr_user2_password" class="form-label">Password User user2</label>
                                <input 
                                    type="text" 
                                    name="nvr_user2_password" 
                                    id="nvr_user2_password" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('nvr_user2_password')->value; ?>" 
                                    required
                                    >
                            </div>

                            <h5 class="text-uppercase bg-light p-2 mt-0 mb-3">SCS CCTV DATANG</h5>
                            
                            <div class="mb-3">
                                <label for="cctv_datang_ip" class="form-label">IP CCTV Datang</label>
                                <input 
                                    type="text" 
                                    name="cctv_datang_ip" 
                                    id="cctv_datang_ip" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_ip')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="cctv_datang_ch" class="form-label">Channel CCTV Datang</label>
                                <input 
                                    type="number" 
                                    name="cctv_datang_ch" 
                                    id="cctv_datang_ch" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_ch')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="cctv_datang_username" class="form-label">CCTV Datang API Username</label>
                                <input 
                                    type="text" 
                                    name="cctv_datang_username" 
                                    id="cctv_datang_username" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_username')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="cctv_datang_password" class="form-label">CCTV Datang API Password</label>
                                <input 
                                    type="text" 
                                    name="cctv_datang_password" 
                                    id="cctv_datang_password" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_password')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="cctv_datang_capture_start" class="form-label">Jam Awal Pengambilan Wajah CCTV Datang</label>
                                <input 
                                    type="text" 
                                    name="cctv_datang_capture_start" 
                                    id="cctv_datang_capture_start" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_capture_start')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="cctv_datang_capture_end" class="form-label">Jam Akhir Pengambilan Wajah CCTV Datang</label>
                                <input 
                                    type="text" 
                                    name="cctv_datang_capture_end" 
                                    id="cctv_datang_capture_end" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_datang_capture_end')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <h5 class="text-uppercase bg-light p-2 mt-0 mb-3">SCS CCTV Pulang</h5>
                            
                            <div class="mb-3">
                                <label for="cctv_pulang_ip" class="form-label">IP CCTV Pulang</label>
                                <input 
                                    type="text" 
                                    name="cctv_pulang_ip" 
                                    id="cctv_pulang_ip" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_ip')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="cctv_pulang_ch" class="form-label">Channel CCTV Pulang</label>
                                <input 
                                    type="number" 
                                    name="cctv_pulang_ch" 
                                    id="cctv_pulang_ch" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_ch')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="cctv_pulang_username" class="form-label">CCTV Pulang API Username</label>
                                <input 
                                    type="text" 
                                    name="cctv_pulang_username" 
                                    id="cctv_pulang_username" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_username')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="cctv_pulang_password" class="form-label">CCTV Pulang API Password</label>
                                <input 
                                    type="text" 
                                    name="cctv_pulang_password" 
                                    id="cctv_pulang_password" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_password')->value; ?>" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="cctv_pulang_capture_start" class="form-label">Jam Awal Pengambilan Wajah CCTV Pulang</label>
                                <input 
                                    type="text" 
                                    name="cctv_pulang_capture_start" 
                                    id="cctv_pulang_capture_start" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_capture_start')->value; ?>" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="cctv_pulang_capture_end" class="form-label">Jam Akhir Pengambilan Wajah CCTV Pulang</label>
                                <input 
                                    type="text" 
                                    name="cctv_pulang_capture_end" 
                                    id="cctv_pulang_capture_end" 
                                    class="form-control" 
                                    value="<?php echo Config::findFirstByKey('cctv_pulang_capture_end')->value; ?>" 
                                    required
                                    >
                            </div>

                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary waves-effect waves-light">Simpan</button>
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