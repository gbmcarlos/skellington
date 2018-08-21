<html lang="{{ app()->getLocale() }}">
@include('layout/header')
<body>
        <div class="container">
            @yield('content')
            @include('layout/footer')
        </div>
        @include('layout/scripts')
</body>
</html>