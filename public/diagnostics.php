<?php
// Diagnostic script to check database configuration
error_reporting(E_ALL);
ini_set('display_errors', '1');

echo "=== SCS HQ Database Configuration Check ===\n\n";

// Load environment
$env_file = __DIR__ . '/app/config/env/.env';
if (file_exists($env_file)) {
    $env = parse_ini_file($env_file);
    echo "✓ .env file loaded\n";
    echo "  - DB Host: " . $env['DB_HOST'] . "\n";
    echo "  - DB Name: " . $env['DB_NAME'] . "\n";
    echo "  - DB User: " . $env['DB_USER'] . "\n";
    echo "  - BASE_URI: " . $env['BASE_URI'] . "\n";
} else {
    echo "✗ .env file not found\n";
    exit(1);
}

// Test database connection
try {
    $pdo = new PDO(
        'mysql:host=' . $env['DB_HOST'] . ';dbname=' . $env['DB_NAME'],
        $env['DB_USER'],
        $env['DB_PASS'],
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    echo "\n✓ Database connection successful\n";
    
    // Check if settings table exists and list settings
    $query = $pdo->query("SELECT name, value FROM settings LIMIT 20");
    $settings = $query->fetchAll(PDO::FETCH_ASSOC);
    
    echo "\n=== Current Settings in Database ===\n";
    foreach ($settings as $setting) {
        echo "  - " . $setting['name'] . ": " . substr($setting['value'], 0, 100) . "\n";
    }
    
    // Check important settings
    echo "\n=== Important Settings to Check ===\n";
    $important = ['app_url', 'base_url', 'website_url', 'api_url', 'site_url'];
    foreach ($important as $key) {
        $result = $pdo->query("SELECT value FROM settings WHERE name = '$key'")->fetch(PDO::FETCH_ASSOC);
        if ($result) {
            echo "  ✓ $key: " . $result['value'] . "\n";
        } else {
            echo "  - $key: NOT SET\n";
        }
    }
    
} catch (\PDOException $e) {
    echo "\n✗ Database connection failed!\n";
    echo "  Error: " . $e->getMessage() . "\n";
    echo "\nPlease check:\n";
    echo "  1. Database is running on " . $env['DB_HOST'] . "\n";
    echo "  2. Database '" . $env['DB_NAME'] . "' exists\n";
    echo "  3. User '" . $env['DB_USER'] . "' has access\n";
    echo "  4. Password is correct\n";
}

echo "\n";
?>
