<?php

namespace App\Providers;

use App\Controllers\HelloWorldController;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;

class RoutesServiceProvider extends ServiceProvider {

    public function boot() {

        Route::group(['prefix' => '/hello'], function () {

            // basic
            Route::get('/world', HelloWorldController::class . '@helloWorld');

        });
    }

}