<?php

try {
     (\Dotenv\Dotenv::create(__DIR__ . '../..'))->overload();
} catch ( Dotenv\Exception\InvalidPathException $e ) {
    //
}

$app = new Illuminate\Foundation\Application(dirname(__DIR__));

$app->singleton(
    Illuminate\Contracts\Http\Kernel::class,
    \Illuminate\Foundation\Http\Kernel::class
);

$app->singleton(
    Illuminate\Contracts\Console\Kernel::class,
    \Illuminate\Foundation\Console\Kernel::class
);

$app->singleton(
    Illuminate\Contracts\Debug\ExceptionHandler::class,
    Toolkit\Helpers\ExceptionHandlers\WebExceptionHandler::class
);

return $app;