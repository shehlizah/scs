<?php
// Complete database settings dump
error_reporting(E_ALL);
ini_set('display_errors', '1');

$env_file = __DIR__ . '/../app/config/env/.env';
$env = parse_ini_file($env_file);

try {
    $pdo = new PDO(
        'mysql:host=' . $env['DB_HOST'] . ';dbname=' . $env['DB_NAME'],
        $env['DB_USER'],
        $env['DB_PASS'],
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
    
    // Get ALL settings
    $query = $pdo->query("SELECT name, value FROM settings ORDER BY name");
    $settings = $query->fetchAll(PDO::FETCH_ASSOC);
    
    echo "=== ALL DATABASE SETTINGS ===\n";
    echo "Total settings: " . count($settings) . "\n\n";
    
    foreach ($settings as $setting) {
        $val = strlen($setting['value']) > 100 ? substr($setting['value'], 0, 100) . '...' : $setting['value'];
        echo $setting['name'] . " = " . $val . "\n";
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
