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
			{data: "merk_title"},
		],
		"columnDefs": [
			{
				"targets":0,
				"render": function(data, type, row, meta){
					var link_edit=`<a href='/{{page.access.resources_name}}/winedit/`+row.id+`' class="show_modal" title="Edit"><i class="fe-edit"></i></a>`; 
                    var link_del=`<a href='/{{page.access.resources_name}}/index/delete?uid=`+row.id+`' 
						uid="`+row.id+`" 
						title="Hapus Merk: `+row.merk_title+`" 
						text="Data Merk `+row.merk_title+` akan dihapus" 
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
        
	$(document).on('change',"#rombel_pick", function(){
		console.log($(this).val());
        window.location = '/absensiswa/index?pick_ym='+$('#pick_ym').val()+'&rombel=' + $(this).val();
	});

    $(document).on('change',"#pick_ym", function(){
		console.log($(this).val());
        window.location = '/absensiswa/index?pick_ym=' + $(this).val();
	});
</script>