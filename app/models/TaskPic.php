<?php 
class TaskPic extends \Phalcon\Mvc\Model 
{ 
   public function initialize() 
	{ 
		$this->setSource("task_pic"); 
	} 
 
	public function getSource() 
	{ 
		return 'task_pic'; 
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
