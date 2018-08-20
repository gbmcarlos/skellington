@if(session()->has('notifications') && !empty(session()->get('notifications')))
    <div class="alert alert-success">
        <ul>
            @for ($i = 0; $i < count(session()->get('notifications')); $i++)
                <li>{{ session()->get('notifications')[$i] }}</li>
            @endfor
        </ul>
    </div>
@endif
@if(session()->has('warnings') && !empty(session()->get('warnings')))
    <div class="alert alert-warning">
        <ul>
            @for ($i = 0; $i < count(session()->get('warnings')); $i++)
                <li>{{ session()->get('warnings')[$i] }}</li>
            @endfor
        </ul>
    </div>
@endif
@if(session()->has('errors') && !empty(session()->get('errors')))
    <div class="alert alert-warning">
        <ul>
            @for ($i = 0; $i < count(session()->get('errors')); $i++)
                <li>{{ session()->get('errors')[$i] }}</li>
            @endfor
        </ul>
    </div>
@endif