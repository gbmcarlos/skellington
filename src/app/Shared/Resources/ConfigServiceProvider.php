<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 6/18/18
 * Time: 6:49 PM
 */

namespace App\Shared\Resources;

use Illuminate\Support\Facades\Config;
use Illuminate\Support\ServiceProvider;

class ConfigServiceProvider extends ServiceProvider {

    public function boot() {
        Config::set('exposed_config', array(
            'APP_DEBUG' => Config::get('app.debug'),
            'site_name' => Config::get('config.site_name'),
            'endpoints' => array()
        ));
    }

}