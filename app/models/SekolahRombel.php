<?php 
class SekolahRombel extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("sekolah_rombel"); 
	} 
 
	public function getSource() 
	{ 
		return 'sekolah_rombel'; 
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
