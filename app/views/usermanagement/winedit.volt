<form 
    class="form" 
    id="frm_dokumen" 
    method="POST" 
    action="/usermanagement/index/update_user"
    enctype="multipart/form-data">
    <input type="hidden" name="user_id" value="{{ data.row.id }}"/>
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Update User Login Aplikasi</h5>
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
                    value="{{ data.row.username }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password (isi jika akan ubah password)</label>
                <input 
                    type="text" 
                    name="password" 
                    id="password" 
                    value="" 
                    class="form-control"
                    >
            </div>
            
            <div class="mb-3">
                <label for="password" class="form-label">Status Aktif</label>
                <div class="form-check">
                    <input type="radio" id="active" name="status" class="form-check-input" value="1" {{ data.status_active }}>
                    <label class="form-check-label" for="active">Active</label>
                </div>
                <div class="form-check">
                    <input type="radio" id="not_active" name="status" class="form-check-input" value="0" {{ data.status_not_active }}>
                    <label class="form-check-label" for="not_active">Not Active</label>
                </div>
            </div>
            
            <div class="mb-3">
                <label for="fullname" class="form-label">Fullname</label>
                <input 
                    type="text" 
                    name="fullname" 
                    id="fullname" 
                    value="{{ data.row.fullname }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input 
                    type="text" 
                    name="email" 
                    id="email" 
                    value="{{ data.row.email }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="no_whatsapp" class="form-label">Nomor Whatsapp Aktif</label>
                <input 
                    type="text" 
                    name="no_whatsapp" 
                    id="no_whatsapp" 
                    value="{{ data.row.no_whatsapp }}" 
                    class="form-control"
                    >
            </div>

        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Tutup</button>
        <button type="submit" class="btn btn-primary font-weight-bold">Update User</button>
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
            url: "/usermanagement/index/update_user",
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