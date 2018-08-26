<html lang="{{ app()->getLocale() }}">
@include('layout/meta_header')
<body>
        <div class="container">
            @yield('content')
            @include('layout/footer')
        </div>
        @include('layout/config')
        @include('layout/scripts')
</body>
</html>