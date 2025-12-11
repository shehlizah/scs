<?php 
class Siswa extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("siswa"); 
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
