        <!-- third party js -->
        <script src="/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="/assets/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
        <script src="/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="/assets/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
        <script src="/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="/assets/libs/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
        <script src="/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="/assets/libs/datatables.net-buttons/js/buttons.flash.min.js"></script>
        <script src="/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="/assets/libs/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
        <script src="/assets/libs/datatables.net-select/js/dataTables.select.min.js"></script>
        <script src="/assets/libs/pdfmake/build/pdfmake.min.js"></script>
        <script src="/assets/libs/pdfmake/build/vfs_fonts.js"></script>
        <!-- third party js ends -->
<script>
var table;
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    //$.fn.dataTable.ext.errMode = 'none';
	
    table = $('#dataRows').DataTable({
		"processing": true, //Feature control the processing indicator.
		"serverSide": true, //Feature control DataTables' server-side processing mode.
		"responsive": true,
		"ajax": {
			"url": "/accessroles/index/all_data",
			"type": "GET"
		},
		columns: [
			{
				data: null,
				orderable: false,
				searchable: false
			},
			{data: "resources_name"},
			{data: "access_name"},
			{
				data: "access_title",
				orderable: false,
				searchable: true
			}
		],
		"columnDefs": [
			{
				"targets":0,
				"render": function(data, type, row, meta){
					var link_edit=`<a href='/accessroles/winedit/`+row.resources_name+`/`+row.access_name+`' class="show_modal" title="Edit"><i class="fe-edit"></i></a>`; 
                    var link_del=`<a href='/accessroles/index/delete?controller=`+row.resources_name+`&method=`+row.access_name+`' 
						uid="`+row.resources_name+`/`+row.access_name+`" 
						title="Hapus Data: `+row.access_title+`" 
						text="Data Controller `+row.resources_name+` Method `+row.access_name+` akan dihapus" 
						class="xhr_delete" table="#dataRows" title="Delete"><i class="fe-trash-2"></i></a>`; 
                        
                    return link_edit + link_del;
				}
			},
		],
		"language": {
				"lengthMenu": "_MENU_"
		},
		"lengthMenu": [
            [50, 100, 200, -1],
            [50, 100, 200, 'All'],
        ],
		"order": [[ 1, 'asc' ]],
	});
});

	$(document).on("click", ".show_modal", function () {
		event.preventDefault();
		var url = $(this).attr('href');
		$('.modal-content').empty();
		$('.modal-content').load(url);
		$('#myModal').modal('show');
	});
        
	$(document).on('click',".xhr_delete", function(){
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
							title: "Data berhasil dihapus :)",
							showConfirmButton: false,
							timer: 1500
						});
						$(refresh_table).DataTable().ajax.reload();
						} 
						else {
							Swal.fire({
								// position: "top-right",
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