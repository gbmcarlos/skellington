<?php


use Illuminate\Http\Request;
use SwooleTW\Http\Websocket\Facades\Websocket;

/*
|--------------------------------------------------------------------------
| Websocket Routes
|--------------------------------------------------------------------------
|
| Here is where you can register websocket events for your application.
|
*/

Websocket::on('connect', function ($websocket, Request $request) {

});

Websocket::on('disconnect', function ($websocket) {

});

Websocket::on('example', function ($websocket, $data) {
    $websocket->emit('message', $data);
});