<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 8/20/18
 * Time: 5:34 PM
 */

namespace App\Acme\Resources;

use Illuminate\Foundation\Support\Providers\RouteServiceProvider;
use Illuminate\Support\Facades\Route;

class RoutesServiceProvider extends RouteServiceProvider {

    public function map() {

        Route::get('/', 'App\Acme\Controllers\HelloWorldController@helloWorld')->name('hello-world');

    }

}