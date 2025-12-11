<?php 
class Facematch extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("facematch"); 
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
