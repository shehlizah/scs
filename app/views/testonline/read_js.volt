<!-- Plugin js-->
<script src="/assets/libs/quill/quill.min.js"></script>
<script src="/assets/libs/select2/js/select2.min.js"></script>
<script src="/assets/libs/dropzone/min/dropzone.min.js"></script>
<script src="/assets/libs/dropify/js/dropify.min.js"></script>

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