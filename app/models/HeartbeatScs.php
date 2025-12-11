<?php 
class HeartbeatScs extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("heartbeat_scs"); 
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
