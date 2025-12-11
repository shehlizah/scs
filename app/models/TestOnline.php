<?php 
class TestOnline extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("test_online"); 
	} 
 
	public function getSource() 
	{ 
		return 'test_online'; 
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
