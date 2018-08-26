<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="stylesheet" href="{{ asset('css/vendors.css') }}" />
    <link rel="stylesheet" href="{{ asset('css/main.css') }}" />
    <title>{{$exposed_config['site_name']}}</title>
</head>