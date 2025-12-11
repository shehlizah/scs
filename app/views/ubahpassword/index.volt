<form 
    class="form" 
    id="frm_ubahpassword" 
    method="POST" 
    action="/tickets/index/simpan_binaan"
    enctype="multipart/form-data">
    <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Ubah Password</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body">
        <div class="card-body">

            <div class="mb-3">
                <label for="password_lama" class="form-label">Password Lama</label>
                <input 
                    type="text" 
                    name="password_lama" 
                    id="password_lama" 
                    value="" 
                    class="form-control"
                    required>
            </div>
            
            <div class="mb-3">
                <label for="password_baru" class="form-label">Password Baru</label>
                <input 
                    type="text" 
                    name="password_baru" 
                    id="password_baru" 
                    value="" 
                    class="form-control"
                    required>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">Tutup</button>
        <button type="submit" class="btn btn-primary font-weight-bold">Simpan Password</button>
    </div>
</form>
<script>
    $("form#frm_ubahpassword").submit(function(e) {
        e.preventDefault();    
        var formData = new FormData(this);

        $.ajax({
            url: "/api/changepassword",
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
					})
                } 
				else {
                    console.log(out.error);
                    console.log(out.message);

					Swal.fire({
						// position: "top-end",
						icon: "error",
						title: out.message,
						showConfirmButton: false,
						timer: 1500
					})
                }                
            },
            cache: false,
            contentType: false,
            processData: false
        });
    });
</script>