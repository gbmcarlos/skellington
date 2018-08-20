@extends('layout.common_layout')
@section('content')
    <div class="container-scroller">
        <div class="container-fluid page-body-wrapper full-page-wrapper">
            <div class="content-wrapper auth p-0 theme-two">
                <div class="row d-flex align-items-stretch">
                    <div class="col-12 col-md-12 h-100 bg-white">

                        <div class="auto-form-wrapper d-flex align-items-center justify-content-center flex-column">
                            <img src="/images/logo.png" alt="" class="logo-login">
                            <h3 class="mr-auto">User unauthorized. Role/s '{{ $exception->getMessage() }}' not found for the current user.</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection