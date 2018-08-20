<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 6/12/18
 * Time: 8:16 PM
 */

namespace App;

use Illuminate\Foundation\Application as BaseApplication;

class Application extends BaseApplication {

    public function getNamespace()
    {
        return $this->namespace = 'App';
    }

}