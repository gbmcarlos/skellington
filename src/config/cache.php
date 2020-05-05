<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 7/17/18
 * Time: 3:47 PM
 */

return [

    'default' => env('CACHE_DRIVER', 'file'),
    'stores' => [
        'file' => [
            'driver' => 'file',
            'path' => storage_path('cache')
        ],
        'redis' => [
            'driver' => 'redis',
            'connection' => 'redis'
        ]
    ],
    'prefix' => env(
        'CACHE_PREFIX',
        env('APP_NAME', 'laravel') . '_cache'
    )
];
