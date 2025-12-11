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
                        <a href="/roles" class="btn btn-primary waves-effect waves-light">
                            <i class="fe-arrow-left"></i> Kembali lihat Group
                        </a>
                        <p></p>
                        {{ data.list_roles }}

                    </div>
                    <div class="col-sm-8">&nbsp;
                    </div><!-- end col-->
                </div>

                <table id="treeGrid" class="table nowrap w-100 table-striped">
                    <thead>
                        <tr>
                            <th>Controller</th>
                            <th>Method</th>
                            <th>Access</th>
                            <th style="text-align: center;">Allowed?</th>
                        </tr>
                    </thead>
                    <tbody>
                    <?php
                    foreach($data->access as $row) {
                        ?>
                        <tr data-tt-id="parent-1" class="leaf expanded">
                            <td>
                                <span class="indenter" style="padding-left: 0px;"></span><?php echo $row->resources_name; ?></td>
                            <td><?php echo $row->access_name; ?></td>
                            <td><?php echo $row->access_title; ?></td>
                            <td align="center">
                                <?php
                                    if(in_array($row->resources_name.'_'.$row->access_name, $data->list_role_access)){
                                        if($data->list_role_access_allowed[$row->resources_name.'_'.$row->access_name]==1) {
                                            echo '<input 
                                                type="checkbox" 
                                                class="form-check-input create_access_list" 
                                                id="'.$row->resources_name.'_'.$row->access_name.'" 
                                                role="'.$data->role.'" 
                                                checked
                                                >';                                        }
                                        else {
                                            echo '<input 
                                                type="checkbox" 
                                                class="form-check-input create_access_list" 
                                                id="'.$row->resources_name.'_'.$row->access_name.'" 
                                                role="'.$data->role.'"
                                                >';
                                        }    
                                    }
                                    else {
                                        echo '<input 
                                            type="checkbox" 
                                            class="form-check-input create_access_list" 
                                            id="'.$row->resources_name.'_'.$row->access_name.'" 
                                            role="'.$data->role.'" 
                                            >';
                                    }
                                ?>
                                <!-- <input 
                                    id="dashboard1" 
                                    class="dashboard" 
                                    type="checkbox" 
                                    onchange="checkOne('dashboard','index','1')" name="dashboard[]" 
                                    value="index"> -->
                            </td>
                        </tr>
                        <?php
                    }
                    ?>
                </tbody></table>
            </div> <!-- end card body-->
        </div> <!-- end card -->
    </div><!-- end col-->
</div>
<!-- end row-->
{% endblock %}