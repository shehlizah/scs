<?php 
class RefSekolah extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("ref_sekolah"); 
	} 
 
	public function getSource() 
	{ 
		return 'ref_sekolah'; 
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
