<?php
use Phalcon\Mvc\User\Component;

class ModulGenerate extends Component
{
    private $menu='';
    private $modelname='';
    private $modelid='';
    private $modelfield='';
    
    public function __construct($menu,$modelname,$modelid,$modelfield)
    {
        $this->menu=$menu;
        $this->modelname=$modelname;
        $this->modelid=$modelid;
        $this->modelfield=$modelfield;
    }
    
    public function execute()
    {
        $this->createController();
    }
    
    private function createController()
    {
		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

		$controller=ucfirst($menu).'Controller';
        $file = $this->config->application->controllersDir.$controller.'.php';
		
		$arr_field=explode(",",$this->modelfield);

		$labelmodelid = $this->modelid;
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = ucwords($labelmodelid);
		
		$labelmodelfield = $this->modelfield;
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = ucwords($labelmodelfield);
		
		$namamodel = $this->modelname;
		$namamodel = str_replace("_"," ",$namamodel);
		$namamodel = ucwords($namamodel);
		$namamodel = str_replace(" ","",$namamodel);
		
        $str='';
        if(!file_exists($file))
        {
$str .= '<?php '. "\n";
$str .= 'use \DataTables\DataTable; '. "\n";
$str .= 'use Phalcon\Forms\Form; '. "\n";
$str .= 'use Phalcon\Forms\Element\Select; '. "\n";
$str .= ''. "\n";			
$str .= 'class '.$controller.' extends ControllerBase '. "\n";
$str .= '{ '. "\n";
$str .= '	public function indexAction($param=false)'. "\n";
$str .= '   {'. "\n";
$str .= '		if($this->request->isAjax()):'. "\n";
$str .= '			$this->view->disable(); '. "\n";
$str .= '			if(method_exists(__CLASS__,$param)): '. "\n";
$str .=	'				$this->{$param}(); '. "\n";
$str .= '			else: '. "\n";
$str .= '				throw new Exception("Method tidak tersedia"); '. "\n";
$str .= '			endif;'. "\n";
$str .= '		endif;'. "\n";
$str .= '	}'. "\n";			
$str .= '	'. "\n";			
$str .= '	private function all_data()'. "\n";
$str .= '	{ '. "\n";
$str .= '		$builder = $this->modelsManager->createBuilder()  '. "\n";
$str .= '			->columns(\''.$this->modelid.','.$this->modelfield.'\') '. "\n";
$str .= '			->from(\''.$namamodel.'\'); '. "\n";
$str .= '		$dataTables = new DataTable(); '. "\n";
$str .= '		$dataTables->fromBuilder($builder)->sendResponse(); '. "\n";
$str .= '	} '. "\n";
$str .= ' 	'. "\n";	
$str .= '	public function addAction()'. "\n";
$str .= '	{ '. "\n";
$str .= '		if($this->request->isPost()):'. "\n";
$str .= '			$row=new '.$namamodel.'(); '. "\n";
$str .= '			$row->'.($this->modelid).'=$this->request->getPost(\''.($this->modelid).'\'); '. "\n";

foreach($arr_field as $k=>$v):
$str .= '			$row->'.($v).'=$this->request->getPost(\''.($v).'\'); '. "\n";
endforeach;

$str .= '			if($row->save()):'. "\n";
$str .= '				$this->flashSession->success("Data berhasil ditambahkan !!! "); '. "\n";
$str .= '				$this->response->redirect("/'.$this->menu.'"); '. "\n";
$str .= '			endif;'. "\n";
$str .= '		endif;'. "\n";
$str .= '		$this->myassets->formValidation(); '. "\n";
$str .= '	} '. "\n";			
$str .= ' '. "\n";
$str .= '	public function editAction($id=false) '. "\n";
$str .= '	{ '. "\n";
$str .= '		if($id!=false):'. "\n";
$str .= '			$row='.$namamodel.'::findFirst($id); '. "\n";
$str .= '			if($row):'. "\n";
$str .= '				if($this->request->isPost()):'. "\n";
foreach($arr_field as $k=>$v):
$str .= '					$row->'.($v).'=$this->request->getPost(\''.($v).'\'); '. "\n";
endforeach;
$str .= '					if($row->save()):'. "\n";
$str .= '						$this->flashSession->notice("Edit data berhasil !!! "); '. "\n";
$str .= '						$this->response->redirect("/'.$this->menu.'"); '. "\n";
$str .= '					endif;'. "\n";
$str .= '				endif;'. "\n";
$str .= '				$data[\'row\']=$row;'. "\n";
$str .= '				$this->view->setVar("data",(object)$data);'. "\n";
$str .= '			else:'. "\n";
$str .= '				throw new Exception("Data tidak tersedia"); '. "\n";
$str .= '			endif;'. "\n";
$str .= '		else:'. "\n";
$str .= '			throw new Exception("Data tidak tersedia"); '. "\n";
$str .= '		endif;'. "\n";
$str .= '	} '. "\n";
$str .= ' '. "\n";
$str .= '	public function deleteAction($pk=false)'. "\n";
$str .= '	{'. "\n";
$str .= '		$this->view->disable();'. "\n";
$str .= '		$data='.$namamodel.'::findFirst($pk);'. "\n";
$str .= '		if($data):'. "\n";
$str .= '			$data->delete();'. "\n";
$str .= '			$this->flashSession->success("Hapus Data Berhasil."); '. "\n";
$str .= '			$this->response->redirect("/'.$this->menu.'"); '. "\n";
$str .= '		else:'. "\n";
$str .= '			$this->flashSession->error("Hapus Data Tidak Berhasil."); '. "\n";
$str .= '			$this->response->redirect("/'.$this->menu.'"); '. "\n";
$str .= '		endif;'. "\n";
$str .= '	} '. "\n";
$str .= ' '. "\n";			
$str .= '} '. "\n";
		file_put_contents($file, $str);
		if(!empty($this->modelname)):
			$this->createModelFile();
		endif;
		$this->createView($this->menu);
        }
    }
    
