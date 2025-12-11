<?php
use Phalcon\Acl\Enum\Action;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Phalcon\Events\Event;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory as AclList;
use Phalcon\Di\InjectionAwareInterface;
use Phalcon\Di\DiInterface;

class SecurityPlugin implements InjectionAwareInterface
{
    protected $di;
    private $auth=false;
    private $roles='Guests';

    public function __construct()
    {
        $this->auth = false;
        $this->roles = 'Guests';
    }

    public function setDI(DiInterface $container): void
    {
        $this->di = $container;
    }

    public function getDI(): DiInterface
    {
        return $this->di;
    }

    /**
     * Initialize auth from session when needed
     */
    private function initAuth()
    {
        if ($this->di && $this->di->has('session')) {
            try {
                $session = $this->di->get('session');
                if ($session && $session->has('auth')) {
                    $this->auth = $session->get('auth');
                }
            } catch (\Exception $e) {
                $this->auth = false;
            }
        }
    }

    /**
     * Safe getter for modelsManager from DI container
     */
    private function getModelsManager()
    {
        if (!$this->di) {
            return null;
        }
        try {
            if ($this->di->has('modelsManager')) {
                return $this->di->get('modelsManager');
            }
        } catch (\Exception $e) {
            return null;
        }
        return null;
    }

    /**
	 * register roles users
	 */
    private function rolesUsers()
    {
        if($this->auth != false)
        {
            $roles[$this->auth->roles]=new Role($this->auth->roles,'Member users');
        }

        $roles['Guests']=new Role('Guests','Anyone browsing the site who is not signed in is considered to be a "Guest".');
        return $roles;
    }

    /**
	 * Public area resources for roles users "Guests"
	 */
    private function publicResources()
    {
		$publicResources = array(
			'index'      => array('*'),
            'auth'       => array('*'),
            'error'       => array('*'),
            'api'        => array('*'),
            'docs'       => array('*'),
            'start'       => array('*'),
            'ubahpassword' => array('*'),
            'guestquestion' => array('*'),
            'daftar' => array('*'),

		);

        return $publicResources;
    }

    /**
	 * Private all resources for roles users "Member"
	 */
    public function privateAllResource()
    {
        $data=[];
        $modelsManager = $this->getModelsManager();
        
        if (!$modelsManager) {
            return $data;
        }
        
        try {
            $resource = $modelsManager->createBuilder()
                ->from("MAccessList")
                ->columns("MAccessList.resources_name,MAccessList.roles")
                ->join("MMenu","MMenu.resources_name=MAccessList.resources_name AND MMenu.access_name=MAccessList.access_name")
                ->where("MAccessList.roles='$this->roles'")
                ->groupBy("MAccessList.resources_name,MAccessList.roles")
                ->getQuery()
                ->execute();

            if($resource)
            {
                foreach($resource as $r)
                {
                    $access=MAccessList::find(
                        [
                            "roles = :roles: AND resources_name = :resources_name:",
                            "columns"=>"access_name",
                            "bind"=>[
                                "roles"=>$r->roles,
                                "resources_name"=>$r->resources_name
                            ]
                        ]
                    );
                    $data[$r->resources_name]=[];
                    if($access)
                    {
                        $accessList=[];
                        foreach($access as $a)
                        {
                            $accessList[]=$a->access_name;
                        }
                        $data[$r->resources_name]=$accessList;
                    }
                }
            }
        } catch (\Exception $e) {
            // Return empty data on error
            return $data;
        }
        
        return $data;
    }

    /**
	 * get private allow/deny resources for roles users "Member"
	 */
    private function PrivateResources($allowed=1)
    {
        $data=[];
        $modelsManager = $this->getModelsManager();
        
        if (!$modelsManager) {
            return $data;
        }
        
        try {
            $resource = $modelsManager->createBuilder()
                ->from("MAccessList")
                ->columns("MAccessList.resources_name,MAccessList.roles,MAccessList.access_name,MAccessList.allowed")
                ->join("MMenu","MMenu.resources_name=MAccessList.resources_name AND MMenu.access_name=MAccessList.access_name")
                ->groupBy("MAccessList.resources_name,MAccessList.roles,MAccessList.access_name,MAccessList.allowed")
                ->where("MAccessList.roles='$this->roles' AND MAccessList.allowed=$allowed")
                ->getQuery()
                ->execute();
                
            if($resource)
            {
                foreach($resource as $r)
                {
                    $access=MAccessList::find(
                        [
                            "roles = :roles: AND resources_name = :resources_name: AND allowed = :allowed:",
                            "columns"=>"access_name",
                            "bind"=>[
                                "roles"=>$r->roles,
                                "resources_name"=>$r->resources_name,
                                "allowed"=>$r->allowed
                            ]
                        ]
                    );
                    $data[$r->resources_name]=[];
                    if($access)
                    {
                        $accessList=[];
                        foreach($access as $a)
                        {
                            $accessList[]=$a->access_name;
                        }
                        $data[$r->resources_name]=$accessList;
                    }
                }
            }
        } catch (\Exception $e) {
            // Return empty data on error
            return $data;
        }
        
        return $data;
    }

