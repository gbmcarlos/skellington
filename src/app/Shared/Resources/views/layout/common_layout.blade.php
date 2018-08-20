<html lang="{{ app()->getLocale() }}">
@include('layout/header')
<body>
        <div class="container-scroller">
            @yield('content')
            @include('layout/footer')
        </div>
        @include('layout/scripts')
</body>
</html>