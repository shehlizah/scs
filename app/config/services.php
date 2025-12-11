<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Php as PhpEngine;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Direct as Flash;
use Phalcon\Http\Request;
use Phalcon\Logger\Formatter\Line as LineFormatter;
use Phalcon\Logger\Adapter\File as FileAdapter;
use Phalcon\Mvc\Dispatcher as PhDispatcher;

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/config/config.php";
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setDI($this);
    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines([
        '.volt' => function ($view) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $this);

            $volt->setOptions([
                'compiledPath' => $config->application->cacheDir,
                'compiledSeparator' => '_',
                'compileAlways' => (bool)getenv('COMPILE')
            ]);

            return $volt;
        },
        '.phtml' => PhpEngine::class

    ]);

    return $view;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
    $config = $this->getConfig();

    $dbAdapter = $config->database->adapter;
    $params = [
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname,
        'charset'  => $config->database->charset
    ];

    if ($dbAdapter == 'Postgresql') {
        unset($params['charset']);
    }

    // Try Phalcon 4.0+ namespace first, fall back to 3.x
    $class = 'Phalcon\\Db\\Adapter\\Pdo\\' . $dbAdapter;
    if (!class_exists($class)) {
        $class = 'Phalcon\\Db\\Adapter\\Pdo\\' . ucfirst(strtolower($dbAdapter));
    }
    if (!class_exists($class)) {
        throw new Exception("Database adapter class not found: $class");
    }

    $connection = new $class($params);
    return $connection;
});

$di->setShared('db_report', function () {
    $config = $this->getConfig();

    $dbAdapter = $config->database_report->adapter;
    $params = [
        'host'     => $config->database_report->host,
        'username' => $config->database_report->username,
        'password' => $config->database_report->password,
        'dbname'   => $config->database_report->dbname,
        'charset'  => $config->database_report->charset
    ];

    if ($dbAdapter == 'Postgresql') {
        unset($params['charset']);
    }

    // Try Phalcon 4.0+ namespace first, fall back to 3.x
    $class = 'Phalcon\\Db\\Adapter\\Pdo\\' . $dbAdapter;
    if (!class_exists($class)) {
        $class = 'Phalcon\\Db\\Adapter\\Pdo\\' . ucfirst(strtolower($dbAdapter));
    }
    if (!class_exists($class)) {
        throw new Exception("Database adapter class not found: $class");
    }

    $connection = new $class($params);
    return $connection;
});


/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    $flashClass = class_exists('\Phalcon\Flash\Session') 
        ? '\Phalcon\Flash\Session' 
        : 'Phalcon\Flash\Direct';
    
    return new $flashClass([
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);
});

/**
 * Flash service with custom CSS classes
 */
$di->set('flashSession', function () {
    $flashClass = class_exists('\Phalcon\Flash\Session') 
        ? '\Phalcon\Flash\Session' 
        : 'Phalcon\Flash\Direct';
    
    return new $flashClass([
        'error'   => 'alert alert-danger alert-dismissible',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info alert-dismissible',
        'warning' => 'alert alert-warning'
    ]);
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    // Phalcon 4+: use Session\Manager with Adapter\Stream
    if (class_exists('Phalcon\\Session\\Manager')) {
        $manager = new \Phalcon\Session\Manager();
        // Prefer a writable path; fallback to system temp
        $savePath = is_dir(BASE_PATH . '/cache') ? (BASE_PATH . '/cache') : sys_get_temp_dir();
        // Stream adapter
        $adapter = new \Phalcon\Session\Adapter\Stream([
            'savePath' => $savePath
        ]);
        $manager->setAdapter($adapter);
        $manager->start();
        return $manager;
    }

    // Phalcon 3.x fallback
    $session = new SessionAdapter();
    $session->start();
    return $session;
});


/**
 * DISPATCH APPS
 * ERROR HANDLING
 * ACCESS CONTROL LISTS (ACL)
 */
$di->set('dispatcher', function() use ($di) {
    try {
        $evManager = $di->getShared('eventsManager');
        
        // Only attach plugins if they exist
        if (class_exists('SecurityPlugin')) {
            $securityPlugin = new SecurityPlugin();
            if (method_exists($securityPlugin, 'setDI')) {
                $securityPlugin->setDI($di);
            }
            $evManager->attach('dispatch:beforeDispatch', $securityPlugin);
        }
        if (class_exists('ExceptionPlugin')) {
            $exceptionPlugin = new ExceptionPlugin();
            if (method_exists($exceptionPlugin, 'setDI')) {
                $exceptionPlugin->setDI($di);
            }
            $evManager->attach('dispatch:beforeException', $exceptionPlugin);
        }
        
        $dispatcher = new PhDispatcher();
        $dispatcher->setEventsManager($evManager);
        return $dispatcher;
    } catch (\Exception $e) {
        // Log error but continue
        error_log("Dispatcher error: " . $e->getMessage());
        return new PhDispatcher();
    }
});

/**
 * LOGGER USERS ACTIVITY
 * FORMAT : [days, 05 May 17 23:57:49 +0700][log status] log message
 */
$di->setShared('logger', function() {
    $config = $this->getConfig();
    $path = $config->logs->dir;
    $foldername = $config->logs->foldername . '/';
    $filename = $config->logs->filename;
    
    if (!is_dir($path . $foldername)) {
        mkdir($path . $foldername, 0775, true);
    }
    
    $request = new Request();
    // Use shared session service to support both Phalcon 3 and 4
    $session = $this->getShared('session');
    $users = 'unknown users';
    
    if ($session->has('auth')) {
        $users = $session->auth->username;
    }
    
    $milliseconds = round(microtime(true) * 1000);
    $formatter = new LineFormatter('%date% : ' . $milliseconds . ' - [%type%][' . $request->getClientAddress() . '][' . $users . '] - %message%');
    
    // Use correct logger adapter class
    $loggerClass = class_exists('\Phalcon\Logger\Adapter\File') 
        ? '\Phalcon\Logger\Adapter\File' 
        : 'Phalcon\Logger\Adapter\File';
    
    $logger = new $loggerClass($path . $foldername . $filename);
    $logger->setFormatter($formatter);
    
    return $logger;
});

/**
 * app helpers
 */
$di->setShared('ars', function () {
    return new AjaxResponse();
});

$di->setShared('helpers', function () {
    return new MyHelpers();
});

$di->setShared('media', function () {
    return new MyMedia();
});

$di->setShared('myassets', function () {
    return new Myassets();
});

$di->setShared('alsus_inventory', function () {
    return new AlsusInventory();
});