<?php

namespace App\Providers;

use App\Controllers\HelloWorldController;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;

class RoutesServiceProvider extends ServiceProvider {

    public function boot() {

        Route::get('/', HelloWorldController::class . '@helloWorld');

    }

}