<?php 
class RefMapel extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("ref_mapel"); 
	} 
 
	public function getSource() 
	{ 
		return 'ref_mapel'; 
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
