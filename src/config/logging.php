<?php

use Monolog\Handler\StreamHandler;

return [

    'default' => env('LOG_CHANNEL', 'stderr'),
    'channels' => [
        'stderr' => [
            'driver' => 'monolog',
            'name' => env('APP_NAME', 'laravel'),
            'handler' => StreamHandler::class,
            'with' => [
                'stream' => 'php://stderr'
            ]
        ]
    ]

];
