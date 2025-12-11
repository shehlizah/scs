<?php 
class Erapor extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("erapor"); 
	} 
 
	public function getSource() 
	{ 
		return 'erapor'; 
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
