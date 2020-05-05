let mix = require('laravel-mix');

mix.webpackConfig({
    output: {
        path: '/var/task/src/public'
    }
});

const NODE_MODULES_PATH = '/var/task/node_modules';
const SRC_PATH = '/var/task/src';

mix.js(SRC_PATH + '/resources/js/app.js', 'js/app.js');
