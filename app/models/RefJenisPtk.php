<?php 
class RefJenisPtk extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("ref_jenis_ptk"); 
	} 
 
	public function getSource() 
	{ 
		return 'ref_jenis_ptk'; 
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
