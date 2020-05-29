<?php

require '/opt/vendor/autoload.php';

$app = require getenv('LAMBDA_TASK_ROOT') . '/src/bootstrap/app.php';

$bootstrap = new \Toolkit\Libraries\Foundation\Lumen\Bootstrap($app);

$bootstrap->handle();
