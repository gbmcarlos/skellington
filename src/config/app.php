<?php

return [
    'project_name' => env('PROJECT_NAME', 'lumen'),
    'env' => env('APP_ENV', 'dev'),
    'debug' => env('APP_DEBUG', false),
    'url' => env('APP_URL', 'http://localhost'),
    'timezone' => env('TZ', 'UTC') ?: 'UTC',
    'fallback_locale' => env('FALLBACK_LOCALE', 'en_GB'),
    'available_locales' => env('AVAILABLE_LOCALES', 'en_GB'),
    'key' => env('APP_KEY'),
    'cipher' => 'AES-256-CBC',
    'providers' => [
        /*
         * Shared Bundle Service Providers
         */
        App\Shared\Resources\ViewsServiceProvider::class,
        App\Shared\Resources\ConfigServiceProvider::class,

        /*
         * Acme Bundle Service Providers
         */
        App\Acme\Resources\RoutesServiceProvider::class,
        App\Acme\Resources\ViewsServiceProvider::class,

        /*
         * Laravel Framework Service Providers
         */
        Illuminate\Auth\AuthServiceProvider::class,
        Illuminate\Broadcasting\BroadcastServiceProvider::class,
        Illuminate\Bus\BusServiceProvider::class,
        Illuminate\Cache\CacheServiceProvider::class,
        Illuminate\Foundation\Providers\ConsoleSupportServiceProvider::class,
        Illuminate\Cookie\CookieServiceProvider::class,
        Illuminate\Database\DatabaseServiceProvider::class,
        Illuminate\Encryption\EncryptionServiceProvider::class,
        Illuminate\Filesystem\FilesystemServiceProvider::class,
        Illuminate\Foundation\Providers\FoundationServiceProvider::class,
        Illuminate\Hashing\HashServiceProvider::class,
        Illuminate\Mail\MailServiceProvider::class,
        Illuminate\Notifications\NotificationServiceProvider::class,
        Illuminate\Pagination\PaginationServiceProvider::class,
        Illuminate\Pipeline\PipelineServiceProvider::class,
        Illuminate\Queue\QueueServiceProvider::class,
        Illuminate\Redis\RedisServiceProvider::class,
        Illuminate\Auth\Passwords\PasswordResetServiceProvider::class,
        Illuminate\Session\SessionServiceProvider::class,
        Illuminate\Translation\TranslationServiceProvider::class,
        Illuminate\Validation\ValidationServiceProvider::class,
        Illuminate\View\ViewServiceProvider::class,
    ]
];
