<?php
use Phalcon\Mvc\User\Component;

class Myassets extends Component
{
    public function assetsBase()
    {
        $this->assets->collection("cssHeader")
            ->addCss('theme/material/global/css/bootstrap.min.css')
            ->addCss('theme/material/global/css/bootstrap-extend.min.css')
            ->addCss('theme/material/topicon/assets/css/site.min.css')
            ->addCss('theme/material/topicon/assets/skins/orange.css')			
            ->addCss('theme/material/global/vendor/animsition/animsition.css')
            ->addCss('theme/material/global/vendor/asscrollable/asScrollable.css')
            ->addCss('theme/material/global/vendor/switchery/switchery.css')
            ->addCss('theme/material/global/vendor/intro-js/introjs.css')
            ->addCss('theme/material/global/vendor/slidepanel/slidePanel.css')
            ->addCss('theme/material/global/vendor/flag-icon-css/flag-icon.css')
            ->addCss('theme/material/global/vendor/waves/waves.css')
            ->addCss('theme/material/global/vendor/datatables-bootstrap/dataTables.bootstrap.css')
            // ->addCss('theme/material/global/vendor/datatables.net-fixedcolumns-bs4/dataTables.fixedcolumns.bootstrap4.css')
            ->addCss('theme/material/global/vendor/datatables-fixedheader/dataTables.fixedHeader.css')
            ->addCss('theme/material/global/vendor/datatables-responsive/dataTables.responsive.css')
            ->addCss('theme/material/topicon/assets/examples/css/uikit/dropdowns.min.css')
            ->addCss('theme/material/topicon/assets/examples/css/tables/datatable.css')
            ->addCss('theme/material/global/vendor/clockpicker/clockpicker.css')
            ->addCss('theme/material/global/vendor/bootstrap-datepicker/bootstrap-datepicker.css')
            ->addCss('theme/material/global/vendor/bootstrap-maxlength/bootstrap-maxlength.css')
            ->addCss('theme/material/global/vendor/bootstrap-select/bootstrap-select.css')
            ->addCss('theme/material/global/vendor/jt-timepicker/jquery-timepicker.css')
            ->addCss('theme/material/topicon/assets/examples/css/uikit/modals.css')  
            ->addCss('theme/material/global/vendor/bootstrap-sweetalert/sweet-alert.css')  
            ->addCss('theme/material/global/vendor/toastr/toastr.css') 
            ->addCss('theme/material/global/fonts/font-awesome/font-awesome.css')
            ->addCss('theme/material/global/fonts/material-design/material-design.min.css')
            ->addCss('theme/material/global/fonts/web-icons/web-icons.min.css')
            ->addCss('theme/material/global/fonts/brand-icons/brand-icons.min.css')
            ->addCss('https://fonts.googleapis.com/css?family=Roboto:300,400,500,300italic')
            ->addCss('vendor/jquery-loading/loading.css')
            ;
			
            $this->assets->collection("cssCustom")
            ->addCss('theme/material/topicon/assets/css/custom.css?date='.date("Ymd_His"))
            ->addCss('plugins/bootstrap_date_time/css/bootstrap-datetimepicker.min.css')
            ->addCss('plugins/daterangepicker/daterangepicker-bs3.css')
            ;
			
        $this->assets->collection('jsHeader')
            ->addJs('theme/material/global/vendor/modernizr/modernizr.js')
            ->addJs('theme/material/global/vendor/breakpoints/breakpoints.js')
            // ->addJs('theme/material/global/vendor/jquery/jquery.js')
            ->addJs('vendor/jquery/jquery-2.2.3.min.js')
            ->addJs('js/jquery.signalR-2.4.0.min.js')
            ->addJs('vendor/jquery-loading/loading.js')
            ;
		$this->assets->collection('jsFooter')
            ->addJs('theme/material/global/vendor/bootstrap/bootstrap.js')
            ->addJs('theme/material/global/vendor/animsition/animsition.js')
            ->addJs('theme/material/global/vendor/asscroll/jquery-asScroll.js')
            ->addJs('theme/material/global/vendor/mousewheel/jquery.mousewheel.js')
            ->addJs('theme/material/global/vendor/asscrollable/jquery.asScrollable.all.js')
            ->addJs('theme/material/global/vendor/ashoverscroll/jquery-asHoverScroll.js')
            ->addJs('theme/material/global/vendor/waves/waves.js')
            ->addJs('theme/material/global/vendor/switchery/switchery.min.js')
            ->addJs('theme/material/global/vendor/intro-js/intro.js')
            ->addJs('theme/material/global/vendor/screenfull/screenfull.js')
            ->addJs('theme/material/global/vendor/slidepanel/jquery-slidePanel.js')
            ->addJs('theme/material/global/vendor/datatables/jquery.dataTables.js')
            ->addJs('theme/material/global/vendor/datatables-fixedheader/dataTables.fixedHeader.js')
            
            ->addJs('theme/material/global/vendor/datatables.net-fixedcolumns/dataTables.fixedColumns.js')

            ->addJs('theme/material/global/vendor/datatables-bootstrap/dataTables.bootstrap.js')
            ->addJs('theme/material/global/vendor/datatables-responsive/dataTables.responsive.js')
            ->addJs('theme/material/global/vendor/datatables-tabletools/dataTables.tableTools.js')
            ->addJs('theme/material/global/vendor/clockpicker/bootstrap-clockpicker.min.js')
            ->addJs('theme/material/global/vendor/bootstrap-datepicker/bootstrap-datepicker.js')
            ->addJs('theme/material/global/vendor/jt-timepicker/jquery.timepicker.min.js')	
            ->addJs('theme/material/global/vendor/asrange/jquery-asRange.min.js')
            ->addJs('theme/material/global/vendor/bootbox/bootbox.js')
            ->addJs('theme/material/global/vendor/bootstrap-sweetalert/sweet-alert.js')
            ->addJs('theme/material/global/vendor/toastr/toastr.js')
            ->addJs('theme/material/global/js/core.js')
            ->addJs('theme/material/topicon/assets/js/site.js')
            ->addJs('theme/material/topicon/assets/js/sections/menu.js')
            ->addJs('theme/material/topicon/assets/js/sections/menubar.js')
            ->addJs('theme/material/topicon/assets/js/sections/sidebar.js')
            ->addJs('theme/material/global/js/configs/config-colors.js')
            ->addJs('theme/material/topicon/assets/js/configs/config-tour.js')
            ->addJs('theme/material/global/js/components/asscrollable.js')
            ->addJs('theme/material/global/js/components/animsition.js')
            ->addJs('theme/material/global/js/components/slidepanel.js')
            ->addJs('theme/material/global/js/components/switchery.js')
            ->addJs('theme/material/global/js/components/tabs.js')
            ->addJs('theme/material/global/js/components/bootbox.js')
            ->addJs('theme/material/global/js/components/bootstrap-sweetalert.js')
            ->addJs('theme/material/global/js/components/toastr.js')
            ->addJs('theme/material/topicon/assets/examples/js/advanced/bootbox-sweetalert.js')
            ->addJs('theme/material/global/js/components/datatables.js')
            ->addJs('theme/material/topicon/assets/custom/js/tables/datatable.js')
            ->addJs('theme/material/global/js/components/clockpicker.js')
            ->addJs('theme/material/global/js/components/bootstrap-datepicker.js')
            ->addJs('theme/material/global/js/components/jt-timepicker.js')
            ->addJs('theme/material/global/js/components/datepair-js.js')
            ->addJs('theme/material/topicon/assets/custom/js/uikit/icon.js')
			->addJs('plugins/bootstrap_date_time/js/bootstrap-datetimepicker.min.js')
			->addJs('plugins/bootstrap_date_time/js/locales/bootstrap-datetimepicker.id.js')
			->addJs('plugins/daterangepicker/daterangepicker.js')
            ;
    }
    
