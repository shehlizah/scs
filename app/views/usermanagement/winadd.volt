<form 
    class="form" 
    id="frm_dokumen" 
    method="POST" 
    action="/usermanagement/index/simpan_user"
    enctype="multipart/form-data">
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Tambah User Login Aplikasi</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
        <div class="card-body">

            <div class="mb-3">
                <label for="jumlah_wanita" class="form-label">Roles</label>
                <div class="row">
                    <div class="col-lg-12">
                        {{ data.list_roles }}
                    </div>
                </div>
            </div>

            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input 
                    type="text" 
                    name="username" 
                    id="username" 
                    value="" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input 
                    type="text" 
                    name="password" 
                    id="password" 
                    value="" 
                    class="form-control"
                    required>
            </div>
            
            <div class="mb-3">
                <label for="fullname" class="form-label">Fullname</label>
                <input 
                    type="text" 
                    name="fullname" 
                    id="fullname" 
                    value="" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input 
                    type="text" 
                    name="email" 
                    id="email" 
                    value="" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="no_whatsapp" class="form-label">Nomor Whatsapp Aktif</label>
                <input 
                    type="text" 
                    name="no_whatsapp" 
                    id="no_whatsapp" 
                    value="" 
                    class="form-control"
                    required>
            </div>

        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Tutup</button>
        <button type="submit" class="btn btn-primary font-weight-bold">Simpan User</button>
    </div>
</form>
<script>
    $('#mySelect2').select2({
        dropdownParent: $('#myModal')
    });    
    $("form#frm_dokumen").submit(function(e) {
        e.preventDefault();    
        var formData = new FormData(this);

        $.ajax({
            url: "/usermanagement/index/simpan_user",
            type: 'POST',
            data: formData,
            success: function (out) {
                if(out.status == 1){
                    $('#myModal').modal('hide');
                    Swal.fire({
                        // position: "top-end",
                        icon: "success",
                        title: out.message,
                        showConfirmButton: false,
                        timer: 1500
                    });
                    $("#dataRows").DataTable().ajax.reload(); 
                } else {
                    console.log(out.error);
                    console.log(out.message);
                    Swal.fire({
                        // position: "top-right",
                        icon: "error",
                        title: out.message,
                        showConfirmButton: false,
                        timer: 1500
                    });                    
                }           
            },
            cache: false,
            contentType: false,
            processData: false
        });
    });

    $('#tgl_dokumen').datepicker({
        format: 'dd/mm/yyyy',
        todayBtn: "linked",
        clearBtn: true,
        todayHighlight: true
    });
</script>