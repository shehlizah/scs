<script src="/plugins/treetable/jquery.treetable.js"></script>
<script>
	var type="";
	var aksi="";
	var roles = $('#roles').val();
	var allowed=0;
	load_access();

	function load_access(r)
	{
		
		if(r){
			$.get('/menuakses/index/get_list_menu_by_role',{roles:r},function(data){
				var rs=jQuery.parseJSON(data);
				
				if(rs.success){
					$('#load-access').html(rs.data);
					$('#treeGrid').treetable({ initialState: 'expanded',expandable: true});
					$('#txt-filter').removeClass('hidden');
				}else{
					alert(rs.error.message);
				}
			});
		}
		else
		{
			$('#load-access').html('');
		}
	}

	function _on_search_modul(e=false){
		
		if(e == false || e.keyCode == 13){
			if($('#roles').val() != '' || $('#txt-cari-modul').val() !=''){
				$('#loader-body').removeClass('hidden');
				$.get('/menuakses/index/get_list_menu_by_role',{roles:$('#roles').val(),cari:$('#txt-cari-modul').val()},function(data){
					var rs=jQuery.parseJSON(data);
					console.log(rs);
					if(rs.success){
						$('#load-access').html(rs.data);
						$('#treeGrid').treetable({ expandable: true});
					}else{
						alert(rs.error.message);
					}
				});
			}
		}
	}

	function checkAll(r)
	{
		console.log(r);
		var checked = [];
		var sel = $("input[name='"+r+"[]']");
		var data = sel.map(function(){
			return $(this).val();
		});
		type = "many";
		
		$(sel).each(function ()
		{
			if(sel.prop('checked')){
				$('.'+r).prop('checked', true);
				allowed=1;
			}
			else
			{
				$('.'+r).prop('checked', false);
				allowed=0;
			}
		});
		
		$.post('/menuakses/edit/setAccess',{type:type,roles:$('#roles').val(),resources:r,access:data.get(),allowed:allowed},function(data){
			var rs=jQuery.parseJSON(data);
			console.log(rs);
			if(!rs.success)
			{
				alert(rs.error.message);
			}
			
		});
	}

	function checkOne(r,a,i)
	{
		var sel = $("#"+r+i);
		type = "one";    
		if (sel.prop('checked')) {
			allowed=1;
		}
		else
		{
			allowed=0;
		}
		console.log(a+' '+$('#roles').val()+' '+r+' '+sel.val()+' '+allowed);
		
		$('#loader-body').removeClass('hidden');
		$.post('/menuakses/edit/setAccess/',{type:type,roles:$('#roles').val(),resources:r,access:a,allowed:allowed},function(data){
			var rs=jQuery.parseJSON(data);
			console.log(rs);
			if(!rs.success)
			{
				alert(rs.error.message);
			}
			$('#loader-body').addClass('hidden');
		});
		
	}

	function set_full_access(){
		if($('#roles').val() !=''){
			$('#loader-body').removeClass('hidden');
			$.post('/menuakses/edit/set_full_access/',{role:$('#roles').val()},function(data){
				console.log(data);
				load_access($('#roles').val());
			});
		}
	}
</script>