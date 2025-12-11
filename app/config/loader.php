<?php

// Handle Phalcon Loader compatibility (v3 vs v4+)
if (class_exists('\Phalcon\Autoload\Loader')) {
    // Phalcon 4.0+
    $loader = new \Phalcon\Autoload\Loader();
    $loader->setDirectories([
        $config->application->controllersDir,
        $config->application->modelsDir,
        $config->application->viewsDir,
        $config->application->helpersDir,
        $config->application->pluginsDir,
        $config->application->libraryDir
    ]);
} else {
    // Phalcon 3.x
    $loader = new \Phalcon\Loader();
    $loader->registerDirs([
        $config->application->controllersDir,
        $config->application->modelsDir,
        $config->application->viewsDir,
        $config->application->helpersDir,
        $config->application->pluginsDir,
        $config->application->libraryDir
    ]);
}

$loader->register();
