<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>

    <body class="font-sans">
    <div id="app" style="height: 100%; width: 100%;">
        <router-view></router-view>
    </div>
    <script src="{{ asset('js/app.js') }}"></script>
    </body>
</html>