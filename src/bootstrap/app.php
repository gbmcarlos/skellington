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
    App\Exceptions\Handler::class
);

return $app;
