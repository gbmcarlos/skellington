<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 7/11/18
 * Time: 3:42 PM
 */

return [
    'name' => env('APP_NAME', 'lumen'),
    'debug' => env('APP_DEBUG', false),
    'env' => env('APP_ENV', 'production'),
    'timezone' => env('TZ', 'UTC'),
    'fallback_locale' => env('FALLBACK_LOCALE', 'en_US'),
    'available_locales' => env('AVAILABLE_LOCALES', 'en_US'),
    'release' => env('APP_RELEASE', 'latest'),
    'key' => env('APP_KEY'),
    'cipher' => 'AES-256-CBC',
    'providers' => [

        \App\Providers\RoutesServiceProvider::class,

        /*
         * Laravel Framework Service Providers...
         * Uncomment those that you want
         */
        Illuminate\Encryption\EncryptionServiceProvider::class,
        Illuminate\Filesystem\FilesystemServiceProvider::class,
        Illuminate\Cache\CacheServiceProvider::class,
        Illuminate\Session\SessionServiceProvider::class,
        Illuminate\View\ViewServiceProvider::class,
        Illuminate\Validation\ValidationServiceProvider::class,
        Illuminate\Translation\TranslationServiceProvider::class,
//        Illuminate\Database\DatabaseServiceProvider::class,
//        Illuminate\Foundation\Providers\FoundationServiceProvider::class,
//        Illuminate\Redis\RedisServiceProvider::class,
//        Illuminate\Auth\AuthServiceProvider::class,
//        Illuminate\Broadcasting\BroadcastServiceProvider::class,
//        Illuminate\Bus\BusServiceProvider::class,
//        Illuminate\Foundation\Providers\ConsoleSupportServiceProvider::class,
//        Illuminate\Cookie\CookieServiceProvider::class,
//        Illuminate\Hashing\HashServiceProvider::class,
//        Illuminate\Mail\MailServiceProvider::class,
//        Illuminate\Notifications\NotificationServiceProvider::class,
//        Illuminate\Pagination\PaginationServiceProvider::class,
//        Illuminate\Pipeline\PipelineServiceProvider::class,
//        Illuminate\Queue\QueueServiceProvider::class,
//        Illuminate\Auth\Passwords\PasswordResetServiceProvider::class,
    ]
];