    private function createView()
    {
		$path=$this->config->application->viewsDir;
		
		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

        $foldername=strtolower($menu);
        $folderpath=$path.$foldername;
        if(!is_dir($path.$foldername)){
            mkdir($path.$foldername,0777,true);
            $this->createViewFileIndex($path.$foldername);
            $this->createViewFileIndexJs($path.$foldername);
            $this->createViewFileAdd($path.$foldername);
            $this->createViewFileAddJs($path.$foldername);
            $this->createViewFileEdit($path.$foldername);
            $this->createViewFileEditJs($path.$foldername);
        }
    }
  
    private function createModelFile()	
	{
		$namafile = $this->modelname;
		$namafile = str_replace("_"," ",$namafile);
		$namafile = ucwords($namafile);
		$namafile = str_replace(" ","",$namafile);
		$file = $this->config->application->modelsDir.$namafile.'.php';
        $str='';
        if(!file_exists($file))
        {	
			
			$str='';
            $str .= '<?php '. "\n";
            $str .= 'class '.$namafile.' extends \Phalcon\Mvc\Model '. "\n";
            $str .= '{ '. "\n";
            $str .= '   public function initialize() '. "\n";
			$str .= '	{ '. "\n";
			$str .= '		$this->setSource("'.$this->modelname.'"); '. "\n";
			$str .= '	} '. "\n";
			$str .= ' '. "\n";
			$str .= '	public function getSource() '. "\n";
			$str .= '	{ '. "\n";
			$str .= '		return \''.$this->modelname.'\'; '. "\n";
			$str .= '	} '. "\n";
			$str .= ' '. "\n";
			$str .= '	public static function find($parameters = null) '. "\n";
			$str .= '	{ '. "\n";
			$str .= '		return parent::find($parameters); '. "\n";
			$str .= '	} '. "\n";
			$str .= ' '. "\n";
			$str .= '	public static function findFirst($parameters = null) '. "\n";
			$str .= '	{ '. "\n";
			$str .= '		return parent::findFirst($parameters); '. "\n";
			$str .= '	} '. "\n";
			// $str .= ' '. "\n";			
            $str .= '} '. "\n";
			file_put_contents($file, $str);
		}
	}
	
