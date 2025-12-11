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
                
                <div class="pull-right text-right">
                    <div class="btn-group" data-toggle="buttons" role="group"id="nestable-menu">
                    <label class="btn btn-sm btn-outline btn-primary active"data-action="expand-all">
                        <input name="options" autocomplete="off" value="male" checked="" type="radio" >
                        <i class="icon wb-check text-active" aria-hidden="true"></i>Expand All
                    </label>
                    <label class="btn btn-sm btn-outline btn-primary"data-action="collapse-all">
                        <input name="options" autocomplete="off" value="female" type="radio" >
                        <i class="icon wb-check text-active" aria-hidden="true"></i>Collapse All
                    </label>
                    </div>											
                </div>

                <p></p>

                <div class="hidden" id="loader-body"></div>
                    <div class="dd" id="nestable" data-plugin="nestable">{{data.list_menu}}</div>
                    <div class="clear"></div>

                    <textarea class="hidden" id="nestable-output" style="display:none;"></textarea>

            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->

{% endblock %}