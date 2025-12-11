<?php 
class RefTahunAjaran extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("ref_tahun_ajaran"); 
	} 
 
	public function getSource() 
	{ 
		return 'ref_tahun_ajaran'; 
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
