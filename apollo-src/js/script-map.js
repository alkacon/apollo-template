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

var __mapData = [];
var __googleMaps = [];

function addMapData(mapData) {
    __mapData.push(mapData);
}

function getMapData() {
    return __mapData; 
}

function addMap(mapId, map) {
    __googleMaps[mapId] = map;
}

function getMap(mapId) {
    return __googleMaps[mapId]; 
}

function showMapMarkers(mapId, group) {
    console.info("showMapMarkers() called with map id: " + mapId);
    var markers = getMap(mapId).markers;
    for (var i = 0; i < markers.length; i++) {
        if (markers[i].group == group || group == 'showall') {
            markers[i].setVisible(true);
        } else {
            markers[i].setVisible(false);
        }
    }
}

function showMapInfo(mapId, infoId) {
    console.info("showMapInfo() called with map id: " + mapId + " info id: " + infoId);
    var infoWindows = getMap(mapId).infoWindows;
    console.info("showMapInfo() infoWindows.length: " + infoWindows.length);
    for (var i = 0; i < infoWindows.length; i++) {
        if (i != infoId) {
            infoWindows[i].close();
        } else {
            infoWindows[i].open(
                getMap(mapId), 
                infoWindows[i].marker
            );
        }
    }
}

function loadGoogleMapApi() {
    var mapKey = ""; // TODO: Grab the key from the #google-map-key div
    var locale = "en"; // TODO: Grab the locale of the page

    jQuery.loadScript("https://maps.google.com/maps/api/js?callback=initGoogleMaps&language=" + locale);
}

function initGoogleMaps() {

    console.info("initGoogleMaps() called!");
    var maps = getMapData();
    for (var i=0; i < maps.length; i++) {
        var mapData = maps[i];

        var mapId = mapData.id;

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

        // create the map
        var map = new google.maps.Map(document.getElementById(mapId), mapOptions);

        // enable mouse wheel scrolling after click
        google.maps.event.addListener(map, 'click', function(event){
            this.setOptions({scrollwheel:true});
        });

        // map markers and info windows
        var markers = [];
        var infoWindows = [];

        if (mapData.markers != "undefined") {
            for (var p=0; p < mapData.markers.length; p++) {

                var point = mapData.markers[p];

                // get marker data from calling object
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(point.lat, point.lng),
                    map: map,
                    title: decodeURIComponent(point.title),
                    group: decodeURIComponent(point.group),
                    info: decodeURIComponent(point.info),
                    index: p,
                    mapId: mapId
                });

                // add marker to marker map
                markers.push(marker);

                // initialize info window
                var infoWindow = new google.maps.InfoWindow({
                    content: marker.info,
                    marker: marker,
                    index: p
                });

                // add marker to marker map
                infoWindows.push(infoWindow);

                console.info("attaching Event lister: " + p + " to map id " + mapId);

                // attach event listener that shows info window to marker
                // see http://you.arenot.me/2010/06/29/google-maps-api-v3-0-multiple-markers-multiple-infowindows/
                marker.addListener('click', function() {
                    showMapInfo(this.mapId, this.index);
                });
            }
        }

        // store map in global array, required e.g. to select marker categories etc.
        addMap(mapId, {
            'map': map,
            'markers': markers,
            'infoWindows': infoWindows
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
                addMapData($mapData);
            }
        });

        // load the Google map API
        loadGoogleMapApi();
    };
})(jQuery);