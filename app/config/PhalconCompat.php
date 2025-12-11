<?php
/**
 * Phalcon Version Compatibility Helpers
 * Handles differences between Phalcon 3.x and 4.0+
 */

class PhalconCompat {
    
    /**
     * Get the correct Config class
     */
    public static function getConfigClass() {
        return class_exists('\Phalcon\Config\Config') ? '\Phalcon\Config\Config' : '\Phalcon\Config';
    }
    
    /**
     * Get the correct Loader class
     */
    public static function getLoaderClass() {
        return class_exists('\Phalcon\Autoload\Loader') ? '\Phalcon\Autoload\Loader' : '\Phalcon\Loader';
    }
    
    /**
     * Create config instance
     */
    public static function createConfig($array) {
        $class = self::getConfigClass();
        return new $class($array);
    }
    
    /**
     * Create loader instance
     */
    public static function createLoader() {
        $class = self::getLoaderClass();
        return new $class();
    }
    
    /**
     * Get Phalcon version
     */
    public static function getPhalconVersion() {
        if (class_exists('\Phalcon\Version')) {
            return \Phalcon\Version::get();
        }
        return 'unknown';
    }
}
?>
