/*
 * This program is part of the OpenCms Apollo Template.
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Simple parallax effects. 
 */
(function( $ ){
    var $window = $(window);
    var windowHeight = $window.height();

    $window.resize(function () {
        windowHeight = $window.height();
    });

    $.fn.initParallaxBackground = function() {
        var $this = $(this);

        // initialize parallax sections with values from data attributes    
        $this.each(function(){

            var $element = $(this); 
            var effectType = 1;

            // the following data attribute can to be attached to the div
            // <div class="parallax-background" data-prallax='{"effect":1}' >
            if (typeof $element.data("parallax") != 'undefined') {
                if (typeof $element.data("parallax").effect != 'undefined') {
                    effectType = $element.data("parallax").effect;
                }
            }
            $element.data("parallax", { effect: effectType } );

            firstTop = $this.offset().top;
        });

        // function to be called whenever the window is scrolled or resized
        function update(){
            var scrollTop = $window.scrollTop();

            $this.each(function(){
                var $element = $(this);

                var backgroundImage = $element.css("background-image");
                if (backgroundImage == 'none') {
                    return;
                }

                var offset = 0;

                // only apply effect on screen size lager then "sm", i.e. "md" and "lg"
                if ($window.width() > 991) {

                        var elementTop = $element.offset().top;
                        var elementHeight = $element.outerHeight(true);
                        var elementBottom = elementTop + elementHeight;
                        var elementScrollTop = elementTop - scrollTop;
                        var elementScrollBottom = elementBottom - scrollTop;

                        var effectType = $element.data("parallax").effect;

                        // Check if element is to small for parallax effect
                        if (elementHeight <= 1) {
                            return;
                        }

                        // Check if element is visible, if not just return
                        if (elementScrollBottom < 0 || elementScrollTop > windowHeight) {
                            return;
                        }

                        // console.info("elementTop: " + elementTop + " elementBottom: " + elementBottom);
                        // console.info("elementScrollTop: " + elementScrollTop + " elementScrollBottom: " + elementScrollBottom);

                        if (effectType == 1) {
                            // This effect assumes there is a full size background image.
                            // The background is slightly shifted up while the bottom of the
                            // element is not in view.
                            // Once the bottom is in view, the shift effect stops.

                            elementBottomOffset = elementScrollBottom - windowHeight;

                            if (elementBottomOffset > 0) {
                                // The bottom is not in view

                                if (elementHeight > windowHeight) {
                                    // Reduce initial background shift if the window is smaller then the element
                                    elementBottomOffset += elementHeight - windowHeight;
                                }

                                offset = Math.round(Math.abs(elementBottomOffset) * 0.5);
                            }
                        } else if (effectType == 2) {
                            // Initially developed for the blog visual.
                            // This effect assumes there is a full size background image 
                            // near the screen top (directly under the main navigation).
                            // The image should have standard 'photo' 4:3 or 3:2 format.
                            // Initially only the upper part of the image is seen (about 400px).
                            // When scolling, the image starts shiftig up faster then the scroll
                            // and reveals the lower part originally hidden.

                            if (elementScrollTop < 0) {
                                 offset = Math.round(elementScrollTop * 2);
                            }
                        }
                }
                $element.css('background-position', "50% " + offset + "px");
            });
        }

        $window.bind('scroll', update).resize(update);
        update();
    };
})(jQuery);