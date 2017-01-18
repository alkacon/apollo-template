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

// Note: If APPDEBUG is false, all APPDEBUG clauses will be removed
// by uglify.js during Apollo JS processing as unreachable code
var APPDEBUG = false;

var App = function() {

    // Elements in head navigation
    function handleHeadNavigation() {

        // The search button
        jQuery('.head .navbar-nav .search').click(function() {

            if (jQuery('.search-btn').hasClass('fa-search')) {
                jQuery('.search-open').fadeIn(500);
                jQuery('.search-btn').removeClass('fa-search');
                jQuery('.search-btn').addClass('fa-times');
            } else {
                jQuery('.search-open').fadeOut(500);
                jQuery('.search-btn').addClass('fa-search');
                jQuery('.search-btn').removeClass('fa-times');
            }
        });

        // Hover Selector used for language switch
        jQuery('.hoverSelector').on('mouseenter mouseleave', function(e) {

            jQuery('.hoverSelectorBlock', this).toggleClass('show');
            e.stopPropagation();
        });

        // Responsive navbar toggle button
        jQuery('.head .navbar-toggle').click(function() {

            jQuery('.head .navbar-toggle').toggleClass('active');
            if (jQuery('.head .navbar-toggle .fa').hasClass('fa-bars')) {
                jQuery('.head .navbar-toggle .fa').removeClass('fa-bars');
                jQuery('.head .navbar-toggle .fa').addClass('fa-times');
            } else {
                jQuery('.head .navbar-toggle .fa').removeClass('fa-times');
                jQuery('.head .navbar-toggle .fa').addClass('fa-bars');
            }
        });
    }

    // Header Mega Menu
    function handleMegaMenu() {

        jQuery(document).on('click', '.mega-menu .dropdown-menu', function(e) {

            e.stopPropagation();
        });
        initMegamenu();
    }

    // Smooth scrolling to anchor links
    function handleSmoothScrolling() {

        jQuery('a[href*="#"]:not([href="#"]):not([data-toggle]):not([data-slide])')
            .click(function() {

                if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
                    var target = jQuery(this.hash);
                    target = target.length ? target : jQuery('[name=' + this.hash.slice(1) + ']');
                    if (target.length) {
                        jQuery('html, body').animate({
                            scrollTop : target.offset().top
                        }, 1000);
                        return false;
                    }
                }
            });
    }

    // Parallax sections
    function handleParallax() {

        var parallaxSections = jQuery('.parallax-background');
        if (APPDEBUG) console.info("parallax-background elements found: " + parallaxSections.length);
        if ((parallaxSections.length > 0) && !Modernizr.touch) {
            parallaxSections.initParallax();
        }
    }

    // Clickme-Showme effect sections
    function handleClickmeShowme() {

        var $clickSections = jQuery('.clickme-showme');
        if (APPDEBUG) console.info("clickme-showme elements found: " + clickSections.length);
        $clickSections.each(function() {

            var $element = $(this);
            var $clickme = $element.find('> .clickme');
            var $showme  = $element.find('> .showme');

            if (APPDEBUG) console.info("initClickmeShowme called for " + $clickme.getFullPath());

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

    // Map sections
    function handleMaps() {

        var mapElements = jQuery('.ap-google-map');
        if (APPDEBUG) console.info(".ap-google-map elements found: " + mapElements.length);
        if (mapElements.length > 0) {
            mapElements.initMap();
        }
    }

    // Slider sections
    function handleSliders() {

        var simpleSliders = jQuery('.ap-slider');
        if (simpleSliders.length > 0) {
            simpleSliders.initSimpleSlider();
        }
        var complexSliders = jQuery('.ap-complex-slider');
        if (complexSliders.length > 0) {
            complexSliders.initComplexSlider();
        }
    }

    return {
        init : function() {

            initApollo();
            initAnalytics();

            handleHeadNavigation();
            handleMegaMenu();
            handleSmoothScrolling();
            handleParallax();
            handleClickmeShowme();
            handleMaps();
            handleSliders();

            initApolloImageGalleries();
            initLists();
        }
    };

}();

