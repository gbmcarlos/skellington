<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 8/20/18
 * Time: 5:36 PM
 */

namespace App\Acme\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Config;

class HelloWorldController {

    public function helloWorld(Request $request) {

        $greeting = __('greeting', ['name' => 'World']);

        return [
            'greeting' => $greeting,
            'revision' => Config::get('app.revision')
        ];
    }

}