<script>
    $('#mapelchoose').on("select2:unselecting", function(e) {
        var idmapel = $(this).val();
        var lengthoption = $("#mapelchoose option:selected").length;
        for (i = 0; i < lengthoption; i++) {
            var idmapelnew = idmapel[i];
            var attrmapel = $(".form-group[data-mapel=" + idmapelnew + "]").length;
            if (attrmapel != 0) {
                $(".form-group[data-mapel=" + idmapelnew + "]").remove();
            }
        }
    }).trigger('change');
    $('#mapelchoose').change(function(e) {
        var idmapel = $(this).val();
        var lengthoption = $("#mapelchoose option:selected").length;
        for (i = 0; i < lengthoption; i++) {
            var idmapelnew = idmapel[i];
            var attrmapel = $(".form-group[data-mapel=" + idmapelnew + "]").length;
            if (attrmapel == 0) {
                $.ajax({
                    type: "POST",
                    url: "https://demo.sekolahan.id/dataguru/ajaxmapel",
                    data: {
                        idmapel: idmapel[i],
                        lengthoption: lengthoption
                    },
                    cache: false,
                    success: function(html) {
                        $("#mapellist").append(html);
                        $('.datepickerfull').datepicker({
                            autoclose: true
                        });
                    }
                });
            }
        }
    });
    $(document).on("change", "input[name=nomor_surat_tugas]", function() {
        valinp = $(this).val();
        $("input[name=tanggal_surat_tugas]").attr("required", false);
        if (valinp != "") {
            $("input[name=tanggal_surat_tugas]").attr("required", true);
        }
    })
    $(document).on("change", "select[name=jeniskeluar]", function() {
        valinp = $(this).val();
        $("input[name=tglptkkeluar]").attr("required", false);
        if (valinp != "") {
            $("input[name=tglptkkeluar]").attr("required", true);
        }
    })
</script>