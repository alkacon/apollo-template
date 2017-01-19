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

// Module implemented using the "revealing module pattern", see
// https://addyosmani.com/resources/essentialjsdesignpatterns/book/#revealingmodulepatternjavascript
// https://www.christianheilmann.com/2007/08/22/again-with-the-module-pattern-reveal-something-to-the-world/
var ApolloParallax = function(jQ) {

    // Note: If DEBUG is false, all if clauses using it will be removed
    // by uglify.js during Apollo JS processing as unreachable code
    this.DEBUG = false;

    this.m_$parallaxElements;
    this.m_$window = jQ(window);
    this.windowHeight = m_$window.height();

    m_$window.resize(function() {
        windowHeight = m_$window.height();
    });

    // function to be called whenever the window is scrolled or resized
    function update(){
        var scrollTop = m_$window.scrollTop();

        m_$parallaxElements.each(function(){
            var $element = jQ(this);

            var backgroundImage = $element.css("background-image");
            if (backgroundImage == 'none') {
                return;
            }

            var offset = 0;

            // only apply effect on screen size lager then "sm", i.e. "md" and "lg"
            if (m_$window.width() > 991) {

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

                if (DEBUG) console.info("elementTop: " + elementTop + " elementBottom: " + elementBottom);
                if (DEBUG) console.info("elementScrollTop: " + elementScrollTop + " elementScrollBottom: " + elementScrollBottom);

                if (effectType == 1) {
                    // This effect assumes there is a full size background image.
                    // The background is slightly shifted up while the bottom of the
                    // element is not in view.
                    // Once the bottom is in view, the shift effect stops.

                    if (elementHeight <= windowHeight) {
                        elementBottomOffset = elementScrollBottom - windowHeight;
                    } else {
                        elementBottomOffset = elementScrollTop;
                    }

                    if (elementBottomOffset > 0) {
                        // The bottom is not in view
                        offset = Math.round(Math.abs(elementBottomOffset) * 0.5);

                        if (DEBUG) console.info(
                            "elementHeight: " +  elementHeight +
                            " windowHeight: " + windowHeight +
                            " offset: " + offset +
                            " elementScrollTop: " + elementScrollTop);

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


    function initParallax() {

        // initialize parallax sections with values from data attributes
        m_$parallaxElements.each(function(){

            var $element = jQ(this);
            var effectType = 1;

            // the following data attribute can to be attached to the div
            // <div class="parallax-background" data-prallax='{"effect":1}' >
            if (typeof $element.data("parallax") != 'undefined') {
                if (typeof $element.data("parallax").effect != 'undefined') {
                    effectType = $element.data("parallax").effect;
                }
            }
            $element.data("parallax", { effect: effectType } );
        });
    }

    function init() {

        m_$parallaxElements = jQuery('.parallax-background');
        if (DEBUG) console.info(".parallax-background elements found: " + m_$parallaxElements.length);

        if ((m_$parallaxElements.length > 0) && !Modernizr.touch) {
            initParallax();

            m_$window.bind('scroll', update).resize(update);
            update();
        }
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);
