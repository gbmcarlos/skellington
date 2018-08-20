(function ($) {
    jQuery(document).ready(function () {
        window.File = {

            $: $,

            fileToBase64: function(file, callback) {

                var reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = function(){
                    callback(reader.result);
                };

            }

        };
    });
})(jQuery);