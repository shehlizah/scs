<script src="/assets/libs/select2/js/select2.min.js"></script>
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
        $.fn.dataTable.ext.errMode = "none";
    
        $("#dataRows").dataTable( {
            scrollX: !0,
            "processing": true,
            "serverSide": true,
            "ajax": {
                "url": "/roles/index/all_data",
                "type": "GET"
            },
            "stateSave": true,
            "fixedHeader": true,
            "oLanguage": {
                "sEmptyTable": "No entries to show",
                "sZeroRecords": "Nothing found",
                "sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
                "sInfoEmpty": "",
                "oPaginate": {
                    "sNext": "Next",
                    "sPrevious": "Previous",
                    "sFirst": "First Page",
                    "sLast": "Last Page"
                }
            },
            columns: [
                {
                    data: null,
                    orderable: false,
                    searchable: false
                },
                {data: "roles"},
                {data: "name"},
                {data: "description"},
            ],                    
            "columnDefs": [
                {
                    "targets": 0,
                    "render": function(data, type, row, meta){
                        var link=`<a href='/roles/winedit/`+row.roles+`' class="show_modal" title="Enroll"><i class="fe-edit"></i></a>` + 
                        	`<a href="/roles/index/delete?uid=`+row.roles+`" class="xhr_delete" uid=`+row.roles+` 
							title="Hapus Group `+row.roles+`" 
							text="Data Group `+row.roles+` dan privileges nya akan dihapus" 
							table="#dataRows"><i class="fe-trash-2"></i></a>` + 
							`<a href='/roles/access/`+row.roles+`' class="" title="Access List"><i class="fe-eye"></i></a>`;
                        
                        return link;
                    }
                }                     
            ] ,
            "order": [[ 1, "asc" ]],
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
                console.log('urk hapus ajax : ' + url_del);
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
                    } else {
                    Swal.fire("Data tidak bisa dihapus", "", "error");
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

    });
</script>