<script>
var table;
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    $.fn.dataTable.ext.errMode = "none";
	
    table = $('#dataRows').DataTable({
		"processing": true, //Feature control the processing indicator.
		"serverSide": true, //Feature control DataTables' server-side processing mode.
		"responsive": true,
		"ajax": {
			"url": "/{{page.access.resources_name}}/index/all_data",
			"type": "GET"
		},
		columns: [
			{
				data: null,
				orderable: false,
				searchable: false
			},
			{data: "sekolah"},
			{data: "nisn"},
			{data: "nama_lengkap"},
			{data: "tgl_request"},
			{data: "request_type"},
			{data: "status_type"},
		],
		"columnDefs": [
			{
				"targets":0,
				"render": function(data, type, row, meta){
					var link_edit=`<a href="/{{page.access.resources_name}}/edit/`+row.id+`" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>`;
                    var link_del=`<a href='/{{page.access.resources_name}}/index/delete?uid=`+row.id+`' 
						uid="`+row.id+`" 
						title="Hapus Data Siswa : `+row.nisn+`" 
						text="Data Siswa `+row.nisn+` - `+row.nama_lengkap+` akan dihapus" 
						class="action-icon xhr_delete" 
						table="#dataRows" 
						title="Delete"><i class="mdi mdi-delete"></i></a>`; 
                        
                    return link_edit;
				}
			},
			// {
			// 	"targets": 6,
			// 	"render": function(data, type, row, meta){
			// 		if(row.file_surat != null) {
			// 			var file_surat=`
			// 			<a href="https://api.disdiksulsel.id/`+row.file_surat+`" target="_blank">
			// 				Lihat Surat
			// 			</a>
			// 			`;
			// 		}

			// 		return file_surat;
			// 	}
			// },
			{
                    "searchable": false,
                    "orderable": false,
                    "targets": 0
			},		
			// {
            //         "searchable": true,
            //         "orderable": false,
            //         "targets": [1,2,4,5,6,7]
			// }		
		],
		"language": {
				"lengthMenu": "_MENU_"
		},
		"lengthMenu": [
            [50, 100, -1],
            [50, 100, 'All'],
        ],
		"order": [[ 4, 'desc' ]],
	});
});

	$(document).on("click", ".show_modal", function () {
		event.preventDefault();
		var url = $(this).attr('href');
		$('.modal-content').empty();
		$('.modal-content').load(url);
		$('#myModal').modal('show');
	});
        
	$(document).on('click',".xhr_delete", function() {
		event.preventDefault();
		console.log($(this).val());

		var uid=$(this).attr('uid');
		var url_del=$(this).attr('href');
		var refresh_table=$(this).attr('table');

		Swal.fire({
			title: $(this).attr('title'),
		text: $(this).attr('text'),
			icon: "warning",
			showCancelButton: true,
			cancelButtonText: "Batal",
			confirmButtonText: "Hapus"
		}).then(function(result) {
			if (result.value) {
				console.log('url hapus ajax : ' + url_del);
				$.ajax({
					url: url_del,
					type: 'GET',
					success: function (out) {
						if(out.status == 1){
							Swal.fire({
								// position: "top-right",
								icon: "success",
								title: out.message,
								showConfirmButton: false,
								timer: 1500
							});
							$(refresh_table).DataTable().ajax.reload();
						} 
						else {
							Swal.fire({
								icon: "error",
								title: out.message,
								showConfirmButton: false,
								timer: 1500
							});
							console.log(out.error);
							console.log(out.message);
						}
					},
					cache: false,
					processData: false
				});
			}
		});
	});
</script>