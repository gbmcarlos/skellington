<?php

require '/opt/vendor/autoload.php';

$app = require __DIR__ . '/../bootstrap/app.php';

$bootstrap = new \Toolkit\Libraries\Foundation\Laravel\Bootstrap($app);

$bootstrap->handle();
