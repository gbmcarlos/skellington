<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 6/18/18
 * Time: 6:11 PM
 */

namespace App\Shared\Resources;

use Illuminate\Support\Facades\Config;
use Illuminate\Support\Facades\View as ViewFacade;
use Illuminate\Contracts\View\View;
use Illuminate\Support\ServiceProvider;

class ViewsServiceProvider extends ServiceProvider {

    public function register() {
        Config::set('view', array(
            'paths' => [realpath(app_path('Shared/Resources/views'))],
            'compiled' => realpath(storage_path('framework/views'))
        ));

    }

    public function boot() {

        ViewFacade::composer('*', function(View $view) {
            $view->with('exposed_config', Config::get('exposed_config'));
        });

    }

}