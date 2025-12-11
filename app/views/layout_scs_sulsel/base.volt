<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>{{page.access.access_title}} | SCS Disdik Sulawesi Selatan</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Smart Controlling School (SCS) Dinas Pendidikan Provinsi Sulawesi Selatan" name="description" />
        <meta content="PT. Kemala Inti Solusi" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="/assets/images/favicon.ico?<?php echo date('YmdHis'); ?>">

        <!-- Plugins css -->
        <link href="/assets/libs/flatpickr/flatpickr.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/selectize/css/selectize.bootstrap3.css" rel="stylesheet" type="text/css" />
		<link href="/assets/libs/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/quill/quill.core.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/quill/quill.bubble.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/quill/quill.snow.css" rel="stylesheet" type="text/css" />
		<link href="/assets/libs/fullcalendar/main.min.css" rel="stylesheet" type="text/css" />	
		<!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.9.0/fullcalendar.min.css" rel="stylesheet" /> -->
        <link href="/assets/libs/dropzone/min/dropzone.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/dropify/css/dropify.min.css" rel="stylesheet" type="text/css" />        

        <!-- third party css -->
        <link href="/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/datatables.net-select-bs5/css//select.bootstrap5.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/vendor/nestable/nestable.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/clockpicker/bootstrap-clockpicker.min.css" rel="stylesheet" type="text/css" />
        <link href="/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
        <!-- third party css end -->   		
        
        <!-- App css -->
        <link href="/assets/css/config/default/app.css?<?php echo date('Ymd_His'); ?>" rel="stylesheet" type="text/css" id="app-style"/>
        <!-- icons -->
        <link href="/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
		<link href="/assets/css/custom.css" rel="stylesheet" type="text/css" />

    </head>

    <!-- body start -->
    <body 
		class="loading" 
		data-layout-mode="default" 
		data-layout-color="light" 
		data-layout-width="fluid" 
		data-topbar-color="dark" 
		data-menu-position="fixed" 
		data-leftbar-color="light" 
		data-leftbar-size='default' 
		data-sidebar-user='false'>

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Topbar Start -->
			<div class="navbar-custom">
				<div class="container-fluid">
					<ul class="list-unstyled topnav-menu float-end mb-0">
				
						<li class="dropdown d-none d-lg-inline-block">
							<a class="nav-link dropdown-toggle arrow-none waves-effect waves-light" data-toggle="fullscreen" href="#">
								<i class="fe-maximize noti-icon"></i>
							</a>
						</li>
				
						<li class="dropdown notification-list topbar-dropdown">
							<a class="nav-link dropdown-toggle nav-user me-0 waves-effect waves-light" 
								data-bs-toggle="dropdown" 
								href="#" 
								role="button" 
								aria-haspopup="false" 
								aria-expanded="false">
								<span class="pro-user-name ms-1">
									<?php echo $this->session->get('auth')->username; ?> 
									<i class="mdi mdi-chevron-down"></i> 
								</span>
							</a>
							<div class="dropdown-menu dropdown-menu-end profile-dropdown ">
								<!-- item-->
								<div class="dropdown-header noti-title">
									<h6 class="text-overflow m-0">Selamat Datang</h6>
								</div>
				
								<!-- item-->
								<a href="/ubahpassword" class="dropdown-item notify-item ubahpassword">
									<i class="fe-lock"></i>
									<span>Ubah Password</span>
								</a>
				
								<div class="dropdown-divider"></div>
				
								<!-- item-->
								<a href="/auth/logout" class="dropdown-item notify-item">
									<i class="fe-log-out"></i>
									<span>Logout</span>
								</a>
				
							</div>
						</li>
				
						<li class="dropdown notification-list">
							<a href="javascript:void(0);" class="nav-link right-bar-toggle waves-effect waves-light">
								<i class="fe-settings noti-icon"></i>
							</a>
						</li>
				
					</ul>
				
					<!-- LOGO -->
					<div class="logo-box">
						<a href="index.html" class="logo logo-dark text-center">
							<span class="logo-sm">
								<img src="/assets/images/logo-sm.png" alt="" height="22">
								<!-- <span class="logo-lg-text-light">UBold</span> -->
							</span>
							<span class="logo-lg">
								<img src="/assets/images/logo-dark.png" alt="" height="20">
								<!-- <span class="logo-lg-text-light">U</span> -->
							</span>
						</a>
				
						<a href="index.html" class="logo logo-light text-center">
							<span class="logo-sm">
								<img src="/assets/images/logo-sm.png?<?php echo date('YmdHis'); ?>" alt="" height="40">
							</span>
							<span class="logo-lg">
								<img src="/assets/images/logo-image-left2.png?<?php echo date('YmdHis'); ?>" alt="" height="40">
							</span>
						</a>
					</div>
				
					<ul class="list-unstyled topnav-menu topnav-menu-left m-0">
						<li>
							<button class="button-menu-mobile waves-effect waves-light">
								<i class="fe-menu"></i>
							</button>
						</li>

						<li>
							<!-- Mobile menu toggle (Horizontal Layout)-->
							<a class="navbar-toggle nav-link" data-bs-toggle="collapse" data-bs-target="#topnav-menu-content">
								<div class="lines">
									<span></span>
									<span></span>
									<span></span>
								</div>
							</a>
							<!-- End mobile menu toggle-->
						</li>
					</ul>
					<div class="clearfix"></div>
				</div>
			</div>
			<!-- end Topbar -->

            <!-- ========== Left Sidebar Start ========== -->
            <div class="left-side-menu">
                <div class="h-100" data-simplebar>
                    <!-- User box -->
                    <!--- Sidemenu -->
                    <div id="sidebar-menu">
						{{ page.sidebar_menu_scs }}
                    </div>
                    <!-- End Sidebar -->
                    <div class="clearfix"></div>
                </div>
                <!-- Sidebar -left -->
            </div>
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">
                    <!-- Start Content-->
                    <div class="container-fluid">
						{% block content %}{% endblock %}
                    </div> <!-- container -->
                </div> <!-- content -->
                <!-- Footer Start -->
                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-6">
                                <script>document.write(new Date().getFullYear())</script> &copy; SCS Disdik Prov. Sulawesi Selatan
                            </div>
                        </div>
                    </div>
                </footer>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->
        </div>
        <!-- END wrapper -->

        <!-- Right Sidebar -->
        <div class="right-bar">
            <div data-simplebar class="h-100">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs nav-bordered nav-justified" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link py-2 active" data-bs-toggle="tab" href="#settings-tab" role="tab">
                            <i class="mdi mdi-cog-outline d-block font-22 my-1"></i>
                        </a>
                    </li>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content pt-0">					
                    <div class="tab-pane active" id="settings-tab" role="tabpanel">
                        <h6 class="fw-medium px-3 m-0 py-2 font-13 text-uppercase bg-light">
                            <span class="d-block py-1">Theme Settings</span>
                        </h6>

                        <div class="p-3">
                            <div class="alert alert-warning" role="alert">
                                <strong>Customize </strong> the overall color scheme, sidebar menu, etc.
                            </div>

                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Color Scheme</h6>
                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="layout-color" value="light"
                                    id="light-mode-check" checked />
                                <label class="form-check-label" for="light-mode-check">Light Mode</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="layout-color" value="dark"
                                    id="dark-mode-check" />
                                <label class="form-check-label" for="dark-mode-check">Dark Mode</label>
                            </div>

                            <!-- Width -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Width</h6>
                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="layout-width" value="fluid" id="fluid-check" checked />
                                <label class="form-check-label" for="fluid-check">Fluid</label>
                            </div>
                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="layout-width" value="boxed" id="boxed-check" />
                                <label class="form-check-label" for="boxed-check">Boxed</label>
                            </div>

                            <!-- Menu positions -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Menus (Leftsidebar and Topbar) Positon</h6>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="menu-position" value="fixed" id="fixed-check"
                                    checked />
                                <label class="form-check-label" for="fixed-check">Fixed</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="menu-position" value="scrollable"
                                    id="scrollable-check" />
                                <label class="form-check-label" for="scrollable-check">Scrollable</label>
                            </div>

                            <!-- Left Sidebar-->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Left Sidebar Color</h6>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-color" value="light" id="light-check" />
                                <label class="form-check-label" for="light-check">Light</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-color" value="dark" id="dark-check" checked/>
                                <label class="form-check-label" for="dark-check">Dark</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-color" value="brand" id="brand-check" />
                                <label class="form-check-label" for="brand-check">Brand</label>
                            </div>

                            <div class="form-check form-switch mb-3">
                                <input type="checkbox" class="form-check-input" name="leftbar-color" value="gradient" id="gradient-check" />
                                <label class="form-check-label" for="gradient-check">Gradient</label>
                            </div>

                            <!-- size -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Left Sidebar Size</h6>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-size" value="default"
                                    id="default-size-check" checked />
                                <label class="form-check-label" for="default-size-check">Default</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-size" value="condensed"
                                    id="condensed-check" />
                                <label class="form-check-label" for="condensed-check">Condensed <small>(Extra Small size)</small></label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="leftbar-size" value="compact"
                                    id="compact-check" />
                                <label class="form-check-label" for="compact-check">Compact <small>(Small size)</small></label>
                            </div>

                            <!-- User info -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Sidebar User Info</h6>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="sidebar-user" value="fixed" id="sidebaruser-check" />
                                <label class="form-check-label" for="sidebaruser-check">Enable</label>
                            </div>


                            <!-- Topbar -->
                            <h6 class="fw-medium font-14 mt-4 mb-2 pb-1">Topbar</h6>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="topbar-color" value="dark" id="darktopbar-check"
                                    checked />
                                <label class="form-check-label" for="darktopbar-check">Dark</label>
                            </div>

                            <div class="form-check form-switch mb-1">
                                <input type="checkbox" class="form-check-input" name="topbar-color" value="light" id="lighttopbar-check" />
                                <label class="form-check-label" for="lighttopbar-check">Light</label>
                            </div>


                            <div class="d-grid mt-4">
                                <button class="btn btn-primary" id="resetBtn">Reset to Default</button>
                                <a href="https://1.envato.market/uboldadmin" class="btn btn-danger mt-3" target="_blank"><i class="mdi mdi-basket me-1"></i> Purchase Now</a>
                            </div>

                        </div>

                    </div>
                </div>

            </div> <!-- end slimscroll-menu-->
        </div>
        <!-- /Right-bar -->

        <!-- Right bar overlay-->
        <div class="rightbar-overlay"></div>

        <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content"></div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->

        <div class="modal fade" id="myModalBesar">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content"></div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->         

        <!-- Vendor js -->
        <script src="/assets/js/vendor.min.js"></script>

        <!-- Plugins js-->
        <script src="/assets/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
        <script src="/assets/libs/sweetalert2/sweetalert2.all.min.js"></script>

        <script src="/assets/libs/selectize/js/standalone/selectize.min.js"></script>

        <!-- third party js -->
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

        <!-- Dashboar 1 init js-->
        <!-- <script src="/assets/js/pages/dashboard-1.init.js"></script> -->
		{{ partial(dispatcher.getControllerName()~"/"~dispatcher.getActionName()~"_js") }}

		<script>
		$(document).on("click", ".ubahpassword", function () {
			event.preventDefault();
			var url = $(this).attr('href');
			$('.modal-content').empty();
			$('.modal-content').load(url);
			$('#myModal').modal('show');
		});
		</script>

        <!-- App js-->
        <script src="/assets/js/app.min.js"></script>
        
        <script>
