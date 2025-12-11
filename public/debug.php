<?php
// Test database connection and basic app setup
error_reporting(E_ALL);
ini_set('display_errors', '1');

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');

echo "=== SCS HQ Debug Info ===\n\n";

// 1. Check .env file
echo "1. Checking .env file...\n";
$env_file = APP_PATH . '/config/env/.env';
if (file_exists($env_file)) {
    echo "   ✓ .env file found\n";
    $env = parse_ini_file($env_file);
    echo "   DB_HOST: " . $env['DB_HOST'] . "\n";
    echo "   DB_NAME: " . $env['DB_NAME'] . "\n";
} else {
    echo "   ✗ .env file NOT found\n";
}

// 2. Check Phalcon installation
echo "\n2. Checking Phalcon installation...\n";
if (extension_loaded('phalcon')) {
    echo "   ✓ Phalcon extension loaded\n";
    if (class_exists('Phalcon\Version')) {
        echo "   Version: " . \Phalcon\Version::get() . "\n";
    }
} else {
    echo "   ✗ Phalcon extension NOT loaded\n";
}

// 3. Check vendor autoload
echo "\n3. Checking vendor autoload...\n";
$autoload = BASE_PATH . '/vendor/autoload.php';
if (file_exists($autoload)) {
    echo "   ✓ Vendor autoload found\n";
    include $autoload;
    echo "   ✓ Vendor autoload loaded\n";
} else {
    echo "   ✗ Vendor autoload NOT found\n";
}

// 4. Check dotenv
echo "\n4. Checking DotEnv...\n";
try {
    $dotenv = new Dotenv\Dotenv(APP_PATH.'/config/env');
    $dotenv->load();
    echo "   ✓ DotEnv loaded\n";
} catch (\Exception $e) {
    echo "   ✗ DotEnv error: " . $e->getMessage() . "\n";
}

// 5. Test database connection
echo "\n5. Testing database connection...\n";
try {
    $host = getenv('DB_HOST');
    $user = getenv('DB_USER');
    $pass = getenv('DB_PASS');
    $name = getenv('DB_NAME');
    
    $pdo = new PDO(
        'mysql:host=' . $host . ';dbname=' . $name,
        $user,
        $pass,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    echo "   ✓ Database connection successful\n";
    
    // Check some tables
    $result = $pdo->query("SHOW TABLES LIMIT 5");
    $tables = $result->fetchAll();
    echo "   Tables found: " . count($tables) . "\n";
    
} catch (\Exception $e) {
    echo "   ✗ Database connection failed: " . $e->getMessage() . "\n";
}

// 6. Check config file
echo "\n6. Checking config files...\n";
$files = ['config.php', 'loader.php', 'router.php', 'services.php'];
foreach ($files as $file) {
    $path = APP_PATH . '/config/' . $file;
    if (file_exists($path)) {
        echo "   ✓ " . $file . " exists\n";
    } else {
        echo "   ✗ " . $file . " NOT found\n";
    }
}

// 7. Check controllers directory
echo "\n7. Checking controllers...\n";
$controller = APP_PATH . '/controllers/IndexController.php';
if (file_exists($controller)) {
    echo "   ✓ IndexController found\n";
} else {
    echo "   ✗ IndexController NOT found\n";
}

echo "\n=== End Debug Info ===\n";
?>
