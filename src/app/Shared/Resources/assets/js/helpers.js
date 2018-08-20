(function ($) {
    jQuery(document).ready(function () {
        window.Helpers = {

            $: $,

            CSRFToken: CSRFTokenHelper,

            Url: UrlHelper,

            File: File

        };
    });
})(jQuery);