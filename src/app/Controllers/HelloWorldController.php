<?php
/**
 * Created by PhpStorm.
 * User: abhishekshukla
 * Date: 2/5/19
 * Time: 12:15 PM
 */

namespace App\Controllers;

class HelloWorldController {

    public function helloWorld() {
        return view('pages/hello-world');
    }

}