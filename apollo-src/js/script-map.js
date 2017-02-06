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
var ApolloMap = function(jQ) {

    // all initialized Google maps
    this.m_maps = {};

    // all map data sets found on the page, as array for easy iteration
    this.m_mapData = [];

    // the Google geocode object, used for resolving coordinates to address names
    this.m_googleGeocoder = null;

    function showMarkers(mapId, group) {

        if (DEBUG) console.info("showMapMarkers() called with map id: " + mapId);
        var map = m_maps[mapId];
        var markers = map.markers;
        var g = decodeURIComponent(group);
        hideAllInfo(mapId);
        for (var i = 0; i < markers.length; i++) {
            if (markers[i].group == g || g == 'showall') {
                markers[i].setVisible(true);
            } else {
                markers[i].setVisible(false);
            }
        }
    }


    function showInfo(mapId, infoId) {

        if (DEBUG) console.info("showInfo() called with map id: " + mapId + " info id: " + infoId);
        var map = m_maps[mapId];
        var infoWindows = map.infoWindows;
        for (var i = 0; i < infoWindows.length; i++) {
            if (i != infoId) {
                infoWindows[i].close();
            } else {
                if (infoWindows[i].geocode == "true") {
                    if (DEBUG) console.info("showInfo() geocode lookup for " + mapId);
                    getGeocode(infoWindows[i]);
                    infoWindows[i].geocode = "false";
                }
                infoWindows[i].open(
                    map,
                    infoWindows[i].marker
                );
            }
        }
    }


    function hideAllInfo(mapId) {

        if (DEBUG) console.info("hideAllInfo() called with map id: " + mapId);
        var map = m_maps[mapId];
        var infoWindows = map.infoWindows;
        for (var i = 0; i < infoWindows.length; i++) {
            infoWindows[i].close();
        }
    }


    function setInfo(results, status, infoWindow) {

        if (DEBUG) console.info("setInfo() geocode lookup returned status " + status);
        var addressFound = "";
        if (status == google.maps.GeocoderStatus.OK) {
            if (results[0]) {
                addressFound = formatGeocode(results[0]);
            }
        } else {
            console.warn("Google GeoCoder returned error status '" + status + "' for coordinates " + infoWindow.marker.position);
        }
        // replace content in info window
        var infoContent = infoWindow.getContent();
        infoContent = infoContent.replace(/apolloAddr/, addressFound);
        infoWindow.setContent(infoContent);
    }


    function formatGeocode(result) {
        // returns the address from a geocode result in nicely formatted way
        var street = "";
        var strNum = "";
        var zip = "";
        var city = "";
        var foundAdr = false;

        for (var i = 0; i < result.address_components.length; i++) {
            var t = String(result.address_components[i].types);
            if (street == "" && t.indexOf("route") != -1) {
                street = result.address_components[i].long_name;
                foundAdr = true;
            }
            if (t.indexOf("street_number") != -1) {
                strNum = result.address_components[i].long_name;
                foundAdr = true;
            }
            if (t.indexOf("postal_code") != -1) {
                zip = result.address_components[i].long_name;
                foundAdr = true;
            }
            if (city == "" && t.indexOf("locality") != -1) {
                city = result.address_components[i].long_name;
                foundAdr = true;
            }
        }
        if (foundAdr == true) {
            return street + " " + strNum + "<br/>" + zip + " " + city;
        } else {
            return result.formatted_address;
        }
    }


    function getGeocode(infoWindow) {

        if (m_googleGeocoder == null) {
            // initialize global geocoder object if required
            m_googleGeocoder = new google.maps.Geocoder();
        }

        m_googleGeocoder.geocode({'latLng': infoWindow.marker.position}, function(results, status) {
            setInfo(results, status, infoWindow);
        });
    }


    function loadGoogleApi() {

        var locale = Apollo.getInfo("locale");
        var mapKey = ""
        if (Apollo.hasInfo("googleMapKey")) {
            mapKey = "&key=" + Apollo.getInfo("googleMapKey");
        }
        var addLibs = "";
        if (! Apollo.isOnlineProject()) {
            // need to load places API for OpenCms map editor
            addLibs = "&libraries=places"
        }
        if (DEBUG) console.info("googleMapKey: " + (mapKey == '' ? '(undefined)' : mapKey));
        jQ.loadScript("https://maps.google.com/maps/api/js?callback=ApolloMap.initGoogleMaps&language=" + locale + addLibs + mapKey);
    }


    function getPuempel(color) {
        return {
            path: 'M0-37.06c-5.53 0-10.014 4.148-10.014 9.263 0 7.41 8.01 9.262 10.014 27.787 2.003-18.525 10.014-20.377 10.014-27.787 0-5.115-4.484-9.264-10.014-9.264zm.08 6.988a2.91 2.91 0 0 1 2.91 2.912 2.91 2.91 0 0 1-2.91 2.91 2.91 2.91 0 0 1-2.91-2.91 2.91 2.91 0 0 1 2.91-2.912z',
            scale: 1,
            fillOpacity: 1,
            fillColor: color,
            strokeColor: '#000000',
            strokeWeight: 1
        };
    }


    function initGoogleMaps() {

        if (DEBUG) console.info("initGoogleMaps() called with data for " + m_mapData.length + " maps!" );

        for (var i=0; i < m_mapData.length; i++) {
            var mapData = m_mapData[i];

            var mapId = mapData.id;

            if (DEBUG) console.info("Initializing map: " + mapId);

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
            var groups = {};
            var groupsFound = 0;

            if (typeof mapData.markers != "undefined") {
                for (var p=0; p < mapData.markers.length; p++) {

                    var point = mapData.markers[p];
                    var group = decodeURIComponent(point.group);
                    if (typeof groups[group] === "undefined" ) {
                        // Array? Object?
                        // see http://stackoverflow.com/questions/9526860/why-does-a-string-index-in-a-javascript-array-not-increase-the-length-size
                        var color = Apollo.getThemeColor("map-color[" + groupsFound++ + "]");
                        if (DEBUG) console.info("Map new marker group added: " + group + " with color: " + color);
                        groups[group] = getPuempel(color);
                    }

                    // get marker data from calling object
                    var marker = new google.maps.Marker({
                        position: new google.maps.LatLng(point.lat, point.lng),
                        map: map,
                        title: decodeURIComponent(point.title),
                        group: group,
                        icon: groups[group],
                        info: decodeURIComponent(point.info),
                        index: p,
                        mapId: mapId,
                        geocode: point.geocode
                    });

                    // add marker to marker map
                    markers.push(marker);

                    // initialize info window
                    var infoWindow = new google.maps.InfoWindow({
                        content: marker.info,
                        marker: marker,
                        geocode: point.geocode,
                        index: p
                    });

                    // add marker to marker map
                    infoWindows.push(infoWindow);

                    if (DEBUG) console.info("attaching Event lister: " + p + " to map id " + mapId);

                    // attach event listener that shows info window to marker
                    // see http://you.arenot.me/2010/06/29/google-maps-api-v3-0-multiple-markers-multiple-infowindows/
                    marker.addListener('click', function() {
                        showInfo(this.mapId, this.index);
                    });
                }
            }

            // store map in global array, required e.g. to select marker groups etc.
            var map = {
                'id': mapId,
                'map': map,
                'markers': markers,
                'infoWindows': infoWindows
            };
            m_maps[mapId] = map;
        }
    }

    function init() {

        if (DEBUG) {
            console.info("ApolloMap.init()");
            if (Apollo.hasInfo("googleMapKey")) {
                // Goggle map key is read in apollo:pageinfo tag and read to JavaScript via Apollo.init()
                console.info("Google map key is: " + Apollo.getInfo("googleMapKey"));
            } else {
                console.info("Google map key not set in OpenCms VFS!");
            }
        }

        var $mapElements = jQ('.ap-google-map');
        if (DEBUG) console.info(".ap-google-map elements found: " + $mapElements.length);

        if ($mapElements.length > 0) {
            // load the Google map API
            loadGoogleApi();

            // initialize map sections with values from data attributes
            $mapElements.each(function(){
                var $element = jQ(this);
                var $mapElement = $element.find('.mapwindow');

                if (typeof $mapElement.data("map") != 'undefined') {
                    var mapData = $mapElement.data("map");
                    mapData.id = $mapElement.attr("id");
                    if (DEBUG) console.info("mapData found:" + mapData + ", id=" + mapData.id);
                    m_mapData.push(mapData);
                }
            });
        }
    }

    // public available functions
    return {
        init: init,
        initGoogleMaps: initGoogleMaps,
        showMarkers: showMarkers
    }

}(jQuery);