	private function createViewFileIndex($path)
	{
		$labelmodelid = $this->modelid;
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = ucwords($labelmodelid);
		
		$labelmodelfield = $this->modelfield;
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = ucwords($labelmodelfield);
		
		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

			$str ='';
			$arr_field=explode(",",$this->modelfield);

			$str.='{% extends "layout/base.volt" %}'."\n";
			$str.='{% block content %}'."\n";
			$str.='<div class="d-flex flex-column-fluid">'."\n";
			$str.='    <!--begin::Container-->'."\n";
			$str.='    <div class="container">'."\n";
			$str.='        <!--begin::Card-->'."\n";
			$str.='        <div class="card card-custom">'."\n";
			$str.='            <div class="card-header">'."\n";
			$str.='                <div class="card-title">'."\n";
			$str.='                    <h3 class="card-label">{{page.row_menu.menu_title}}</h3>'."\n";
			$str.='                </div>'."\n";
			$str.='                <div class="card-toolbar">'."\n";
			$str.='                    <!--begin::Button-->'."\n";
			$str.='                    <a href="/'.$menu.'/add" class="btn btn-primary font-weight-bolder">'."\n";
			$str.='                    Tambah Data</a>'."\n";
			$str.='                    <!--end::Button-->'."\n";
			$str.='                </div>'."\n";
			$str.='            </div>'."\n";
			$str.='            <div class="card-body">'."\n";
			$str.='            {{ flashSession.output() }}'."\n";
			$str.='                <!--begin: Datatable-->'."\n";
			$str.='                <table '."\n";
			$str.='                    class="table table-bordered table-hover table-checkable" '."\n";
			$str.='                    id="kt_datatable" '."\n";
			$str.='                    style="margin-top: 13px !important">'."\n";
			$str.='                    <thead>'."\n";
			$str.='                        <tr>'."\n";
			$str.='                            <th>Action</th>'."\n";
			
			foreach($arr_field as $k=>$v):
				$label_field=str_replace("_"," ",$v);
				$label_field=strtolower($label_field);
				$label_field=ucwords($label_field);				

			$str .= '							<th>'.$label_field.'</th>'. "\n";
			endforeach;			
			
			$str.='                        </tr>'."\n";
			$str.='                    </thead>'."\n";
			$str.='                </table>'."\n";
			$str.='                <!--end: Datatable-->'."\n";
			$str.='            </div>'."\n";
			$str.='        </div>'."\n";
			$str.='        <!--end::Card-->'."\n";
			$str.='    </div>'."\n";
			$str.='    <!--end::Container-->'."\n";
			$str.='</div>'."\n";
			$str.='{% endblock %}';

			file_put_contents($path.'/index.volt', $str);
	}

	private function createViewFileIndexJs($path)
	{
		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

		$labelmodelid = $this->modelid;
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = ucwords($labelmodelid);
		
		$labelmodelfield = $this->modelfield;
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = ucwords($labelmodelfield);
			$str ='';
			$arr_field=explode(",",$this->modelfield);

			$str.='<script>'."\n";
			$str.='var table;'."\n";
			$str.='$(function(){'."\n";
			$str.='    $.fn.dataTable.ext.errMode = "none";'."\n";
			$str.='    table = $("#kt_datatable").DataTable({'."\n";
			$str.='        "processing": true,'."\n";
			$str.='        "serverSide": true,'."\n";
			$str.='        "responsive": true,'."\n";
			$str.='        "ajax": {'."\n";
			$str.='            "url": "/'.$menu.'/index/all_data",'."\n";
			$str.='            "type": "GET"'."\n";
			$str.='        },'."\n";
			$str.='        columns: ['."\n";
			$str.='            {'."\n";
			$str.='                data: null,'."\n";
			$str.='                orderable: false,'."\n";
			$str.='                searchable: false'."\n";
			$str.='            },'."\n";

			foreach($arr_field as $k=>$v):
				$str.='			{data: "'.$v.'"},'."\n";
			endforeach;	

			$str.='        ],'."\n";
			$str.='        "columnDefs": ['."\n";
			$str.='            {'."\n";
			$str.='                "targets": 0,'."\n";
			$str.='                "render": function(data, type, row, meta){'."\n";
			$str.='                    return `'."\n";
			$str.='                            <a href="/'.$menu.'/edit/`+row.'.$this->modelid.'+`" class="btn btn-sm btn-clean btn-icon mr-2" title="Edit details">'."\n";
			$str.='                                <i class="icon fas fa-pencil-alt"></i>'."\n";
			$str.='                            </a>'."\n";
			$str.='                            <a href="/'.$menu.'/index" uid="`+row.'.$this->modelid.'+`" class="btn btn-sm btn-clean btn-icon xhr_delete" title="Delete" message="Hapus data : `+row.'.$this->modelid.'+`">'."\n";
			$str.='                                <i class="icon flaticon2-trash"></i>'."\n";
			$str.='                            </a>'."\n";
			$str.='                        `;			'."\n";		
			$str.='                }'."\n";
			$str.='            },'."\n";
			$str.='            {'."\n";
			$str.='                "searchable": false,'."\n";
			$str.='                "orderable": false,'."\n";
			$str.='                "targets": 0'."\n";
			$str.='            },'."\n";
			$str.='        ],'."\n";
			$str.='        "language": {'."\n";
			$str.='            "lengthMenu": "_MENU_",'."\n";
			$str.='        },'."\n";
			$str.='        "order": [[ 1, "asc" ]],'."\n";
			$str.='    });'."\n";
			$str.='    '."\n";
			$str.='    $(document).on("click",".xhr_delete", function(){'."\n";
			$str.='        event.preventDefault();'."\n";
			$str.='        console.log($(this).val());'."\n";
			$str.='        var conf=confirm($(this).attr("message"));'."\n";
			$str.='        if(conf)'."\n";
			$str.='        {'."\n";
			$str.='            window.location.href = "/'.$menu.'/delete/"+$(this).attr("uid");'."\n";
			$str.='        }'."\n";
			$str.='    }); '."\n";
			$str.='});'."\n";
			$str.='</script>'."\n";
			file_put_contents($path.'/index_js.volt', $str);
	}	

