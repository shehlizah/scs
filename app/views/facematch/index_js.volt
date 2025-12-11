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
			"url": "/{{page.access.resources_name}}/index/all_data",
			"type": "GET"
		},
		columns: [
			{
				data: null,
				orderable: false,
				searchable: false
			},
			{data: "shot_time_1"},
			{data: "type"},
			{data: "image64"},
			{data: "nis"},
			{data: "image64_match"},
		],
		"columnDefs": [
			{
				"targets":0,
				"render": function(data, type, row, meta){
					var link_del=`<a 
                        href='/{{page.access.resources_name}}/byid/`+row.id+`'
						class="btn width-xs btn-success waves-effect waves-light">cek</a>`;
                    return link_del;
				}
			},
            {
				"targets": 3,
				"render": function(data, type, row, meta){
					var image64=`-`;

					if(row.image64 != null) {
						image64=`
						<img witdh="100" src="data:image/png;base64,`+row.image64+`" alt="" style="margin-right: 0px; max-width: 100px;">
						`;
					}

					return image64;
				}
			},
            {
				"targets": 4,
				"render": function(data, type, row, meta){
					var image_path_2=`-`;

					if(row.image_path_2 != null) {
						image_path_2=`
						<img witdh="100" src="/`+row.image_path_2+`" alt="" style="margin-right: 0px; max-width: 100px;">
						`;
					}

					return image_path_2;
				}
			},
            {
                "searchable": false,
                "orderable": false,
                "targets": [3,4,5]
			},
            {
                "searchable": true,
                "orderable": false,
                "targets": [2]
			}
		],
		"language": {
				"lengthMenu": "_MENU_"
		},
		"lengthMenu": [
            [50, 100, 200, -1],
            [50, 100, 200, 'All'],
        ],
		"order": [[ 1, 'desc' ]],
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