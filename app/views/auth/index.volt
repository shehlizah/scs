<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Smart Controlling School - Disdik Prov. Sulawesi Selatan</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Smart Controlling School - Disdik Prov. Sulawesi Selatan" name="description" />
        <meta content="PT. Kemala Inti Solusi" name="author" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="/assets/images/favicon.ico?<?php echo date('Ymd_His'); ?>">

		<!-- App css -->
		<link href="/assets/css/config/default/app.css?<?php echo date('Ymd_His'); ?>" rel="stylesheet" type="text/css" id="app-style"/>
		<!-- icons -->
		<link href="/assets/css/icons.min.css" rel="stylesheet" type="text/css" />

    </head>

    <body class="loading auth-fluid-pages pb-0">

        <div class="auth-fluid">
            <!--Auth fluid left content -->
            <div class="auth-fluid-form-box">
                <div class="align-items-center d-flex h-100">
                    <div class="card-body">

                        <!-- Logo -->


                        <!-- title-->
                        <h4 class="mt-0">Smart Controlling School</h4>
                        <?php
                            if (strlen(Config::findFirstByKey('scs_sekolah')->value) > 0) {
                                echo '<h5 class="mt-0">'.Config::findFirstByKey('scs_sekolah')->value.'</h5>';
                            }
                        ?>
                        <p class="text-muted mb-4">Dinas Pendidikan Provinsi Sulawesi Selatan {{data.sync_at}}</p>

                        <!-- form -->
                        {{ flashSession.output() }}
                        <form action="/auth/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input class="form-control" type="text" id="username" name="username" required="" placeholder="Username">
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group input-group-merge">
                                    <input type="password" id="password" name="password" class="form-control" placeholder="Password">
                                    <div class="input-group-text" data-password="false">
                                        <span class="password-eye"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center d-grid">
                                <button class="btn btn-primary" type="submit">Log In </button>
                            </div>
                        </form>
                        <!-- end form-->

                        <!-- Footer-->
                        <footer class="footer footer-alt">
                            
                        </footer>

                    </div> <!-- end .card-body -->
                </div> <!-- end .align-items-center.d-flex.h-100-->
            </div>
            <!-- end auth-fluid-form-box-->

            <!-- Auth fluid right content -->
            <div class="auth-fluid-right text-center">
                <div class="auth-user-testimonial">
                    
                </div> <!-- end auth-user-testimonial-->
            </div>
            <!-- end Auth fluid right content -->
        </div>
        <!-- end auth-fluid-->

        <!-- Vendor js -->
        <script src="/assets/js/vendor.min.js"></script>

        <!-- App js -->
        <script src="/assets/js/app.min.js"></script>
        
    </body>
</html>