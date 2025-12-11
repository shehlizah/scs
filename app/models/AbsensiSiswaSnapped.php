<?php 
class AbsensiSiswaSnapped extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("absensi_siswa_snapped"); 
	} 
 
	public function getSource() 
	{ 
		return 'absensi_siswa_snapped'; 
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
