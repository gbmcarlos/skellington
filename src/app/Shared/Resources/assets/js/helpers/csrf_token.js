(function ($) {
    jQuery(document).ready(function () {
        window.CSRFTokenHelper = {

            $: $,

            getCSRFToken: function() {
                return this.$('meta[name="csrf-token"]').attr('content');
            }

        };
    });
})(jQuery);