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
var ApolloSliders = function(jQ) {

    /**
     * Simple sliders
     */
    function initSimpleSliders($sliders) {

        $sliders.each(function(){

            var $slider = jQ(this);
            var sliderId = $slider.data("sid");
            if (!$slider.data("init")) {
                jQ('#ap-slider-' + sliderId).revolution({
                    delay : $slider.data("delay"),
                    startheight : $slider.data("height"),
                    navigationType : $slider.data("navtype"),
                    navigationArrows : $slider.data("navbutton"),
                    navigationStyle : "round", // round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom
                    navigationHAlign : "right", // Vertical Align top,center,bottom
                    navigationVAlign : "bottom", // Horizontal Align left,center,right
                    navigationHOffset : 20,
                    navigationVOffset : 20,
                    soloArrowLeftHalign : "left",
                    soloArrowLeftValign : "center",
                    soloArrowLeftHOffset : 20,
                    soloArrowLeftVOffset : 0,
                    soloArrowRightHalign : "right",
                    soloArrowRightValign : "center",
                    soloArrowRightHOffset : 20,
                    soloArrowRightVOffset : 0,
                    touchenabled : "on", // Enable Swipe Function : on/off
                    onHoverStop : "off", // Stop Banner Timet at Hover on Slide on/off
                    stopAtSlide : -1,
                    stopAfterLoops : -1,
                    fullWidth : "off" // Turns On or Off the Fullwidth Image Centering in FullWidth Modus
                });

                // When stop button is clicked...
                jQ('#stopButton-' + +sliderId).on('click', function(e) {

                    jQ('#ap-slider-' + sliderId).revpause();
                    jQ('#ap-slider-' + sliderId + ' .control button').toggle();
                    jQ(this).hide();
                    jQ('#resumeButton-' + +sliderId).show();
                });

                // When resume button is clicked...
                jQ('#resumeButton-' + sliderId).on('click', function(e) {

                    jQ('#ap-slider-' + sliderId).revresume();
                    jQ(this).hide();
                    jQ('#stopButton-' + sliderId).show();
                });
                jQ('#ap-slider-' + sliderId).find('li').show();
            }
            $slider.data("init", "true");
        });
    }

    /**
     * Complex sliders
     */
    function initComplexSliders($sliders) {

        $sliders.each(function(){
            var $slider = jQ(this);
            var sliderId = $slider.data("sid");
            if (!$slider.data("init")) {
                jQ('#ap-slider-' + sliderId).revolution({

                    delay : $slider.data("delay"),
                    startheight : $slider.data("height"),
                    startwidth : $slider.data("width"),

                    hideThumbs : 10,

                    thumbWidth : 100, // Thumb With and Height and Amount (only if navigation Tyope set to thumb!)
                    thumbHeight : 50,
                    thumbAmount : 5,

                    navigationType : "bullet", // bullet, thumb, none
                    navigationArrows : "solo", // nexttobullets, solo (old name verticalcentered), none

                    navigationStyle : "round", // round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom

                    navigationHAlign : "center", // Vertical Align top,center,bottom
                    navigationVAlign : "bottom", // Horizontal Align left,center,right
                    navigationHOffset : 0,
                    navigationVOffset : 20,

                    soloArrowLeftHalign : "left",
                    soloArrowLeftValign : "center",
                    soloArrowLeftHOffset : 20,
                    soloArrowLeftVOffset : 0,

                    soloArrowRightHalign : "right",
                    soloArrowRightValign : "center",
                    soloArrowRightHOffset : 20,
                    soloArrowRightVOffset : 0,

                    touchenabled : "on", // Enable Swipe Function : on/off
                    onHoverStop : "off", // Stop Banner Timet at Hover on Slide on/off

                    stopAtSlide : -1,
                    stopAfterLoops : -1,

                    shadow : 1, // 1 = no Shadow, 1,2,3 = 3 Different Types of Shadows  (No Shadow in Fullwidth Version !)
                    fullWidth : "on" // Turns On or Off the Fullwidth Image Centering in FullWidth Modus
                });

                jQ('#ap-slider-' + sliderId).find('li').show();
            }
            $slider.data("init", "true");
        });
    }

    function init() {

        if (DEBUG) console.info("ApolloSliders.init()");

        var $simpleSliders = jQuery('.ap-slider');
        if (DEBUG) console.info(".ap-slider elements found: " + $simpleSliders.length);
        if ($simpleSliders.length > 0) {
            initSimpleSliders($simpleSliders);
        }

        var $complexSliders = jQuery('.ap-complex-slider');
        if (DEBUG) console.info(".ap-complex-slider elements found: " + $complexSliders.length);
        if ($complexSliders.length > 0) {
            initComplexSliders($complexSliders);
        }
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);
