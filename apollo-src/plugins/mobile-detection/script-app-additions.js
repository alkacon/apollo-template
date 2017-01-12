
    // Bad phone detection
    // Using the detectmobilebrowser.com method
    function handleDeviceDependent() {

        var deviceSections = jQuery('.device-dependent');
        if (APPDEBUG) console.info("device-dependent elements found: " + deviceSections.length);
        if (deviceSections.length > 0) {
            deviceSections.initDeviceDependent();
        }
    }

    (function( $ ){

        $.fn.initDeviceDependent = function() {
            var $this = $(this);

            $this.each(function(){

                var $element = $(this);

                if (APPDEBUG) console.info("initDeviceDependent called for " + $element.getFullPath());

                var onlyDesktop = $element.hasClass("desktop");
                var onlyMobile = $element.hasClass("mobile");
                var isMobile = jQuery.browser.mobile;

                if (APPDEBUG) console.info("initDeviceDependent mobile detected is " + isMobile);
                if (APPDEBUG) console.info("initDeviceDependent show element on desktop:" + onlyDesktop + " on mobile:" + onlyMobile);

                if (isMobile && onlyDesktop) {
                    if (APPDEBUG) console.info("initDeviceDependent hiding mobile element on desktop");
                    $element.hide();
                } else if (!isMobile && onlyMobile) {
                    if (APPDEBUG) console.info("initDeviceDependent hiding desktop element on mobile");
                    $element.hide();
                }
            });
        };
    })(jQuery);
