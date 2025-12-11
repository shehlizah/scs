<?php

$router = $di->getRouter();

// Define your routes here

// Handle the request URI
$uri = $_GET['_url'] ?? '/';
$router->handle($uri);