    /**
	 * ACL - Phalcon 3.x and 4.0+ compatibility wrapper
	 */
    public function getAcl()
    {
        $acl = new AclList();
        
        // Set default action based on Phalcon version
        $denyAction = class_exists('Phalcon\\Acl\\Enum\\Action') ? Action::DENY : 0;
        $allowAction = class_exists('Phalcon\\Acl\\Enum\\Action') ? Action::ALLOW : 1;
        
        // Phalcon 4: check method signature
        if (method_exists($acl, 'setDefaultAction')) {
            try {
                $acl->setDefaultAction($denyAction);
            } catch (\Exception $e) {
                // Fallback if setDefaultAction signature is incompatible
            }
        }
        
        $roles = $this->rolesUsers();
        $publicResources = $this->publicResources();

        /**
    	 * register role users
    	 */
        foreach ($roles as $role) {
            try {
                $acl->addRole($role);
            } catch (\Exception $e) {
                // Skip if role already added or other issue
            }
        }

        /**
    	 * register public resources - handle both Phalcon 3 & 4 APIs
    	 */
        foreach ($publicResources as $resource => $actions) {
            try {
                // Phalcon 4+: addComponent() method
                if (method_exists($acl, 'addComponent')) {
                    $acl->addComponent($resource, $actions);
                } 
                // Phalcon 3.x: addResource() with Resource object
                else if (method_exists($acl, 'addResource')) {
                    $acl->addResource(new Resource($resource), $actions);
                }
            } catch (\Exception $e) {
                // Skip on error
            }
        }

        /**
    	 * allow access resource for all roles
    	 */
        foreach ($publicResources as $resource => $actions) {
            foreach ($actions as $action) {
                try {
                    $acl->allow($this->roles, $resource, $action);
                } catch (\Exception $e) {
                    // Skip on error
                }
            }
        }

        /**
    	 * allow resource roles users
    	 */
        $privateAllResource = $this->privateAllResource();
        $allowResources = $this->PrivateResources(1);
        
        if ($this->auth != false) {
            /**
        	 * register private resources
        	 */
            if ($privateAllResource != null) {
                foreach ($privateAllResource as $resource => $actions) {
                    try {
                        if (method_exists($acl, 'addComponent')) {
                            $acl->addComponent($resource, $actions);
                        } else if (method_exists($acl, 'addResource')) {
                            $acl->addResource(new Resource($resource), $actions);
                        }
                    } catch (\Exception $e) {
                        // Skip on error
                    }
                }
            }
            
            /**
        	 * allow private resources
        	 */
            if ($allowResources != null) {
                foreach ($allowResources as $resource => $actions) {
                    foreach ($actions as $action) {
                        try {
                            $acl->allow($this->roles, $resource, $action);
                        } catch (\Exception $e) {
                            // Skip on error
                        }
                    }
                }
            }
        }

        return $acl;
    }


    /**
	 * This action is executed before execute any action in the application
	 *
	 * @param Event $event
	 * @param Dispatcher $dispatcher
	 * @return bool
	 */
	public function beforeDispatch(Event $event, Dispatcher $dispatcher)
	{
        // Initialize auth from session
        $this->initAuth();
        
        $controller = $dispatcher->getControllerName();
        $action = $dispatcher->getActionName();
        $acl = $this->getAcl();
        
        $allowValue = class_exists('Phalcon\\Acl\\Enum\\Action') ? Action::ALLOW : 1;
        
        if($this->auth != false)
        {
            $this->roles = $this->auth->roles;
            $acl = $this->getAcl();
            $allowed = $acl->isAllowed($this->roles, $controller, $action);

            /**
        	 * show error 404 on resource not register
        	 */
            if(!$acl->isResource($controller))
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward([
        				'controller' => 'error',
        				'action'     => 'ajax404'
        			]);
                }
                else
                {
                    $dispatcher->forward([
        				'controller' => 'error',
        				'action'     => 'error404'
        			]);
                }

                return false;
            }

            /**
        	 * show error 403 forbidden access
        	 */

            if($allowed != $allowValue)
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'ajax403'
        			));
                }
                else
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'error403'
        			));
                }
                return false;
            }
        }
        else
        {
            /**
        	 * show login page
        	 */
            $allowed = $acl->isAllowed($this->roles, $controller, $action);
            if(!$allowed)
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'errorLogin'
        			));
                }
                else
                {
                    $dispatcher->forward(array(
        				'controller' => 'auth',
        				'action'     => 'index'
        			));
                }
                return false;
            }
        }
	}
}
