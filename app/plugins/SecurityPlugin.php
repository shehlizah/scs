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
        $resource=$this->modelsManager->createBuilder()
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
        return $data;
    }

    /**
	 * get private allow/deny resources for roles users "Member"
	 */
    private function PrivateResources($allowed=1)
    {
        $data=[];
        $resource=$this->modelsManager->createBuilder()
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
        return $data;
    }

    /**
	 * ACL
	 */
    public function getAcl()
    {
        $acl = new AclList();
        // Phalcon 4 uses Enum\Action for allow/deny
        if (class_exists('Phalcon\\Acl\\Enum\\Action')) {
            $acl->setDefaultAction(Action::DENY);
        }
        $roles=$this->rolesUsers();
        $publicResources=$this->publicResources();

        /**
    	 * register role users
    	 */
        foreach ($roles as $role) {
			$acl->addRole($role);
		}

        /**
    	 * register public resources
    	 */
		foreach ($publicResources as $resource => $actions) {
			$acl->addResource(new Resource($resource), $actions);
		}

        /**
    	 * allow access resource for all roles
    	 */
		foreach ($publicResources as $resource => $actions) {
			foreach ($actions as $action){
				$acl->allow($this->roles, $resource, $action);
			}
		}

        /**
    	 * allow resource roles users
    	 */
        $privateAllResource=$this->privateAllResource();
        $allowResources=$this->PrivateResources(1);
        if($this->auth != false)
        {
           /**
        	 * register private resources
        	 */
    		if($privateAllResource != null)
            {
                foreach ($privateAllResource as $resource => $actions) {
        			$acl->addResource(new Resource($resource), $actions);
        		}
            }
            if($allowResources != null)
            {
                foreach ($allowResources as $resource => $actions) {
        			foreach ($actions as $action){
        				$acl->allow($this->roles, $resource, $action);
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

            if($allowed != (class_exists('Phalcon\\Acl\\Enum\\Action') ? Action::ALLOW : 1))
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