<?php
if(strlen(Config::findFirstByKey('nvr_ip')->value) > 0 && strlen(Config::findFirstByKey('nvr_login_at')->value) > 0) {
    ?>
    function fetchdata(){
        $.ajax({
            url: '/api/heartbeat',
            type: 'post',
            success: function(data){
                // Perform operation on return value
                console.log(data);
                if(data.result != 'success') {
                    alert("NVR API SESSION IS EXPIRED");
                    window.location.href = "/auth/logout";
                }
            },
            complete:function(data){
                setTimeout(fetchdata,10000);
            }
        });
    }

    $(document).ready(function(){
        setTimeout(fetchdata,10000);
        console.log('call /api/heartbeat');
    });

    // function fetchdata_heartbeatsyncfacelog(){
    //     $.ajax({
    //         url: '/api/heartbeatcekabsen',
    //         type: 'post',
    //         success: function(data){
    //             // Perform operation on return value
    //             console.log(data);
    //         },
    //         complete:function(data){
    //             setTimeout(fetchdata_heartbeatsyncfacelog,10000);
    //         }
    //     });
    // }

    // $(document).ready(function(){
    //   setTimeout(fetchdata_heartbeatsyncfacelog,10000);
    //   console.log('call /api/heartbeatcekabsen');
    // }); 
    <?php
}
?>

/*
function fetchdata_heartbeatabsensi(){
    $.ajax({
        url: '/api/heartbeatabsensi',
        type: 'post',
        success: function(data){
            // Perform operation on return value
            console.log(data);
        },
        complete:function(data){
            setTimeout(fetchdata_heartbeatabsensi,10000);
        }
    });
}

$(document).ready(function(){
  setTimeout(fetchdata_heartbeatabsensi,10000);
  console.log('call /api/heartbeatsyncfacelog');
});
*/

/*
function fetchdata_heartbeatfacematch(){
    $.ajax({
        url: '/api/heartbeatfacematch',
        type: 'post',
        success: function(data){
            // Perform operation on return value
            console.log(data);
        },
        complete:function(data){
            setTimeout(fetchdata_heartbeatfacematch,8000);
        }
    });
}

$(document).ready(function(){
    setTimeout(fetchdata_heartbeatfacematch,8000);
    console.log('call /api/heartbeatfacematch');
});
*/
</script>

    </body>
</html>