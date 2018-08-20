<html lang="{{ app()->getLocale() }}">
@include('layout/header')
<body>
        <div class="container-scroller">
            @include('layout/navigation')
            @yield('content')
            @include('layout/footer')
        </div>
        @include('layout/config')
        @include('layout/scripts')
        @yield('additional-scripts')
</body>
</html>