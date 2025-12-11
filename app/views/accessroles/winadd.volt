<form 
    class="form" 
    id="frm_dokumen" 
    method="POST" 
    action=""
    enctype="multipart/form-data">
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Tambah Access</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
        <div class="card-body">
            <div class="mb-3">
                <label for="resources_name" class="form-label">Controller</label>
                <input 
                    type="text" 
                    name="resources_name" 
                    id="resources_name" 
                    value="" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="access_name" class="form-label">Method</label>
                <input 
                    type="text" 
                    name="access_name" 
                    id="access_name" 
                    value="" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="access_title" class="form-label">Title</label>
                <input 
                    type="text" 
                    name="access_title" 
                    id="access_title" 
                    value="" 
                    class="form-control"
                    required>
            </div>

        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Tutup</button>
        <button type="submit" class="btn btn-primary font-weight-bold">Tambah Access Roles</button>
    </div>
</form>
<script>
    $("form#frm_dokumen").submit(function(e) {
        e.preventDefault();    
        var formData = new FormData(this);

        $.ajax({
            url: "/accessroles/index/simpan",
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
</script>