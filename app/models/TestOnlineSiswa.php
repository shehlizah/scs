<?php 
class TestOnlineSiswa extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("test_online_siswa"); 
	} 
 
	public function getSource() 
	{ 
		return 'test_online_siswa'; 
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
