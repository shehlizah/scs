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
function savi(){
    var v=$('#micon');
    if(v.val() != ''){
        $.post('/menu/index/savi_icon',{ic:v.val()},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                alert('ok');
            }else{
                alert(rs.error.message);
            }
            v.val('')
        });
        console.log(v.val());
    }
}
var table;
$(function(){
	//$.fn.dataTableExt.sErrMode = 'throw';
    //$.fn.dataTable.ext.errMode = 'none';
	
    table = $('#dataRows').DataTable({
		"processing": true, //Feature control the processing indicator.
		"serverSide": true, //Feature control DataTables' server-side processing mode.
		"responsive": true,
		"ajax": {
			"url": "/menu/index/all_data",
			"type": "GET"
		},
		columns: [
			{
				data: null,
				orderable: false,
				searchable: false
			},
			{data: "menu_order"},
			{data: "menu_title"},
			{
				data: "icon",
				orderable: false,
				searchable: true,
				render: function (data, type, row, meta) {
					return '<i class="'+row.icon+'"></i>';
				}
			},
			{
				data: "resources_name",
				searchable: true,
				render: function (data, type, row, meta) {
					return row.resources_name+"/"+row.access_name;
				}
			},
			{
				data: "description",
				orderable: false,
				searchable: true
			}
		],
		"columnDefs": [
			{
				"targets":0,
				"render": function(data, type, row, meta){
					var link_edit=`<a href='/menu/winedit/`+row.menu_id+`' class="show_modal" title="Edit Menu"><i class="fe-edit"></i></a>`; 
                    var link_del=`<a href='/menu/index/delete_menu?menu_id=`+row.menu_id+`' 
						uid="`+row.menu_id+`" title="Hapus data Menu `+row.menu_title+`" text="Data Menu `+row.menu_title+` akan dihapus" 
						class="xhr_delete" table="#dataRows" title="Delete Menu"><i class="fe-trash-2"></i></a>`; 
                        
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