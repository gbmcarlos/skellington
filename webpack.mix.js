let mix = require('laravel-mix');

mix.webpackConfig({
    output: {
        path: '/var/task/src/public'
    }
});

const SRC_PATH = '/var/task/src';

// Scripts
mix.js(SRC_PATH + '/resources/js/app.js',  'js/app.js');

// Styles
mix.sass(SRC_PATH + '/resources/sass/app.scss', 'css/app.css');
