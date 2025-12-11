<script>
    var table;

    function truncate(str, n){
        return (str.length > n) ? str.slice(0, n-1) + '&hellip;' : str;
    };

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
                {data: "cctv_name"},
                {data: "ip_address"},
                {data: "publish_port"},
                {data: "created_at"},
            ],
            "columnDefs": [
                {
                    "targets":0,
                    "render": function(data, type, row, meta){
                        var link_eye=`<a href="/{{page.access.resources_name}}/read/`+row.id+`" class="action-icon"> <i class="mdi mdi-table-headers-eye"></i></a>`;
                        var link_edit=`<a href="/{{page.access.resources_name}}/edit/`+row.id+`" class="action-icon"> <i class="mdi mdi-square-edit-outline"></i></a>`;
                        var link_del=`<a href='/{{page.access.resources_name}}/index/delete?uid=`+row.id+`' 
                            uid="`+row.id+`" 
                            title="Hapus Data" 
                            text="Data kegiatan `+row.date_action+` di Sekolah `+row.sekolah+` dengan PIC `+row.nama+` akan dihapus" 
                            class="action-icon xhr_delete" 
                            table="#dataRows" 
                            title="Delete"><i class="mdi mdi-delete"></i></a>`; 
                            
                        // return link_eye + link_edit + link_del;
                        return link_edit + link_del;
                    }
                },
                // {
				// "targets": 6,
                //     "render": function(data, type, row, meta){
                //         var image_path=`-`;

                //         if(row.foto_visit != null) {
                //             image_path=`
                //             <a href="https://api.disdiksulsel.id/`+row.foto_visit+`" class="btn btn-success waves-effect waves-light" target="_blank">
                //                 Lihat Foto
                //             </a>
                //             `;
                //         }

                //         return image_path;
                //     }
                // },
                // {
                //         "searchable": false,
                //         "orderable": false,
                //         "targets": [0,6]
                // },
                // {
                //         "searchable": true,
                //         "orderable": false,
                //         "targets": [3,4,5]
                // },		
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
            "order": [[ 5, 'desc' ]],
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