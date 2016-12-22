<?php
$rootDir = dirname(__DIR__);

require $rootDir . '/vendor/autoload.php';

$server = new Flarum\Admin\Server($rootDir, __DIR__);
$server->setConfig(require $rootDir . '/config/app.php');

$server->listen();
