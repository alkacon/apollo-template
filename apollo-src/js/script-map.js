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

var __maps = [];

function addMap(mapData) {
    __maps.push(mapData);
}

function getMaps() {
    return __maps; 
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

    $.fn.initMap = function() {
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

    };
})(jQuery);