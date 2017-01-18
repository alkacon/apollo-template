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
 * Global Apollo information object.
 *
 * Provides selected information about the current page from OpenCms to JavaScript.
 */

// Note: If INITDEBUG is false, all INITDEBUG clauses will be removed
// by uglify.js during Apollo JS processing as unreachable code
var INITDEBUG = false;

// this is taken straight from the jQuery docs:
// http://api.jquery.com/jQuery.getScript/
jQuery.loadScript = function( url, options ) {

    if (INITDEBUG) console.info("Apollo loading script from url: " + url);

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


// Acessing object path by String value
// see: http://stackoverflow.com/questions/6491463/accessing-nested-javascript-objects-with-string-key
Object.byString = function(o, s) {
    s = s.replace(/\[(\w+)\]/g, '.$1'); // convert indexes to properties
    s = s.replace(/^\./, '');           // strip a leading dot
    var a = s.split('.');
    for (var i = 0, n = a.length; i < n; ++i) {
        var k = a[i];
        if (k in o) {
            o = o[k];
        } else {
            return;
        }
    }
    return o;
}


// Apollo OpenCms page information class
// See: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Introduction_to_Object-Oriented_JavaScript

var ApolloInfo = function() {

    this.elements = {};
    this.info = {};
    this.data = {};
}


ApolloInfo.prototype.addElement = function(key, element) {

    if(! (key in this.elements)) {
        // element with that name has not been used before, add new array
        this.elements[key] = [element];
    } else {
        // add element to array
        this.elements[key].push(element);
    }
    if (INITDEBUG) console.info("Apollo element for key '" + key + "' added");
}

ApolloInfo.prototype.hasElement = function(key) {

    return key in this.elements;
}

ApolloInfo.prototype.getElements = function(key) {

    if(key in this.elements) {
        return this.elements[key];
    }
    return null;
}


ApolloInfo.prototype.addData = function(key, data) {

    this.data[key] = data;
    if (INITDEBUG) console.info("Apollo data for key '" + key + "' added");
}

ApolloInfo.prototype.hasData = function(key) {

    return key in this.data;
}

ApolloInfo.prototype.getData = function(key) {

    if(key in this.data) {
        return this.data[key];
    }
    return null;
}


ApolloInfo.prototype.addInfo = function(info) {

    jQuery.extend(this.info, info);

    if (INITDEBUG) console.info("Apollo info extended to:");
    if (INITDEBUG) jQuery.each(this.info, function( key, value ) { console.info( "- " + key + ": " + value ); });
}

ApolloInfo.prototype.hasInfo = function(key) {

    return key in this.info;
}

ApolloInfo.prototype.getInfo = function(key) {

    if(key in this.info) {
        return this.info[key];
    }
    return null;
}

ApolloInfo.prototype.isOnlineProject = function() {

    return ("online" == this.info["project"]);
}

ApolloInfo.prototype.getTheme = function() {

    return this.getElements("theme")[0];
}

ApolloInfo.prototype.getThemeColor = function(color) {

    var result = "#f00"; // default return color when all else fails
    var theme = this.getTheme();
    if (theme) {
        try {
            var col = Object.byString(theme, color);
            if (typeof col != "undefined") {
                result = col;
            }
        } catch (e) {
            // result will be default
        }
    }

    return result;
}

ApolloInfo.prototype.removeApolloThemeQuotes = function(string) {
    // passing varaibales from SCSS to JavaScript
    // see https://css-tricks.com/making-sass-talk-to-javascript-with-json/
    if (typeof string === 'string' || string instanceof String) {
        string = string.replace(/^['"]+|\s+|\\|(;\s?})+|['"]$/g, '');
    }
    return string;
}

ApolloInfo.prototype.getApolloTheme= function(elementId) {
    var theme = null;
    element = document.getElementById(elementId);
    if (window.getComputedStyle && window.getComputedStyle(element, '::before') ) {
        theme = window.getComputedStyle(element, '::before');
        theme = theme.content;
        if (INITDEBUG) console.info("Apollo theme found in ::before: " + theme);
    }
    return JSON.parse(apollo.removeApolloThemeQuotes(theme));
}

ApolloInfo.prototype.initApolloInfo = function() {

    // initialize info sections with values from data attributes
    jQuery('#apollo-info').each(function(){

        var $element = $(this);

        if (typeof $element.data("info") != 'undefined') {
            var $info = $element.data("info");
            apollo.addInfo($info);
        }

        var theme = apollo.getApolloTheme($element.attr('id'));
        apollo.addElement("theme", theme);
        if (INITDEBUG) console.info("Apollo main theme color: " + apollo.getThemeColor("main-theme"));
    });
}

// This is the global Apollo information instance
var apollo = new ApolloInfo();

function initApollo() {

    apollo.initApolloInfo();
}