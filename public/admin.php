<?php
$rootDir = dirname(__DIR__);

require $rootDir . '/vendor/autoload.php';

$server = new Flarum\Admin\Server($rootDir, __DIR__);

//if (file_exists(__DIR__ . '/config/app.php')) {
//    $server->setConfig(require __DIR__ . '/config/app.php.bak');
//}

$server->listen();
