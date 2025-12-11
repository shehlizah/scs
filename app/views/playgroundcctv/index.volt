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
                <div class="row">
                    {{ flashSession.output() }}
                    <form
                        class="form"
                        action="/{{page.access.resources_name}}/{{page.access.access_name}}"
                        method="POST" 
                        id="form"
                        enctype="multipart/form-data">
                        <div class="col-lg-6">
                            <div class="mb-3">
                                <label for="ip_cctv" class="form-label">IP CCTV</label>
                                <input 
                                    type="text" 
                                    name="ip_cctv" 
                                    id="ip_cctv" 
                                    class="form-control" 
                                    required
                                    >
                            </div>

                            <div class="mb-3">
                                <label for="api_cctv" class="form-label">API CCTV</label>
                                <input 
                                    type="text" 
                                    name="api_cctv" 
                                    id="api_cctv" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="api_method" class="form-label">Method</label>
                                <input 
                                    type="text" 
                                    name="api_method" 
                                    id="api_method" 
                                    class="form-control" 
                                    required
                                    >
                            </div>
                            
                            <div class="mb-3">
                                <label for="nisn" class="form-label">JSON Body</label>
                                <textarea 
                                    class="form-control" 
                                    id="json_body" 
                                    name="json_body" 
                                    rows="8" 
                                    ></textarea>
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="mb-3">
                                <button type="submit" class="btn btn-primary waves-effect waves-light">Submit</button>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- end row-->
            </div> <!-- end card-body -->
        </div> <!-- end card -->
    </div><!-- end col -->
</div>
<!-- end row -->
{% endblock %}