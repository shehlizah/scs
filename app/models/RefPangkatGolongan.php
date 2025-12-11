<?php 
class RefPangkatGolongan extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("ref_pangkat_golongan"); 
	} 
 
	public function getSource() 
	{ 
		return 'ref_pangkat_golongan'; 
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
