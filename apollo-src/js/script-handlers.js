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
var ApolloHandlers = function(jQ) {

    // Elements in head navigation
    function handleHeadNavigation() {

        // The search button
        jQ('.head .navbar-nav .search').click(function() {

            if (jQ('.search-btn').hasClass('fa-search')) {
                jQ('.search-open').fadeIn(500);
                jQ('.search-btn').removeClass('fa-search');
                jQ('.search-btn').addClass('fa-times');
            } else {
                jQ('.search-open').fadeOut(500);
                jQ('.search-btn').addClass('fa-search');
                jQ('.search-btn').removeClass('fa-times');
            }
        });

        // Hover Selector used for language switch
        jQ('.hoverSelector').on('mouseenter mouseleave', function(e) {

            jQ('.hoverSelectorBlock', this).toggleClass('show');
            e.stopPropagation();
        });

        // Responsive navbar toggle button
        jQ('.head .navbar-toggle').click(function() {

            jQ('.head .navbar-toggle').toggleClass('active');
            if (jQ('.head .navbar-toggle .fa').hasClass('fa-bars')) {
                jQ('.head .navbar-toggle .fa').removeClass('fa-bars');
                jQ('.head .navbar-toggle .fa').addClass('fa-times');
            } else {
                jQ('.head .navbar-toggle .fa').removeClass('fa-times');
                jQ('.head .navbar-toggle .fa').addClass('fa-bars');
            }
        });
    }

    // Smooth scrolling to anchor links
    function handleSmoothScrolling() {

        jQ('a[href*="#"]:not([href="#"]):not([data-toggle]):not([data-slide])')
            .click(function() {

                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                    var target = jQ(this.hash);
                    target = target.length ? target : jQ('[name=' + this.hash.slice(1) + ']');
                    if (target.length) {
                        jQ('html, body').animate({
                            scrollTop : target.offset().top
                        }, 1000);
                        return false;
                    }
                }
            });
    }


    // Clickme-Showme effect sections
    function handleClickmeShowme() {

        var $clickSections = jQ('.clickme-showme');
        if (DEBUG) console.info("clickme-showme elements found: " + $clickSections.length);
        $clickSections.each(function() {

            var $element = jQ(this);
            var $clickme = $element.find('> .clickme');
            var $showme  = $element.find('> .showme');

            if (DEBUG) console.info("initClickmeShowme called for " + $clickme.getFullPath());

            $clickme.click(function() {
                $clickme.slideUp();
                $showme.slideDown();
            });

            $showme.click(function() {
                $showme.slideUp();
                $clickme.slideDown();
            });
        });
    }


    function init() {

        if (DEBUG) console.info("ApolloHandlers.init()");

        handleHeadNavigation();
        handleSmoothScrolling();
        handleClickmeShowme();
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);

