<?php
/**
 * Created by PhpStorm.
 * User: gbmcarlos
 * Date: 9/26/18
 * Time: 2:34 PM
 */

namespace App\Shared\Middlewares;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Config;

class CheckLocaleMiddleware {

    const LOCALE_REGEX = '/([a-z]{2,3})[-_]([A-Z]{2,3})/';

    public function handle(Request $request, \Closure $next) {

        $defaultLocale = Config::get('app.fallback_locale');

        $requestedLocale = $this->parseLanguageHeader($request->header('Accept-Language')) ?: $defaultLocale;

        $availableLocales = array_map(function($locale){return trim($locale);}, explode(',', Config::get('app.available_locales')));

        if (in_array($requestedLocale, $availableLocales)) {
            App::setLocale($requestedLocale);
        } else {
            App::setLocale($defaultLocale);
        }

        return $next($request);

    }

    protected function parseLanguageHeader(string $header) : ?string {

        preg_match(self::LOCALE_REGEX, $header, $matches);

        if (isset($matches[1]) && isset($matches[2])) {
            return "$matches[1]_$matches[2]";
        }

        return null;

    }

}