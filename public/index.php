<?php
use Phalcon\Di\FactoryDefault;
date_default_timezone_set('Asia/Jakarta');

// Enable error reporting but suppress deprecations from older libraries
error_reporting(E_ALL & ~E_DEPRECATED & ~E_USER_DEPRECATED);
ini_set('display_errors', '1');
ini_set('log_errors', '1');
ini_set('error_log', __DIR__ . '/../app/logs/php_errors.log');

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');
include BASE_PATH . '/vendor/autoload.php';
$dotenv = new Dotenv\Dotenv(APP_PATH.'/config/env');
$dotenv->load();

try {

    /**
     * The FactoryDefault Dependency Injector automatically registers
     * the services that provide a full stack framework.
     */
    $di = new FactoryDefault();

    /**
     * Handle routes
     */
    include APP_PATH . '/config/router.php';

    /**
     * Read services
     */
    include APP_PATH . '/config/services.php';

    /**
     * Get config service for use in inline setup below
     */
    $config = $di->getConfig();

    /**
     * Include Autoloader
     */
    include APP_PATH . '/config/loader.php';

    /**
     * Handle the request
     */
    $application = new \Phalcon\Mvc\Application($di);

    // Get the request URI for Phalcon 4.0+ compatibility
    $uri = $_GET['_url'] ?? '/';
    
    // echo str_replace(["\n","\r","\t"], '', $application->handle($uri)->getContent());
    echo $application->handle($uri)->getContent();

} catch (\Exception $e) {
    error_log("Application Error: " . $e->getMessage());
    error_log("Error File: " . $e->getFile() . " Line: " . $e->getLine());
    error_log("Stack: " . $e->getTraceAsString());
    
    // Display error for debugging
    echo "<pre>";
    echo "Error: " . $e->getMessage() . "\n";
    echo "File: " . $e->getFile() . "\n";
    echo "Line: " . $e->getLine() . "\n";
    echo "Stack Trace:\n" . $e->getTraceAsString();
    echo "</pre>";
}
