(function ($) {
    jQuery(document).ready(function () {
        window.UrlHelper = {

            $: $,

            urlParamsRegex: new RegExp(/(:[^\/\/]+:)/g),

            getEndpoint: function(endpointName, parameters) {

                var endpointUrl = Config.endpoints[endpointName];

                if (!endpointUrl) {
                    throw "Endpoint \'" + endpointName + "\' not found";
                }

                return this.composeUrl(endpointUrl, parameters);

            },

            composeUrl: function(url, placeholders) {
                this.urlParams = placeholders;

                return url.replace(
                    this.urlParamsRegex,
                    this.paramsResolver.bind(this)
                );

            },

            paramsResolver: function(input, paramMatch) {

                var paramName = paramMatch.substr(1, paramMatch.length-2);

                return this.urlParams[paramName] || '';

            }

        };
    });
})(jQuery);