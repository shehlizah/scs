<?php 
class AbsensiKelas extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("absensi_kelas"); 
	} 
 
	public function getSource() 
	{ 
		return 'absensi_kelas'; 
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
