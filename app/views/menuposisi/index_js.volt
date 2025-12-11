<script src="/assets/vendor/nestable/jquery.nestable.js"></script>
<script>
$(function(){
    var updateOutput = function(e)
    {
        var list   = e.length ? e : $(e.target),
            output = list.data('output');
        if (window.JSON) {
            output.val(window.JSON.stringify(list.nestable('serialize')));//, null, 2));
        } else {
            output.val('JSON browser support required for this demo.');
        }
    };

    // activate Nestable for list 1
    $('#nestable').nestable({
        group: 1,
        scroll: true
    })
    .on('change', updateOutput);
    updateOutput($('#nestable').data('output', $('#nestable-output')));
    
    $('.dd').on('change', function() {
        $('#loader-body').removeClass('hidden');
        $.post('/menuposisi/edit/setPosition',{data:$("#nestable-output").val()},function(){
            
        })
        .done(function(r){
            var rs = jQuery.parseJSON(r);
            if(!rs.success)
            {
               alert(rs.error.message);
            }
            $('#loader-body').addClass('hidden');
        })
        .fail(function(x,y,z){
            $('#loader-body').addClass('hidden');
        });
        
    });
    
    $(document).on("click",".edit-button",function() {
        var id = $(this).attr('id');
        var resources = $(this).attr('resources');
        var access = $(this).attr('access');
        var parent = $(this).attr('parent');
        console.log(id+'-'+parent+'-'+resources+'-'+access);
    });
    //$('#nestable').nestable('collapseAll');
	$('#nestable-menu').on('click', function(e)
    {
        var target = $(e.target),
            action = target.data('action');
        if (action === 'expand-all') {
            $('.dd').nestable('expandAll');
        }
        if (action === 'collapse-all') {
            $('.dd').nestable('collapseAll');
        }
    });
});
</script>