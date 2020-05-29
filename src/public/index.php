<?php

require '/opt/vendor/autoload.php';

$app = require '/var/task/src/bootstrap/app.php';

$bootstrap = new \Toolkit\Libraries\Foundation\Lumen\Bootstrap($app);

$bootstrap->handle();
