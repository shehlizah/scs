<?php 
class TestOnlineSiswaDetail extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("test_online_siswa_detail"); 
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