	private function createViewFileAdd($path)
	{
		$labelmodelid = $this->modelid;
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = ucwords($labelmodelid);
		
		$labelmodelfield = $this->modelfield;
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = ucwords($labelmodelfield);

		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

		$str ='';
		$arr_field=explode(",",$this->modelfield);

		$str.='		{% extends "layout/base.volt" %}'."\n";
		$str.='		{% block content %}'."\n";
		$str.='		<div class="d-flex flex-column-fluid">'."\n";
		$str.='			<!--begin::Container-->'."\n";
		$str.='			<div class="container">'."\n";
		$str.='				<!--begin::Card-->'."\n";
		$str.='				<div class="card card-custom gutter-b example example-compact">'."\n";
		$str.='					<div class="card-header">'."\n";
		$str.='						<h3 class="card-title">{{page.row_menu.menu_title}}</h3>'."\n";
		$str.='						<div class="card-toolbar">'."\n";
		$str.='							<div class="example-tools justify-content-center">'."\n";
		$str.='								<span class="example-toggle" data-toggle="tooltip" title="View code"></span>'."\n";
		$str.='							</div>'."\n";
		$str.='						</div>'."\n";
		$str.='					</div>'."\n";
		$str.='					<!--begin::Form-->'."\n";
		$str.='					{{ flashSession.output() }}'."\n";
		$str.='					<form '."\n";
		$str.='						class="form" '."\n";
		$str.='						action="/'.$menu.'/add" '."\n";
		$str.='						method="POST">'."\n";
		$str.='						<div class="card-body">'."\n";

		foreach($arr_field as $k=>$v):
			$label_field=str_replace("_"," ",$v);
			$label_field=strtolower($label_field);
			$label_field=ucwords($label_field);

			$str.='							<div class="form-group row">'."\n";
			$str.='								<label class="col-form-label text-right col-lg-3 col-sm-12">'.$label_field.'</label>'."\n";
			$str.='								<div class="col-lg-8 col-md-9 col-sm-12">'."\n";
			$str.='									<input '."\n";
			$str.='										type="text"'."\n"; 
			$str.='										class="form-control" '."\n";
			$str.='										name="'.$v.'" '."\n";
			$str.='										placeholder="'.$label_field.'">'."\n";
			$str.='									<span class="form-text text-muted">'.$label_field.'</span>'."\n";
			$str.='								</div>'."\n";
			$str.='							</div>'."\n";
		endforeach;			


		$str.='						</div>'."\n";
		$str.='						<div class="card-footer">'."\n";
		$str.='							<div class="row">'."\n";
		$str.='								<div class="col-lg-9 ml-lg-auto">'."\n";
		$str.='									<button type="submit" class="btn btn-primary mr-2">Submit</button>'."\n";
		$str.='									<a href="/'.$menu.'" class="btn btn-secondary">Cancel</a>'."\n";
		$str.='								</div>'."\n";
		$str.='							</div>'."\n";
		$str.='						</div>'."\n";
		$str.='					</form>'."\n";
		$str.='					<!--end::Form-->'."\n";
		$str.='				</div>'."\n";
		$str.='				<!--end::Card-->'."\n";
		$str.='			</div>'."\n";
		$str.='			<!--end::Container-->'."\n";
		$str.='		</div>'."\n";
		$str.='		{% endblock %}'."\n";;


			file_put_contents($path.'/add.volt', $str);
	}

