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

var App = function() {

    // Header Mega Menu
    function handleMegaMenu() {

        jQuery(document).on('click', '.mega-menu .dropdown-menu', function(e) {

            e.stopPropagation();
        });
        initMegamenu();
    }

    // Search Box in Header
    function handleSearch() {

        jQuery('.navbar-nav .search').click(function() {

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
    }

    // Sidebar Navigation "active" Toggle
    function handleToggle() {

        jQuery('.list-toggle').on('click', function(e) {

            jQuery(this).toggleClass('active');
        });
    }

    // Hover Selector
    function handleHoverSelector() {

        jQuery('.hoverSelector').on('hover', function(e) {

            jQuery('.hoverSelectorBlock', this).toggleClass('show');
            e.stopPropagation();
        });
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

    // Bootstrap Tooltips and Popovers
    function handleBootstrap() {

        // Bootstrap Carousel
        jQuery('.carousel').carousel({
            interval : 15000,
            pause : 'hover'
        });

        // Tooltips
        jQuery('.tooltips').tooltip();
        jQuery('.tooltips-show').tooltip('show');
        jQuery('.tooltips-hide').tooltip('hide');
        jQuery('.tooltips-toggle').tooltip('toggle');
        jQuery('.tooltips-destroy').tooltip('destroy');

        // Popovers
        jQuery('.popovers').popover();
        jQuery('.popovers-show').popover('show');
        jQuery('.popovers-hide').popover('hide');
        jQuery('.popovers-toggle').popover('toggle');
        jQuery('.popovers-destroy').popover('destroy');
    }

    // Apollo parallax sections
    function handleParallax() {

        var parallaxSections = jQuery('.parallax-background');
        // console.info("parallaxSections found: " + parallaxSections.length);
        if ((parallaxSections.length > 0) && !Modernizr.touch) {
            parallaxSections.initParallax();
        }
    }

    // Apollo Map sections
    function handleMaps() {

        var mapElements = jQuery('.ap-map');
        // console.info("mapElements found: " + mapElements.length);
        if (mapElements.length > 0) {
            mapElements.initMaps();
        }
    }

    // Apollo sliders
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

            handleBootstrap();
            handleSearch();
            handleToggle();
            handleMegaMenu();
            handleHoverSelector();
            handleSmoothScrolling();
            handleParallax();
            handleMaps();
            handleSliders();

            initLists();
            initPhotoSwipe();
        }
    };

}();