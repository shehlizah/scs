<?php 
class Merk extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("merk"); 
	} 
 
	public function getSource() 
	{ 
		return 'merk'; 
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
