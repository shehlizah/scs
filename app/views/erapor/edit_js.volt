<!-- Plugin js-->
<script src="/assets/libs/quill/quill.min.js"></script>
<script src="/assets/libs/select2/js/select2.min.js"></script>
<script src="/assets/libs/dropzone/min/dropzone.min.js"></script>
<script src="/assets/libs/dropify/js/dropify.min.js"></script>

<!-- Init js-->
<!-- <script src="/assets/js/pages/form-quilljs.init.js"></script> -->
<script>
// $('.select2').select2({});

$('#tahun_ajaran').select2({
    placeholder: 'Pilih Tahun Ajaran'
});

$('#sekolah').select2({
    placeholder: 'Pilih Sekolah'
});

$('#rombel').select2({
    placeholder: 'Pilih Rombel'
});

$('#nisn').select2({
    placeholder: 'Pilih Siswa'
});

$("#sekolah").on("change", function(){
    $("#rombel option[value]").remove();
    $("#nisn option[value]").remove();

    var sekolah = $(this).val();
    console.log(sekolah);

    if(sekolah){
        $.ajax ({
            type: 'GET',
            url: '/api/rombelbysekolah?uid_sekolah=' + sekolah,
            success : function(response) {
                // $('#opt_lesson_list').html(response);
                console.log(response);

                var rombel = $.map(response, function (obj) {
                    obj.id = obj.id || obj.uid;
                    obj.text = obj.text || obj.nama;
                    // obj.nama = obj.nama;
                    return obj;
                });

                console.rombel;
                
                $("#rombel").select2({
                    placeholder: "Pilih Rombel",
                    data: rombel
                });
            }
        });
    }
});

$("#rombel").on("change", function(){
    $("#nisn option[value]").remove();

    var sekolah = $('#sekolah').val();
    var rombel = $(this).val();
    console.log(sekolah);
    console.log(rombel);

    if(rombel){
        $.ajax ({
            type: 'GET',
            url: '/api/siswabysekolahbyrombel?uid_sekolah=' + sekolah +'&uid_rombel=' + rombel,
            success : function(response) {
                // $('#opt_lesson_list').html(response);
                console.log(response);

                var nisn = $.map(response, function (obj) {
                    obj.id = obj.id || obj.uid;
                    obj.text = obj.text || obj.nama;
                    // obj.nama = obj.nama;
                    return obj;
                });

                console.nisn;
                
                $("#nisn").select2({
                    placeholder: "Pilih Siswa",
                    data: nisn
                });
            }
        });
    }
});

$('.datepicker_dmy').datepicker({
    format: 'yyyy-mm-dd',
    clearBtn: 'true',
    weekStart: '1',
    autoclose: true
});

// var isi_laporan_buble_editor = new Quill("#isi_laporan_buble_editor", {
//     theme: "bubble"
// });

// $("#form").on("submit",function() {
//   $("#isi_laporan").val($("#isi_laporan_buble_editor .ql-editor").html());
// })

! function(t) {
    "use strict";

    function e() {
        this.$body = t("body")
    }
    e.prototype.init = function() {
        Dropzone.autoDiscover = !1, t('[data-plugin="dropzone"]').each(function() {
            var e = t(this).attr("action"),
                o = t(this).data("previewsContainer"),
                i = {
                    url: e
                };
            o && (i.previewsContainer = o);
            var r = t(this).data("uploadPreviewTemplate");
            r && (i.previewTemplate = t(r).html());
            t(this).dropzone(i)
        })
    }, t.FileUpload = new e, t.FileUpload.Constructor = e
}(window.jQuery),

function() {
    "use strict";
    window.jQuery.FileUpload.init()
}(), 0 < $('[data-plugins="dropify"]').length && $('[data-plugins="dropify"]').dropify({
    messages: {
        default: "Drag and drop a file here or click",
        replace: "Drag and drop or click to replace",
        remove: "Remove",
        error: "Ooops, something wrong appended."
    },
    error: {
        fileSize: "The file size is too big (1M max)."
    }
});

</script>