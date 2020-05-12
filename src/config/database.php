<?php

return [

    'default' => '',
    'connections' => [],
    'redis' => [
        'client' => 'predis',
        'redis' => [
            'host' => env('REDIS_HOST', 'localhost'),
            'port' => env('REDIS_PORT', 6379),
            'password' => env('REDIS_PASSWORD', null),
            'database' => 0,
        ]
    ]

];
