@extends('layout')
@section('content')

    <div id="app" style="height: 100%; width: 100%;">
        <hello-world></hello-world>
    </div>

@endsection

@push('body-scripts')

    <script>

        var Config = @json([
            'debug' => env('APP_DEBUG', false)
        ]);

    </script>

    <script src="{{ asset('js/app.js') }}"></script>

@endpush