<?php
use Phalcon\Events\Event;
use Phalcon\Dispatcher;
use Phalcon\Mvc\Dispatcher\Exception as DispatcherException;
use Phalcon\Mvc\Dispatcher as MvcDispatcher;
use Phalcon\Di\InjectionAwareInterface;

/**
 * ExceptionPlugin
 *
 * Handles not-found controller/actions
 */
class ExceptionPlugin implements InjectionAwareInterface
{
	protected $di;

	public function setDI($di)
	{
		$this->di = $di;
	}

	public function getDI()
	{
		return $this->di;
	}
	/**
	 * This action is executed before execute any action in the application
	 *
	 * @param Event $event
	 * @param MvcDispatcher $dispatcher
	 * @param \Exception $exception
	 * @return boolean
	 */
	public function beforeException(Event $event, MvcDispatcher $dispatcher, \Exception $exception)
	{
		//error_log($exception->getMessage() . PHP_EOL . $exception->getTraceAsString());
        //throw new Exception($exception->getCode());
		if ($exception instanceof DispatcherException) {
			switch ($exception->getCode()) {
				case Dispatcher::EXCEPTION_HANDLER_NOT_FOUND:
				case Dispatcher::EXCEPTION_ACTION_NOT_FOUND:
					$dispatcher->forward(
						[
							'controller' => 'error',
							'action'     => 'error404'
						]
					);
					return false;
			}
		}
        
	}
}