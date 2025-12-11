<?php 
class AbsensiSiswa extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("absensi_siswa"); 
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
