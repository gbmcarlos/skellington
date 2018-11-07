<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 8/20/18
 * Time: 5:36 PM
 */

namespace App\Acme\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class HelloWorldController {

    public function helloWorld(Request $request) {

        $greeting = __('greeting', ['name' => 'World']);

        return $greeting;
    }

}