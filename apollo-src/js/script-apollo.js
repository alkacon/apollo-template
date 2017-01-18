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

// Note: If INITDEBUG is false, all if clauses using it will be removed
// by uglify.js during Apollo JS processing as unreachable code
var INITDEBUG = false;

// Apollo OpenCms page information class
var Apollo = function() {

    this.elements = {};
    this.info = {};
    this.data = {};
}

Apollo.prototype.addElement = function(key, element) {

    if(! (key in this.elements)) {
        // element with that name has not been used before, add new array
        this.elements[key] = [element];
    } else {
        // add element to array
        this.elements[key].push(element);
    }
    if (INITDEBUG) console.info("Apollo element for key '" + key + "' added");
}

Apollo.prototype.hasElement = function(key) {

    return key in this.elements;
}

Apollo.prototype.getElements = function(key) {

    if(key in this.elements) {
        return this.elements[key];
    }
    return null;
}


Apollo.prototype.addData = function(key, data) {

    this.data[key] = data;
    if (INITDEBUG) console.info("Apollo data for key '" + key + "' added");
}

Apollo.prototype.hasData = function(key) {

    return key in this.data;
}

Apollo.prototype.getData = function(key) {

    if(key in this.data) {
        return this.data[key];
    }
    return null;
}


Apollo.prototype.addInfo = function(info) {

    jQuery.extend(this.info, info);

    if (INITDEBUG) console.info("Apollo info extended to:");
    if (INITDEBUG) jQuery.each(this.info, function( key, value ) { console.info( "- " + key + ": " + value ); });
}

Apollo.prototype.hasInfo = function(key) {

    return key in this.info;
}

Apollo.prototype.getInfo = function(key) {

    if(key in this.info) {
        return this.info[key];
    }
    return null;
}

Apollo.prototype.isOnlineProject = function() {

    return ("online" == this.info["project"]);
}

Apollo.prototype.getTheme = function() {

    return this.getElements("theme")[0];
}

Apollo.prototype.getThemeColor = function(color) {

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

Apollo.removeApolloThemeQuotes = function(string) {
    // passing varaibales from SCSS to JavaScript
    // see https://css-tricks.com/making-sass-talk-to-javascript-with-json/
    if (typeof string === 'string' || string instanceof String) {
        string = string.replace(/^['"]+|\s+|\\|(;\s?})+|['"]$/g, '');
    }
    return string;
}

Apollo.getApolloTheme= function(elementId) {
    var theme = null;
    element = document.getElementById(elementId);
    if (window.getComputedStyle && window.getComputedStyle(element, '::before') ) {
        theme = window.getComputedStyle(element, '::before');
        theme = theme.content;
        if (INITDEBUG) console.info("Apollo theme found in ::before: " + theme);
    }
    return JSON.parse(Apollo.removeApolloThemeQuotes(theme));
}


Apollo.init = function() {

    // Set the global Apollo information instance
    window.AP = new Apollo();
    window.apollo = AP;

    // initialize info sections with values from data attributes
    jQuery('#apollo-info').each(function(){

        var $element = jQuery(this);

        if (typeof $element.data("info") != 'undefined') {
            var $info = $element.data("info");
            AP.addInfo($info);
        }

        var theme = Apollo.getApolloTheme($element.attr('id'));
        AP.addElement("theme", theme);
        if (INITDEBUG) console.info("Apollo main theme color: " + AP.getThemeColor("main-theme"));
    });
}

function initApollo() {

    Apollo.init();
}