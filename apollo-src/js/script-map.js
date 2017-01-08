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

function showMapMarkers(mapId, group) {

    console.info("showMapMarkers() called with map id: " + mapId);
    var map = apollo.getData(mapId);
    var markers = map.markers;
    hideAllMapInfo(mapId);
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
    var map = apollo.getData(mapId);
    var infoWindows = map.infoWindows;
    for (var i = 0; i < infoWindows.length; i++) {
        if (i != infoId) {
            infoWindows[i].close();
        } else {
            infoWindows[i].open(
                map, 
                infoWindows[i].marker
            );
        }
    }
}

function hideAllMapInfo(mapId) {

    console.info("hideAllMapInfo() called with map id: " + mapId);
    var map = apollo.getData(mapId);
    var infoWindows = map.infoWindows;
    for (var i = 0; i < infoWindows.length; i++) {
        infoWindows[i].close();
    }
}

function loadGoogleMapApi() {

    var locale = apollo.getInfo("locale");
    var mapKey = ""
    if (apollo.hasInfo("googleMapKey")) {
        mapKey = "&key=" + apollo.getInfo("googleMapKey");
    }
    console.info("googleMapKey: " + mapKey);
    jQuery.loadScript("https://maps.google.com/maps/api/js?callback=initGoogleMaps&language=" + locale + mapKey);
}

function initGoogleMaps() {

    console.info("initGoogleMaps() called!");
    var maps = apollo.getElements("map");
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

        if (typeof mapData.markers != "undefined") {
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
        apollo.addData(mapId, {
            'map': map,
            'markers': markers,
            'infoWindows': infoWindows
        });
    }
}

(function( $ ){

    $.fn.initMaps = function() {
        var $this = $(this);

        // initialize map sections with values from data attributes    
        $this.each(function(){

            var $element = $(this); 
            var $mapElement = $element.find('.mapwindow');

            if (typeof $mapElement.data("map") != 'undefined') {
                var $mapData = $mapElement.data("map");
                // console.info("mapData found:" + $mapData);
                apollo.addElement("map", $mapData);
            }
        });

        // load the Google map API
        loadGoogleMapApi();
    };
})(jQuery);