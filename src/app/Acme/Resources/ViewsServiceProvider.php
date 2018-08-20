<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 6/14/18
 * Time: 3:43 PM
 */

namespace App\Acme\Resources;

use Illuminate\Support\Facades\Config;
use Illuminate\Support\ServiceProvider;

class ViewsServiceProvider extends ServiceProvider {

    public function register() {
        Config::prepend('view.paths', realpath(app_path('Acme/Resources/views')));
    }

}