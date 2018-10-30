<?php

$app = new \App\Application(realpath(__DIR__.'/../'));

$app->singleton(
    Illuminate\Contracts\Http\Kernel::class,
    App\HttpKernel::class
);

$app->singleton(
    Illuminate\Contracts\Console\Kernel::class,
    App\ConsoleKernel::class
);

$app->singleton(
    Illuminate\Contracts\Debug\ExceptionHandler::class,
    Illuminate\Foundation\Exceptions\Handler::class
);

date_default_timezone_set(\Illuminate\Support\Facades\Config::get('app.timezone'));

return $app;
