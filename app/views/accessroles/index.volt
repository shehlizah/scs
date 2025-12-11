{% extends "layout_scs_sulsel/base.volt" %}
{% block content %}
<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box">
            <div class="page-title-right">
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
                {{ flashSession.output() }}
                <div class="row mb-2">
                    <div class="col-sm-12">
                        <a href="/accessroles/winadd" class="btn btn-primary waves-effect waves-light show_modal">
                            <i class="mdi mdi-plus-circle me-1"></i> Tambah Access
                        </a>
                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>
                <table id="dataRows" class="table nowrap w-100 table-striped">
                    <thead>
                        <tr>
							<th>Aksi</th>
							<th>Controller</th>
							<th>Method</th>
							<th>Title</th>
						</tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->
{% endblock %}