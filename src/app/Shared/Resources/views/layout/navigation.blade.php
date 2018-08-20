<nav class="navbar horizontal-layout col-lg-12 col-12 p-0">
    <div class="container d-flex flex-row">
        <div class="text-center navbar-brand-wrapper d-flex align-items-center">
            <a class="navbar-brand brand-logo" href="index.html"><img src="/images/logo.png" alt="logo"/></a>
            <a class="navbar-brand brand-logo-mini" href="index.html"><img src="/images/logo-mini.png" alt="logo"/></a>
        </div>
        <div class="navbar-menu-wrapper d-flex align-items-center">
            <form class="search-field ml-auto" action="#">
                <div class="form-group mb-0">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            {{--  <span class="input-group-text"><i class="mdi mdi-magnify"></i></span>  --}}
                        </div>
                        {{--  <input type="text" class="form-control">  --}}
                    </div>
                </div>
            </form>
            <ul class="navbar-nav navbar-nav-right mr-0">
                <li class="nav-item dropdown d-none d-xl-inline-block">
                    <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
                        <img class="img-xs rounded-circle" src="https://placehold.it/100x100" alt="Profile image">
                    </a>
                    <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                        <a class="dropdown-item p-0">
                            <div class="d-flex border-bottom">
                                <div class="py-3 px-4 d-flex align-items-center justify-content-center">
                                    <i class="mdi mdi-bookmark-plus-outline mr-0 text-gray"></i></div>
                                <div class="py-3 px-4 d-flex align-items-center justify-content-center border-left border-right">
                                    <i class="mdi mdi-account-outline mr-0 text-gray"></i></div>
                                <div class="py-3 px-4 d-flex align-items-center justify-content-center">
                                    <i class="mdi mdi-alarm-check mr-0 text-gray"></i></div>
                            </div>
                        </a>
                        @if (Auth::user()->hasRoles(['admin']))
                            <a class="dropdown-item mt-2" href="{{ route('users') }}">
                                Manage Accounts
                            </a>
                        @endif
                        <a class="dropdown-item" href="{{ route('change_password') }}">
                            Change Password
                        </a>
                        <a class="dropdown-item">
                            Check Inbox
                        </a>
                        <a class="dropdown-item" href="{{ route('logout.redirect') }}">
                            Sign Out
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div class="nav-bottom">
        <div class="container">
            <ul class="nav page-navigation">
                {{--  <li class="nav-item">
                    <a href="index.html" class="nav-link"><i class="link-icon mdi mdi-television"></i><span class="menu-title">DASHBOARD</span></a>
                </li>  --}}
                <li class="nav-item mega-menu">
                    <a href="javascript:void(0)" class="nav-link text-uppercase"><i class="link-icon mdi mdi-account-circle"></i><span class="menu-title">Accounts<i class="menu-arrow"></i></span></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Customers</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="{{ route('accounts') }}">View
                                                    All Accounts</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Registrations</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item">
                                                <a class="nav-link" href="{{ route('registrations.page') }}">New
                                                    Registrations</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">ekar Wallet</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item">
                                                <a class="nav-link" href="pages/ui-features/dragula.html">Manage
                                                    Wallet</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="javascript:void(0);" class="nav-link text-uppercase"><i class="link-icon mdi mdi-book-open-page-variant"></i><span class="menu-title">Operations<i class="menu-arrow"></i></span></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Activity</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="/ops/activity">Activity
                                                    Feed</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Reservations</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="/ops/reservations-board">Reservation
                                                    Board</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Reservation Map</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Ticketing System</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="/ops/create-ticket">Create A
                                                    Ticket</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="javascript:void(0);" class="nav-link text-uppercase"><i class="link-icon mdi mdi-car"></i><span class="menu-title">Fleet<i class="menu-arrow"></i></span></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Vehicles</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="#">View All Vehicles</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Location Configuration</a>
                                            </li>
                                            <li class="nav-item"><a class="nav-link" href="#">City Configuration</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="javascript:void(0);" class="nav-link text-uppercase"><i class="link-icon mdi mdi-file-chart"></i><span class="menu-title">Reporting<i class="menu-arrow"></i></span></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Metrics</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="#">Daily Stats</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Weekly Stats</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Monthly Stats</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Usages</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="#">Dialy Stats</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Fines Report</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Salik Report</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Billing</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="{{route('payment_lists')}}">Invoice</a>
                                            </li>
                                            <li class="nav-item"><a class="nav-link" href="#">Fines Report</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Salik Report</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="#" class="nav-link text-uppercase"><i class="link-icon mdi mdi-account-circle"></i><span class="menu-title">Manage<i class="menu-arrow"></i></span></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">CMS</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="#">App Management</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#">Website Management</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Push Notifications</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item">
                                                <a class="nav-link" href="pages/ui-features/dragula.html">Manage
                                                    Notifications</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col-group col-md-4">
                                <div class="row">
                                    <div class="col-12">
                                        <p class="category-heading">Incentives System</p>
                                    </div>
                                    <div class="col-md-6">
                                        <ul class="submenu-item">
                                            <li class="nav-item"><a class="nav-link" href="{{ route('charges') }}">Manage
                                                    Charges</a></li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="pages/ui-features/dragula.html">Manage Promo
                                                    Codes</a></li>
                                            <li class="nav-item">
                                                <a class="nav-link" href="pages/ui-features/dragula.html">Manage ekar
                                                    Wallet</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                {{--  <li class="nav-item mega-menu">
                    <a href="#" class="nav-link"><i class="link-icon mdi mdi-flag-outline"></i><span class="menu-title">PAGES</span><i class="menu-arrow"></i></a>
                    <div class="submenu">
                        <div class="col-group-wrapper row">
                           <div class="col-group col-md-4">
                              <div class="row">
                                 <div class="col-12">
                                    <p class="category-heading">Basic Elements</p>
                                 </div>
                                 <div class="col-md-6">
                                    <ul class="submenu-item">
                                       <li class="nav-item"><a class="nav-link" href="#">Accordion</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/buttons.html">Buttons</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/badges.html">Badges</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/breadcrumbs.html">Breadcrumbs</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/dropdowns.html">Dropdown</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/modals.html">Modals</a></li>
                                    </ul>
                                 </div>
                                 <div class="col-md-6">
                                    <ul class="submenu-item">
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/progress.html">Progress bar</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/pagination.html">Pagination</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/tabs.html">Tabs</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/typography.html">Typography</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/tooltips.html">Tooltip</a></li>
                                    </ul>
                                 </div>
                              </div>
                           </div>
                           <div class="col-group col-md-4">
                              <div class="row">
                                 <div class="col-12">
                                    <p class="category-heading">Advanced Elements</p>
                                 </div>
                                 <div class="col-md-6">
                                    <ul class="submenu-item">
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/dragula.html">Dragula</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/carousel.html">Carousel</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/clipboard.html">Clipboard</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/context-menu.html">Context Menu</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/loaders.html">Loader</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/slider.html">Slider</a></li>
                                    </ul>
                                 </div>
                                 <div class="col-md-6">
                                    <ul class="submenu-item">
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/tour.html">Tour</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/popups.html">Popup</a></li>
                                       <li class="nav-item"><a class="nav-link" href="pages/ui-features/notifications.html">Notification</a></li>
                                    </ul>
                                 </div>
                              </div>
                           </div>
                           <div class="col-group col-md-2">
                              <p class="category-heading">Table</p>
                              <ul class="submenu-item">
                                 <li class="nav-item"><a class="nav-link" href="pages/tables/basic-table.html">Basic Table</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/tables/data-table.html">Data Table</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/tables/js-grid.html">Js-grid</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/tables/sortable-table.html">Sortable Table</a></li>
                              </ul>
                           </div>
                           <div class="col-group col-md-2">
                              <p class="category-heading">Icons</p>
                              <ul class="submenu-item">
                                 <li class="nav-item"><a class="nav-link" href="pages/icons/flag-icons.html">Flag Icons</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/icons/font-awesome.html">Font Awesome</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/icons/simple-line-icon.html">Simple Line Icons</a></li>
                                 <li class="nav-item"><a class="nav-link" href="pages/icons/themify.html">Themify Icons</a></li>
                              </ul>
                           </div>
                        </div>
                     </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="#" class="nav-link"><i class="link-icon mdi mdi-flag-outline"></i><span class="menu-title">PAGES</span><i class="menu-arrow"></i></a>
                    <div class="submenu">
                    <div class="col-group-wrapper row">
                        <div class="col-group col-md-3">
                        <p class="category-heading">User Pages</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/samples/login.html">Login</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/login-2.html">Login 2</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/register.html">Register</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/register-2.html">Register 2</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/lock-screen.html">Lockscreen</a></li>
                        </ul>
                        </div>
                        <div class="col-group col-md-3">
                        <p class="category-heading">Error Pages</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/samples/error-400.html">400</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/error-404.html">404</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/error-500.html">500</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/error-505.html">505</a></li>
                        </ul>
                        </div>
                        <div class="col-group col-md-3">
                        <p class="category-heading">E-commerce</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/samples/invoice.html">Invoice</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/pricing-table.html">Pricing Table</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/samples/orders.html">Orders</a></li>
                        </ul>
                        </div>
                        <div class="col-group col-md-3">
                        <p class="category-heading">Documentation</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/documentation.html">Documentation</a></li>
                        </ul>
                        </div>
                    </div>
                    </div>
                </li>
                <li class="nav-item mega-menu">
                    <a href="#" class="nav-link"><i class="link-icon mdi mdi-android-studio"></i><span class="menu-title">FORMS</span><i class="menu-arrow"></i></a>
                    <div class="submenu">
                    <div class="col-group-wrapper row">
                        <div class="col-group col-md-3">
                        <p class="category-heading">Basic Elements</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/forms/basic_elements.html">Basic Elements</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/forms/advanced_elements.html">Advanced Elements</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/forms/validation.html">Validation</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/forms/wizard.html">Wizard</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/forms/text_editor.html">Text Editor</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/forms/code_editor.html">Code Editor</a></li>
                        </ul>
                        </div>
                        <div class="col-group col-md-3">
                        <p class="category-heading">Charts</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/charts/chartjs.html">Chart Js</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/morris.html">Morris</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/flot-chart.html">Flaot</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/google-charts.html">Google Chart</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/sparkline.html">Sparkline</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/c3.html">C3 Chart</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/chartist.html">Chartist</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/charts/justGage.html">JustGage</a></li>
                        </ul>
                        </div>
                        <div class="col-group col-md-3">
                        <p class="category-heading">Maps</p>
                        <ul class="submenu-item">
                            <li class="nav-item"><a class="nav-link" href="pages/maps/mapeal.html">Mapeal</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/maps/vector-map.html">Vector Map</a></li>
                            <li class="nav-item"><a class="nav-link" href="pages/maps/google-maps.html">Google Map</a></li>
                        </ul>
                        </div>
                    </div>
                    </div>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link"><i class="link-icon mdi mdi-asterisk"></i><span class="menu-title">APPS</span><i class="menu-arrow"></i></a>
                    <div class="submenu">
                    <ul class="submenu-item">
                        <li class="nav-item"><a class="nav-link" href="pages/apps/email.html">Email</a></li>
                        <li class="nav-item"><a class="nav-link" href="pages/apps/calendar.html">Calendar</a></li>
                        <li class="nav-item"><a class="nav-link" href="pages/apps/todo.html">Todo List</a></li>
                        <li class="nav-item"><a class="nav-link" href="pages/apps/gallery.html">Gallery</a></li>
                    </ul>
                    </div>
                </li>  --}}
            </ul>
        </div>
    </div>
</nav>