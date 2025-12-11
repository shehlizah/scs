<?php 
class StatusKepegawaian extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("status_kepegawaian"); 
	} 
 
	public function getSource() 
	{ 
		return 'status_kepegawaian'; 
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
