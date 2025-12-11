<!-- Plugin js-->
<script src="/assets/libs/quill/quill.min.js"></script>
<script src="/assets/libs/select2/js/select2.min.js"></script>
<script src="/assets/libs/dropzone/min/dropzone.min.js"></script>
<script src="/assets/libs/dropify/js/dropify.min.js"></script>
<script src="/assets/libs/clockpicker/bootstrap-clockpicker.min.js"></script>

<!-- Init js-->
<!-- <script src="/assets/js/pages/form-quilljs.init.js"></script> -->
<script>
$('.select2').select2({});
$('.datepicker_dmy').datepicker({
    format: 'yyyy-mm-dd',
    clearBtn: 'true',
    weekStart: '1',
    autoclose: true
});

$('.clockpicker').clockpicker({
    donetext: "Pilih"
});

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
            "url": "/{{page.access.resources_name}}/index/list_soal?sekolah={{data.row.sekolah}}&id_mapel={{data.row.id_mapel}}&tingkat={{data.row.tingkat}}",
            "type": "GET"
        },
        columns: [
            {
                data: null,
                orderable: false,
                searchable: false
            },
            {data: "soal_text"},
            {data: "soal_bobot"}
        ],
        "columnDefs": [
            {
                "targets":0,
                "render": function(data, type, row, meta){
                    var link_eye=`<a href="/banksoal/read/`+row.id+`" target="_blank" class="action-icon"> <i class="mdi mdi-table-headers-eye"></i></a>`;
                        
                    return link_eye;
                }
            },
            {
                "targets":1,
                "render": function(data, type, row, meta){                            
                    return truncate(row.soal_text, 75);
                }
            },
            {
                    "searchable": false,
                    "orderable": false,
                    "targets": 0
            },
            // {
            //         "searchable": true,
            //         "orderable": false,
            //         "targets": [2,4,7]
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
        "order": [[ 1, 'asc' ]],
    });
});

</script>