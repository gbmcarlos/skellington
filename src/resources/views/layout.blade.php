<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    @section('styles')
        <link rel="stylesheet" href="{{ asset('css/app.css') }}">
    @show
    @stack('header-scripts')
</head>

<body class="font-sans">

<main role="main" class="container">
    @yield('content')
</main>

<footer class="footer">
    <div class="container">
        @include('sections/footer')
    </div>
</footer>

@stack('body-scripts')

</body>
</html>
<!doctype html>