    public function formValidation()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/formvalidation/css/formValidation.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/formvalidation/js/formValidation.min.js')
            ->addJs('plugins/formvalidation/js/framework/bootstrap.min.js')
            ->addJs('plugins/formvalidation/js/language/id_ID.js');
    }
    
    public function treeTable()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/treetable/css/jquery.treetable.theme.default.css')
            ->addCss('plugins/treetable/css/jquery.treetable.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/treetable/jquery.treetable.js');
    }
    public function tabs()
    {
        $this->assets->collection("cssHeader");
        $this->assets->collection('jsHeader')
            ->addJs('theme/material/global/js/components/tabs.js')
            ->addJs('theme/material/global/js/plugins/responsive-tabs.js')
            ->addJs('theme/material/global/js/plugins/closeable-tabs.js');
    }
    
    public function selectPicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/selectpicker/bootstrap-select.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/selectpicker/bootstrap-select.min.js');
    }
    
    public function datepicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/datepicker/datepicker3.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/datepicker/bootstrap-datepicker.js')
            ->addJs('plugins/datepicker/locales/bootstrap-datepicker.id.js');
    }
    
    public function select2()
    {
        $this->assets->collection("cssHeader")
            ->addCss('theme/material/global/vendor/select2/select2.css');
        $this->assets->collection('jsFooter')
            ->addJs('theme/material/global/vendor/select2/select2.min.js')
            ->addJs('theme/material/global/js/components/select2.js');
    }
	public function uploadFile()
    {
        $this->assets->collection("cssHeader")
            ->addCss('theme/material/global/vendor/bootstrap-tokenfield/bootstrap-tokenfield.css')
            ->addCss('theme/material/global/vendor/bootstrap-tagsinput/bootstrap-tagsinput.css')
            ->addCss('theme/material/global/vendor/bootstrap-select/bootstrap-select.css')
            ->addCss('theme/material/global/vendor/icheck/icheck.css')
            ->addCss('theme/material/global/vendor/switchery/switchery.css')
            ->addCss('theme/material/global/vendor/jquery-labelauty/jquery-labelauty.css')
            ->addCss('theme/material/global/vendor/jquery-strength/jquery-strength.css')
            ->addCss('theme/material/global/vendor/multi-select/multi-select.css')
            ->addCss('theme/material/global/vendor/typeahead-js/typeahead.css')
            ->addCss('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload.css')
            ->addCss('theme/material/global/vendor/dropify/dropify.css')
            ->addCss('theme/material/topicon/assets/examples/css/forms/advanced.css');
        $this->assets->collection('jsFooter')
			->addJs('theme/material/global/vendor/jquery-strength/jquery-strength.min.js')
			->addJs('theme/material/global/vendor/multi-select/jquery.multi-select.js')
			->addJs('theme/material/global/vendor/typeahead-js/bloodhound.min.js')
			->addJs('theme/material/global/vendor/typeahead-js/typeahead.jquery.min.js')
			->addJs('theme/material/global/vendor/jquery-placeholder/jquery.placeholder.js')	
			->addJs('theme/material/global/vendor/blueimp-tmpl/tmpl.js')
			->addJs('theme/material/global/vendor/blueimp-canvas-to-blob/canvas-to-blob.js')
			->addJs('theme/material/global/vendor/blueimp-load-image/load-image.all.min.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-process.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-image.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-audio.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-video.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-validate.js')
			// ->addJs('theme/material/global/vendor/blueimp-file-upload/jquery.fileupload-ui.js')
			->addJs('theme/material/global/vendor/dropify/dropify.min.js')			
            ->addJs('theme/material/global/js/components/jquery-strength.js')
            ->addJs('theme/material/global/js/components/multi-select.js')
            ->addJs('theme/material/global/js/components/jquery-placeholder.js')
            ->addJs('theme/material/global/js/components/dropify.js')
            // ->addJs('theme/material/topicon/assets/examples/js/forms/uploads.js')
            ->addJs('theme/material/global/js/components/tabs.js')
            ->addJs('theme/material/global/js/plugins/responsive-tabs.js')
            // ->addJs('theme/material/topicon/assets/examples/js/forms/advanced.js')
            ;
    }
    
    public function chosenAjax()
    {
        $this->assets->collection("cssHeader")
             ->addCss("plugins/chosen-ajax-addition/vendor/chosen.css");
        $this->assets->collection('jsHeader')
            ->addJs("plugins/chosen-ajax-addition/vendor/chosen.jquery-1.0.js")
            ->addJs("plugins/chosen-ajax-addition/chosen.ajaxaddition.jquery.js");
    }
    
    public function chosen()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/chosen/chosen.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/chosen/chosen.jquery.min.js');
    }
    
    public function nestable()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/nestable/style.nestable.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/nestable/jquery.nestable.js');
    }
	
    public function nestable_remark()
    {
        $this->assets->collection("cssHeader")
		
            ->addCss('theme/material/global/vendor/nestable/nestable.css');
        $this->assets->collection('jsFooter')
            ->addJs('theme/material/global/vendor/nestable/jquery.nestable.js')
            ->addJs('theme/material/global/js/components/nestable.js');
    }
    
    public function easyAutocomplete()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/EasyAutocomplete/easy-autocomplete.min.css')
            ->addCss('plugins/EasyAutocomplete/easy-autocomplete.themes.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/EasyAutocomplete/jquery.easy-autocomplete.min.js');
    }
    
    public function dateTimePicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');        
        $this->assets->collection('jsHeader')
            ->addJs("plugins/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js");
    }
    
    public function prismjs()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/prismjs/prism.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/prismjs/prism.js');
    }
	
    public function panelAction()
    {
        $this->assets->collection('jsFooter')
            ->addJs('theme/material/global/js/components/panel.js')
            ->addJs('theme/material/topicon/assets/examples/js/uikit/panel-actions.js');
    }
    
    public function highcharts()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/highcharts/code/css/highcharts.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/highcharts/code/js/highcharts.js')
            ->addJs('plugins/highcharts/code/js/modules/exporting.js')
            ->addJs('plugins/highcharts/code/js/modules/offline-exporting.js');
    }
    
    public function colorpicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugins/colorpicker/css/colorpicker.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugins/colorpicker/js/colorpicker.js');
    }

    public function jin_nama_bulan($bln, $tipe='full') {
		$bln = $bln * 1;
		if($tipe == 'full') {
			$nama_bulan = array(1=>"Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember");
		} else {
			$nama_bulan = array(1=>"Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Ags", "Sep", "Okt", "Nov", "Des");
		}
		return $nama_bulan[$bln];
    }
    
    public function nsi_round($x) {
		//$x = ceil($x / 100) * 100;
		return $x;
    }
    
    public function jin_date_ina($date_sql, $tipe = 'full', $time = false) {
		$date = '';
		if($tipe == 'full') {
			$nama_bulan = array(1=>"Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember");
		} else {
			$nama_bulan = array(1=>"Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Ags", "Sep", "Okt", "Nov", "Des");
		}
		if($time) {
			$exp = explode(' ', $date_sql);
			$exp = explode('-', $exp[0]);
			if(count($exp) == 3) {
				$bln = $exp[1] * 1;
				$date = $exp[2].' '.$nama_bulan[$bln].' '.$exp[0];
			}		
			$exp_time = $exp = explode(' ', $date_sql);
			$date .= ' jam ' . substr($exp_time[1], 0, 5);
		} else {
			$exp = explode('-', $date_sql);
			if(count($exp) == 3) {
				$bln = $exp[1] * 1;
				if($bln > 0) {
					$date = $exp[2].' '.$nama_bulan[$bln].' '.$exp[0];
				}
			}
		}
		return $date;
    }
    
    public function get_total_denda() {
        $sql="SELECT SUM(denda_rp) AS total_denda FROM tbl_pinjaman_d";
		// $this->db->select('SUM(denda_rp) AS total_denda');
		// $this->db->from('tbl_pinjaman_d');
        // $query = $this->db->get();
        
		$query = $this->db->query($sql);
		$query->setFetchMode(
			\Phalcon\Db::FETCH_OBJ
		);
		$out=$query->fetchAll($sql);
		return $out[0];        

		// return $query->row();
    }
    
	//menghitung jumlah yang sudah dibayar dengan id pinjam
	public function get_jml_bayar($id) {
        $sql="SELECT SUM(jumlah_bayar) AS total FROM tbl_pinjaman_d WHERE pinjam_id=$id";
		$query = $this->db->query($sql);
		$query->setFetchMode(\Phalcon\Db::FETCH_OBJ);
		$out=$query->fetchAll($sql);
		return $out[0];
    }
    
    public function get_jml_denda($id) {
		// $this->db->select('SUM(denda_rp) AS total_denda');
		// $this->db->from('tbl_pinjaman_d');
		// $this->db->where('pinjam_id',$id);
		// $query = $this->db->get();
        // return $query->row();
        
        $sql="SELECT SUM(denda_rp) AS total_denda FROM tbl_pinjaman_d WHERE pinjam_id=$id";
		$query = $this->db->query($sql);
		$query->setFetchMode(\Phalcon\Db::FETCH_OBJ);
		$out=$query->fetchAll($sql);
		return $out[0];        
	}
}