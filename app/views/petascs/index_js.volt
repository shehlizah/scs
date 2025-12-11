
<script>
    var table;
    $(function(){
        $('.datepicker_dmy').datepicker({
            format: 'yyyy-mm-dd',
            clearBtn: 'true',
            weekStart: '1',
            autoclose: true
        });	
});
</script>
<script>
	jQuery(document).on('change', '#list_kabkota', function() {
		//getData();
		var list_kabkota = $('#list_kabkota').val();

        location.replace("/petascs/index?kabkota="+list_kabkota)
	});
	
	function getData() 
	{
		var list_presiden = $('#list_presiden').val();
		var list_propinsi = $('#list_propinsi').val();
		var list_tahun = $('#list_tahun').val();
		var url_action	= '/petascs/index/getperjalanan?kabkota=<?php echo $data->kabkota; ?>';
		var data ={};
		data['presiden']=list_presiden;
		data['kode_prop']=list_propinsi;
		data['tahun']=list_tahun;
		jQuery.post( url_action,data,function(response) {
			initMap(response);
		});
	}
	
	function initMap(param) 
	{					
		var map_lat = $('select#list_kabkota option:selected').attr('map_lat')
		var map_lng = $('select#list_kabkota option:selected').attr('map_lng')

        // var map_lat = -5.147665
		// var map_lng = 119.432732
		
		obj = JSON.parse(param);   
		//Parameter Google maps
		var options = {
		  zoom: 10,
		  center: new google.maps.LatLng(map_lat, map_lng),
		  mapTypeId: google.maps.MapTypeId.ROADMAP
		};
	   
		// Buat peta di 
		var map = new google.maps.Map(document.getElementById('map'), options);
		// Tambahkan Marker 
		var infowindow = new google.maps.InfoWindow();
		var marker, i;
		/* kode untuk menampilkan banyak marker */
		// console.log(JSON.parse(param));
        // var data = obj;
		$.each(obj, function(k1, v1) {			
			// var  content = '<div id="content-maker"><div id="bodyContent">';
            var  content = `
                <div class="card d-block">
                    <div class="card-body" style="padding-top:0;">
                        <div class="clearfix"></div>
                        <h4>`+v1.sekolah+`</h4>
        
                        <div class="row">
                            <div class="col-md-6">
                                <!-- assignee -->
                                <p class="mt-2 mb-1 text-muted">Person in Charge</p>
                                <div class="d-flex align-items-start">
                                    <i class="mdi mdi-account-box font-18 text-success me-1"></i>
                                    <div class="w-100">
                                        <h5 class="mt-1 font-size-14">
                                            `+v1.pic+`
                                        </h5>
                                    </div>
                                </div>
                                <div class="d-flex align-items-start">
                                    <i class="mdi mdi-cellphone-basic font-18 text-success me-1"></i>
                                    <div class="w-100">
                                        <h5 class="mt-1 font-size-14">
                                            `+v1.no_telp+`
                                        </h5>
                                    </div>
                                </div>
                                <!-- end assignee -->
                            </div>
                            <!-- end col -->
        
                            <div class="col-md-6">
                                <!-- start due date -->
                                <p class="mt-2 mb-1 text-muted">Tanggal pengerjaan</p>
                                <div class="d-flex align-items-start">
                                    <i class="mdi mdi-calendar-month-outline font-18 text-success me-1"></i>
                                    <div class="w-100">
                                        <h5 class="mt-1 font-size-14">
                                            `+v1.date_action+`
                                        </h5>
                                    </div>
                                </div>
                                <!-- end due date -->
                            </div>
                            <!-- end col -->
                        </div>
                        <!-- end row -->
        
                        <h5 class="mt-3">Hasil Pekerjaan</h5>
                        <p class="text-muted mb-4">
                            `+v1.foto_visit+`
                            <!-- This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer. Some quick example text to build on the card title and make up the bulk of the card's
                            content. Some quick example text to build on the card title and make up.-->
                        </p>
                    </div>
                    <!-- end card-body-->
                </div>`;
			// content += '<div class="panel-group panel-group-continuous" id="exampleAccordionContinuous"aria-multiselectable="true" role="tablist">';
			// var nomor=1;
            /*
			$.each(v1.perjalanan, function(k, v) {
				//alert(k);
				var class_in="";
				var class_aria="false";
				if (nomor===1){
					class_in="in";
					class_aria="true";
				}
				content += ''+            
					''+
						'<div class="panel nav-tabs-horizontal" style="">'+
						
						'<div class="panel-heading" id="exampleHeadingContinuousOne'+k+'" role="tab">'+
						'<a class="panel-title margin-0 padding-0" data-parent="#exampleAccordionContinuous" data-toggle="collapse"href="#exampleCollapseContinuousOne'+k+'" aria-controls="exampleCollapseContinuousOne'+k+'" aria-expanded="'+class_aria+'"><h4 class="padding-right-50">'+v.nama_kegiatan+'</h4>'+
						'<small>'+
						'<i class="icon fa-calendar" aria-hidden="true"></i> '+v.tgl_berangkat+'&nbsp;&nbsp;&nbsp;'+
						'<i class="icon md-pin" aria-hidden="true"></i>'+v.lokasi+''+
						'<br/>'+v.keterangan+''+
						'</small>'+
						'</a>'+
						'<a href="/ruteperjalanan/index/'+v.id_perjalanan_dinas+'"> Detail Kegiatan</a>'+
						'</div>'+
						
						
						
						'<div class="panel-collapse collapse '+class_in+'" id="exampleCollapseContinuousOne'+k+'" aria-labelledby="exampleHeadingContinuousOne'+k+'" role="tabpanel">'+
                '      <div class="panel-body padding-left-0 padding-right-0">'+
						
						'  <ul class="nav nav-tabs nav-tabs-line" data-plugin="nav-tabs" role="tablist">'+
						'	<li class="active" role="presentation">'+
						'	  <a data-toggle="tab" href="#exampleTabsAnimateSlideLeftOne'+k+'" aria-controls="exampleTabsAnimateSlideLeftOne'+k+'" role="tab" aria-expanded="true">Team Advance</a>'+
						'	</li>'+
						'	<li role="presentation" class="">'+
						'	  <a data-toggle="tab" href="#exampleTabsAnimateSlideLeftTwo'+k+'" aria-controls="exampleTabsAnimateSlideLeftTwo'+k+'" role="tab" aria-expanded="false">Data Kendaraan</a>'+
						'	</li>'+
						'	<li class="" role="presentation">'+
						'	  <a data-toggle="tab" href="#exampleTabsAnimateSlideLeftThree'+k+'" aria-controls="exampleTabsAnimateSlideLeftThree'+k+'" role="tab" aria-expanded="true">Data Vendor</a>'+
						'	</li>'+
						'	<li class="" role="presentation">'+
						'	  <a data-toggle="tab" href="#tabPhoto'+k+'" aria-controls="tabPhoto'+k+'" role="tab" aria-expanded="true">Foto Kegiatan</a>'+
						'	</li>'+
						'	<li class="" role="presentation">'+
						'	  <a data-toggle="tab" href="#tabKegiatan'+k+'" aria-controls="tabKegiatan'+k+'" role="tab" aria-expanded="true">Kegiatan</a>'+
						'	</li>'+
						'  </ul>'+
						'  <div class="panel"><div class="panel-body " data-plugin="scrollable" data-skin="scrollable-shadow"><div data-role="container"><div data-role="content"><div class="tab-content">'+
						'	<div class="tab-pane active animation" id="exampleTabsAnimateSlideLeftOne'+k+'" role="tabpanel">';
						content += '<ul class="list-group">';
						var no =1;
						$.each(v.tim, function(ktim, vtim) {	
							content += '<li class="list-group-item padding-0 " style="border-bottom:1px solid #f5f5f5;margin-top:1px;">';
							content += '<small class="">'+no+'. ';
							content += ' <i class="fa fa-shield" aria-hidden="true"></i> '+vtim.nama+'&nbsp;&nbsp;'+vtim.nip+'&nbsp;&nbsp;';
							content += ' <span class="pull-right">'+vtim.jabatan+'<span>';
							content += '</small>';
							content += '</li>';
						no++;	
						});
						content += '</ul></div>';
						
						content +='	<div class="tab-pane animation" id="exampleTabsAnimateSlideLeftTwo'+k+'" role="tabpanel">';
						content += '<ul class="list-group">';
						$.each(v.kendaraan, function(key, val) {
							content += '<li><i class="fa fa-car" aria-hidden="true"></i>&nbsp;'+key;
							content += '<ol class="list-group">';
							var no =1;
							$.each(val, function(kknd, vknd) {	
							content += '<li class="list-group-item padding-0 " style="border-bottom:1px solid #f5f5f5;margin-top:1px;">';
							content += '	<div class="media"><div class="media-body1">';
							content += '		<small class="">'+no+'. '+vknd.pengguna+' <i class="fa fa-car" aria-hidden="true"></i> '+vknd.jenis_kendaraan+' <span class="fa-stack fa-3x"> <i class="fa fa-circle fa-stack-2x"></i> <strong class="fa-stack-1x text-primary">'+vknd.no_polisi+'</strong></span>';
							content += '			&nbsp;&nbsp;<i class="fa fa-user" aria-hidden="true"></i>&nbsp;&nbsp;'+vknd.pengemudi+'<span class="text-info pull-right">'+vknd.jenis_perolehan+'</span>';
							content += '		</small>';
							content += '	</div></div></li>';
							no++;
							});
							content += '</ol>';
							content += '</li>';
						});
						content += '</ul></div>';
						
						content +='	<div class="tab-pane animation" id="exampleTabsAnimateSlideLeftThree'+k+'" role="tabpanel">';
						content += '<ul class="list-group"> ';
						$.each(v.vendor, function(kvendor, vvendor) {	
							content += '<li class="list-group-item padding-0 " style="border-bottom:1px solid #f5f5f5;margin-top:1px;">';
							content += ' <div class=""><p class="bg-grey-100"><i class="fa fa-user" aria-hidden="true"></i>'+vvendor.nama_vendor+'';
							content += ' &nbsp;&nbsp;&nbsp;<i class="fa fa-phone" aria-hidden="true"></i>'+vvendor.no_telp+'<small> '+vvendor.pemilik+'</small>';
							content += ' <br/><i class="fa md-pin" aria-hidden="true"></i>'+vvendor.alamat+'</p>';
							content += ' </div></li>';							
						});
						content += '</ul></div>';
						
						content +='	<div class="tab-pane animation" id="tabPhoto'+k+'" role="tabpanel">';
						content +='	<div class="margin-top-20">';
						//content += '<ul class="list-group"> ';
						$.each(v.photo, function(kp, vp) {	
							content += '<div class="col-sm-3">';
							content += '<figure class="overlay overlay-hover animation-hover  margin-right-0 margin-bottom-20" id="lfoto" style="height:65px;">';
							content += ' <img width="75" class="overlay-figure overlay-scale" src="/foto/'+vp.filename+'" />';
							content += '</figure></div>';							
						});
						content += '</div>';
						content += '</div>';
						
						
						content +='	<div class="tab-pane animation" id="tabKegiatan'+k+'" role="tabpanel">';
						content += '<ul class="list-group"> ';
						$.each(v.kegiatan, function(kkegiatan, vkegiatan) {	
							content += '<li class="list-group-item padding-0 " style="border-bottom:1px solid #f5f5f5;margin-top:1px;"><div class="">';
							content += ' <p class="bg-grey-100">';
							content += ' <i class="icon fa-bookmark" aria-hidden="true"></i>'+vkegiatan.nama_kegiatan+'<br/>';
							content += ' <small class="pull-right"><i class="icon fa fa-calendar" aria-hidden="true"></i>'+vkegiatan.tanggal+'</small>';
							content += ' <small><i class="icon fa fa-binoculars" aria-hidden="true"></i>Jarak :'+vkegiatan.jarak+' km, Waktu : '+vkegiatan.waktu+' menit, Kecepatan '+vkegiatan.kecepatan+'</small><br/>';
							content += ' <small><i class="icon md-pin" aria-hidden="true"></i>'+vkegiatan.lokasi+'</small><br/>';
							content += ' <small><i class="icon fa fa-sticky-note-o" aria-hidden="true"></i>'+vkegiatan.keterangan+'</small>';
							content += '</p>';							
							content += '</div></li>';							
						});
						content += '</ul></div>';
						
						content += '  </div></div></div></div></div>'+
						'</div></div>';
						
				content += '</div>';				 
				nomor++;
			});
            */
			
                // content += '  </div></div>';
				// content += '</div></div>';

				marker = new google.maps.Marker({
					position: new google.maps.LatLng(v1.map_lat, v1.map_lng)
					,map: map
				  });
			 
				google.maps.event.addListener(marker, 'click', (function(marker, i) {
					return function() {
					  infowindow.setContent(content);
					  infowindow.open(map, marker);
					}
				})(marker, i));
		});
	}
</script> 
<script
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBJ1HUdLb57oeMk2FHNcYRxIGFERm47k28&callback=getData" async defer>
</script>