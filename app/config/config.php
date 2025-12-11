<?php
/*
 * Modified: prepend directory path of current file, because of this file own different ENV under between Apache and command line.
 * NOTE: please remove this comment.
 */
defined('BASE_PATH') || define('BASE_PATH', getenv('BASE_PATH') ?: realpath(dirname(__FILE__) . '/../..'));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/app');
include BASE_PATH . '/vendor/autoload.php';
$dotenv = new Dotenv\Dotenv(APP_PATH.'/config/env');
$dotenv->load();

// Handle Phalcon Config class compatibility (v3 vs v4+)
$configClass = class_exists('\Phalcon\Config\Config') ? '\Phalcon\Config\Config' : '\Phalcon\Config';

return new $configClass([
    'database' => [
        'adapter'     => 'Mysql',
        'host'        => getenv('DB_HOST'),
        'username'    => getenv('DB_USER'),
        'password'    => getenv('DB_PASS'),
        'dbname'      => getenv('DB_NAME'),
        'charset'     => 'utf8',
    ],
    'database_report' => [
        'adapter'     => 'Mysql',
        'host'        => getenv('DB_REPORT_HOST'),
        'username'    => getenv('DB_REPORT_USER'),
        'password'    => getenv('DB_REPORT_PASS'),
        'dbname'      => getenv('DB_REPORT_NAME'),
        'charset'     => 'utf8',
    ],
    'application' => [
        'appDir'         => APP_PATH . '/',
        'controllersDir' => APP_PATH . '/controllers/',
        'modelsDir'      => APP_PATH . '/models/',
        'migrationsDir'  => APP_PATH . '/migrations/',
        'viewsDir'       => APP_PATH . '/views/',
        'pluginsDir'     => APP_PATH . '/plugins/',
        'libraryDir'     => APP_PATH . '/library/',
        'cacheDir'       => BASE_PATH . '/cache/',
        'helpersDir'     => APP_PATH . '/helpers/',
        'swaggerDir'     => APP_PATH . '/swagger/',
        // 'baseUri'        => getenv('BASE_URI')
        'baseUri'        => 'http://'.$_SERVER['HTTP_HOST'].'/'
        // This allows the baseUri to be understand project paths that are not in the root directory
        // of the webpspace.  This will break if the public/index.php entry point is moved or
        // possibly if the web server rewrite rules are changed. This can also be set to a static path.
        //'baseUri'        => preg_replace('/public([\/\\\\])index.php$/', '', $_SERVER["PHP_SELF"]),
    ],
    'logs'=>[
        'dir'           => APP_PATH . '/logs/',
        'filename'      => date('Y-m-d').'.log',
        'foldername'    => date('Ym')
    ],
    'nodeflux'=>[
        'header'        => [
            'Content-Type: application/json',
            'Authorization: NODEFLUX-HMAC-SHA256 Credential='.getenv('NFX_ACCESS_KEY').'/'.substr(getenv('NFX_TIMESTAMP'),0,8).'/nodeflux.api.v1beta1.ImageAnalytic/StreamImageAnalytic, SignedHeaders=x-nodeflux-timestamp, Signature='.getenv('NFX_TOKEN').'',
            'x-nodeflux-timestamp: '.getenv('NFX_TIMESTAMP').''
        ],
    ]
]);