let mix = require('laravel-mix');

// Shared
/// Helpers
mix.scripts([
    'src/app/Shared/Resources/assets/js/helpers/csrf_token.js',
    'src/app/Shared/Resources/assets/js/helpers/url.js',
    'src/app/Shared/Resources/assets/js/helpers.js'
], 'src/public/js/helpers.js');

/// Styles
mix.sass('src/app/Shared/Resources/assets/sass/main.scss', 'src/public/css');

// Vendor
/// Global scripts
mix.scripts([
    'node_modules/jquery/dist/jquery.min.js',
    'node_modules/bootstrap/dist/js/bootstrap.min.js',
    'node_modules/underscore/underscore-min.js'
], 'src/public/js/global.js');
/// Font awesome fonts and styles
mix.copy('node_modules/font-awesome/fonts', 'src/public/fonts');
mix.styles([
    'node_modules/font-awesome/css/font-awesome.css'
], 'src/public/css/vendors.css');