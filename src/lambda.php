<?php

require '/opt/vendor/autoload.php';

$app = require '/var/task/src/bootstrap/app.php';

$app->boot();

return function(array $payload, array $context, ?string $method) use ($app) {

    $functionClass = \Illuminate\Support\Facades\Config::get('app.functions')[$method] ?? null;

    if (is_null($functionClass)) {
        throw new \Exception("Couldn't find a Function class indexed as '$method' in app.function");
    }

    $function = app($functionClass);

    return $function->run($payload);

};
