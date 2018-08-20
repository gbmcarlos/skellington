<?php

namespace App;

use App\Admin\Commands\CreateAdminUser;
use App\Migration\Commands\RunETL;
use Illuminate\Foundation\Console\Kernel as BaseConsoleKernel;

class ConsoleKernel extends BaseConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [];

}