	private function createViewFileAddJs($path)
	{
		$str.='<script>console.log();</script>'."\n";
		file_put_contents($path.'/add_js.volt', $str);
	}	
	
	private function createViewFileEdit($path)
	{
		
		$labelmodelid = $this->modelid;
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = str_replace("_"," ",$labelmodelid);
		$labelmodelid = ucwords($labelmodelid);
		
		$labelmodelfield = $this->modelfield;
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = str_replace("_"," ",$labelmodelfield);
		$labelmodelfield = ucwords($labelmodelfield);

		$menu=trim($this->menu);
		$menu=str_replace('_','',$menu);
		$menu=strtolower($menu);

		$str ='';
		$arr_field=explode(",",$this->modelfield);		

		$str.='		{% extends "layout/base.volt" %}'."\n";
		$str.='		{% block content %}'."\n";
		$str.='		<div class="d-flex flex-column-fluid">'."\n";
		$str.='			<!--begin::Container-->'."\n";
		$str.='			<div class="container">'."\n";
		$str.='				<!--begin::Card-->'."\n";
		$str.='				<div class="card card-custom gutter-b example example-compact">'."\n";
		$str.='					<div class="card-header">'."\n";
		$str.='						<h3 class="card-title">{{page.row_menu.menu_title}}</h3>'."\n";
		$str.='					</div>'."\n";
		$str.='					<!--begin::Form-->'."\n";
		$str.='					{{ flashSession.output() }}'."\n";
		$str.='					<form '."\n";
		$str.='						class="form" '."\n";
		$str.='						action="/'.$menu.'/edit/{{ data.row.'.$this->modelid.' }}" '."\n";
		$str.='						method="POST">'."\n";
		$str.='						<div class="card-body">'."\n";

		foreach($arr_field as $k=>$v):
			$label_field=str_replace("_"," ",$v);
			$label_field=strtolower($label_field);
			$label_field=ucwords($label_field);
			
			$str.='							<div class="form-group row">'."\n";
			$str.='								<label class="col-form-label text-right col-lg-3 col-sm-12">'.$label_field.'</label>'."\n";
			$str.='								<div class="col-lg-8 col-md-9 col-sm-12">'."\n";
			$str.='									<input '."\n";
			$str.='										type="text"'."\n"; 
			$str.='										class="form-control" '."\n";
			$str.='										name="'.$v.'" '."\n";
			$str.='										placeholder="'.$label_field.'" value="{{ data.row.'.$v.' }}">'."\n";
			$str.='									<span class="form-text text-muted">'.$label_field.'</span>'."\n";
			$str.='								</div>'."\n";
			$str.='							</div>'."\n";
		endforeach;			


		$str.='						</div>'."\n";
		$str.='						<div class="card-footer">'."\n";
		$str.='							<div class="row">'."\n";
		$str.='								<div class="col-lg-9 ml-lg-auto">'."\n";
		$str.='									<button type="submit" class="btn btn-primary mr-2">Submit</button>'."\n";
		$str.='									<a href="/'.$menu.'" class="btn btn-secondary">Cancel</a>'."\n";
		$str.='								</div>'."\n";
		$str.='							</div>'."\n";
		$str.='						</div>'."\n";
		$str.='					</form>'."\n";
		$str.='					<!--end::Form-->'."\n";
		$str.='				</div>'."\n";
		$str.='				<!--end::Card-->'."\n";
		$str.='			</div>'."\n";
		$str.='			<!--end::Container-->'."\n";
		$str.='		</div>'."\n";
		$str.='		{% endblock %}'."\n";
		file_put_contents($path.'/edit.volt', $str);
	}

	private function createViewFileEditJs($path)
	{
		$str.='<script>console.log("load edit_js.volt");</script>'."\n";
		file_put_contents($path.'/edit_js.volt', $str);
	}
}