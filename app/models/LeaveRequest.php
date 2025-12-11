<?php 
class LeaveRequest extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("leave_request"); 
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
