{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box">
            <div class="page-title-right">
                <!-- 
                <a 
                    href="/satpas/add" 
                    class="btn btn-danger waves-effect waves-light">
                    <i class="mdi mdi-plus-circle me-1"></i> Tambah
                </a>
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">UBold</a></li>
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Tables</a></li>
                    <li class="breadcrumb-item active">Datatables</li>
                </ol>
                -->
            </div>
            <h4 class="page-title">{{page.access.access_title}}</h4>
        </div>
    </div>
</div>     
<!-- end page title -->



<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
			<div class="row">

							<div class="col-md-6">
								<div class="form-inline">
								<div class="form-group">
									<label class="sr-only" for="exampleInputEmail3"></label>
								{{data.list_roles}}
								</div>
                                <p></p>
								<button onclick="set_full_access()" type="button" class="btnx btnx-default hidden">Full Access</button>                  
                                <p></p>
                            </div>
							</div>
							<div class="col-md-6">
								
							</div>
							</div>

                <!--
                <h4 class="header-title">Basic Data Table</h4>
                <p class="text-muted font-13 mb-4">
                    DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction
                    function:
                    <code>$().DataTable();</code>.
                </p>
                -->

                {{ flashSession.output() }}


				<div id="load-access"></div>

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->
{% endblock %}