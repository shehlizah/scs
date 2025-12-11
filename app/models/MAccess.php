<?php 
class MAccess extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("m_access"); 
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
