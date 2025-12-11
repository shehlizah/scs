<form 
    class="form" 
    id="frm_dokumen" 
    method="POST" 
    action="/menu/index/update_menu"
    enctype="multipart/form-data">
    <input type="hidden" name="menu_id" id="menu_id" value="{{ data.row.menu_id }}">
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Edit Menu</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
        <div class="card-body">
            <div class="mb-3">
                <label for="menu_title" class="form-label">Menu Title</label>
                <input 
                    type="text" 
                    name="menu_title" 
                    id="menu_title" 
                    value="{{ data.row.menu_title }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="resources_name" class="form-label">Class Controller</label>
                <input 
                    type="text" 
                    name="resources_name" 
                    id="resources_name" 
                    value="{{ data.row.resources_name }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="access_name" class="form-label">Method Controller</label>
                <input 
                    type="text" 
                    name="access_name" 
                    id="access_name" 
                    value="{{ data.row.access_name }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="icon" class="form-label">Icon</label>
                <input 
                    type="text" 
                    name="icon" 
                    id="icon" 
                    value="{{ data.row.icon }}" 
                    class="form-control"
                    required>
            </div>

            <div class="mb-3">
                <label for="description" class="form-label">Description</label>
                <input 
                    type="text" 
                    name="description" 
                    id="description" 
                    value="{{ data.row.description }}" 
                    class="form-control"
                    required>
            </div>

        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Tutup</button>
        <button type="submit" class="btn btn-primary font-weight-bold">Simpan Menu</button>
    </div>
</form>
<script>
    $("form#frm_dokumen").submit(function(e) {
        e.preventDefault();    
        var formData = new FormData(this);

        $.ajax({
            url: "/menu/index/update_menu",
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