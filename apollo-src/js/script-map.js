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
 * Google map elements for Apollo.
 */

// this is taken straight from the jQuery docs:
// http://api.jquery.com/jQuery.getScript/
jQuery.loadScript = function( url, options ) {

    // Allow user to set any option except for dataType, cache, and url
    options = $.extend( options || {}, {
        dataType: "script",
        cache: true,
        url: url
    });

    // Use $.ajax() since it is more flexible than $.getScript
    // Return the jqXHR object so we can chain callbacks
    return jQuery.ajax( options );
};

var __maps = [];

function addMap(mapData) {
    __maps.push(mapData);
}

function getMaps() {
    return __maps; 
}

function loadGoogleMapApi() {
    var mapKey = ""; // TODO: Grab the key from the #google-map-key div
    var locale = "en"; // TODO: Grab the locale of the page

    jQuery.loadScript("https://maps.google.com/maps/api/js?callback=initGoogleMaps&language=" + locale);
}


function initGoogleMaps() {

    console.info("initGoogleMaps() called!");
    var maps = getMaps();
    for (var i=0; i < maps.length; i++) {
        var mapData = maps[i];

        var mapId = "map_" + mapData.id;

        console.info("Initializing map: " + mapId);

        var mapOptions = {
            zoom: parseInt(mapData.zoom),
            scrollwheel: false,
            mapTypeId: eval("google.maps.MapTypeId." + mapData.type),
            mapTypeControlOptions: {
                style: google.maps.MapTypeControlStyle.DEFAULT, 
                mapTypeIds: new Array(
                    google.maps.MapTypeId.ROADMAP, 
                    google.maps.MapTypeId.SATELLITE,
                    google.maps.MapTypeId.HYBRID
                )
            },
            center: new google.maps.LatLng(mapData.centerLat, mapData.centerLng)
        }

        var map = new google.maps.Map(document.getElementById(mapId), mapOptions);

        // enable mouse wheel scrolling after click
        google.maps.event.addListener(map, 'click', function(event){
            this.setOptions({scrollwheel:true});
        });
    }
}

(function( $ ){

    $.fn.initMaps = function() {
        var $this = $(this);

        // initialize parallax sections with values from data attributes    
        $this.each(function(){

            var $element = $(this); 
            var $mapElement = $element.find('.mapwindow');

            // the following data attribute can to be attached to the div
            // <div class="parallax-background" data-prallax='{"effect":1}' >
            if (typeof $mapElement.data("map") != 'undefined') {
                var $mapData = $mapElement.data("map");
                // console.info("mapData found:" + $mapData);
                addMap($mapData);
            }
        });

        // load the Google map API
        loadGoogleMapApi();
    };
})(jQuery);