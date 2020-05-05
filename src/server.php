<?php

require '/var/task/vendor/autoload.php';

$app = require __DIR__ . '/app.php';

$bootstrap = new \Toolkit\Libraries\Foundation\Lumen\Bootstrap($app);

$bootstrap->handle();
