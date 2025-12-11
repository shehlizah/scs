<?php 
class CctvSekolah extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("cctv_sekolah"); 
	} 
 
	public function getSource() 
	{ 
		return 'cctv_sekolah'; 
	} 
 
	public static function find($parameters = null) 
	{ 
		return parent::find($parameters); 
	} 
 
	public static function findFirst($parameters = null) 
	{ 
		return parent::findFirst($parameters); 
	} 
} 
