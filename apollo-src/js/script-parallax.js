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

                        // Check if element is to small for parallax effect
                        if (elementHeight <= 1) {
                            return;
                        }

                        // Check if element is visible, if not just return
                        if (elementTop + elementHeight < scrollTop || elementTop > scrollTop + windowHeight) {
                            return;
                        }

                        // This effect assumes there is a full size background image
                        // The background is slightly shifted while the element is not in full view
                        // Once the element is in full view, the shift effect stops 
                        var elementBottom = (scrollTop + windowHeight) - (elementTop + elementHeight);

                        if (elementHeight > windowHeight) {
                            // Reduce initial background shift if the window is smaller then the element
                            elementBottom += elementHeight - windowHeight;
                        }

                        // Calculate the offset based on the element bottom
                        if (elementBottom < 0) {
                            offset = Math.round(Math.abs(elementBottom) * 0.5);
                        }
                }
                $element.css('background-position', "50% " + offset + "px");
            });
        }

        $window.bind('scroll', update).resize(update);
        update();
    };
})(jQuery);