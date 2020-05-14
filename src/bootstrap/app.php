<?php

try {
    (Dotenv\Dotenv::createImmutable(__DIR__ . '/..'))->load();
} catch (\Dotenv\Exception\InvalidPathException $exception) {
    // ignore if there is no .env
}

$app = new Laravel\Lumen\Application(__DIR__ . '/..');

$app->withFacades();

$app->withEloquent();

$app->singleton(
    Illuminate\Contracts\Debug\ExceptionHandler::class,
    Toolkit\Helpers\ExceptionHandlers\ApiExceptionHandler::class
);

$app->singleton(
    Illuminate\Contracts\Console\Kernel::class,
    Laravel\Lumen\Console\Kernel::class
);

$app->configure('app');
$app->configure('config');
$app->configure('cache');

//$app->middleware([
//    \Crossbow\Helpers\Middlewares\LocaleMiddleware::class,
//    \Crossbow\Helpers\Middlewares\HealthCheckMiddleware::class,
//    \Crossbow\Helpers\Middlewares\BasicAuthMiddleware::class
//]);

// register service providers from config/app.php
foreach (\Illuminate\Support\Facades\Config::get('app.providers') as $provider) {
    $app->register($provider);
}

$timezone = \Illuminate\Support\Facades\Config::get('app.timezone');

if (in_array($timezone, timezone_identifiers_list())) {
    date_default_timezone_set(\Illuminate\Support\Facades\Config::get('app.timezone'));
}

return $app;
