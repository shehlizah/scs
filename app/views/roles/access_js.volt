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
    $(document).on("change", ".create_access_list", function () {
        event.preventDefault();
        console.log('method: create_access_list');
        console.log($(this).prop('checked'));
        console.log($(this).attr('id'));
        var controller_method=$(this).attr('id');
        var role=$(this).attr('role');
        var allowed=$(this).prop('checked');
        
        $.ajax({
            url: '/roles/index/do_access_list?controller_method='+controller_method+'&role='+role+'&allowed='+allowed,
            type: 'GET',
            success: function (out) {
                if(out.status == 1){
                    Swal.fire({
                        icon: "success",
                        title: out.message,
                        showConfirmButton: false,
                        timer: 1500
                    });
                } 
                else {
                    Swal.fire(controller_method + ' for ' + role + ' failed added', "", "error");
                    console.log(out.error);
                    console.log(out.message);
                }
            },
            cache: false,
            processData: false
        });
    });

    $(document).on("change", ".update_access_list", function () {
        event.preventDefault();
        console.log('method: update_access_list');
        console.log($(this).prop('checked'));
        console.log($(this).attr('id'));
    });

    $(document).on("change", "#list_roles", function () {
        event.preventDefault();
        window.location.href='/roles/access/' + $(this).val();
    });
</script>