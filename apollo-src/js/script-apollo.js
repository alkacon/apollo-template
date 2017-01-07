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
    // console.info("Apollo element of type " + key + " added");
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

    // console.info("Apollo info extended to:");
    // jQuery.each(this.info, function( key, value ) { console.info( "- " + key + ": " + value ); });
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

// This is the global Apollo information instance

var apollo = new ApolloInfo();


function initApollo() {

    var infos = jQuery('#apollo-info');
    if (infos.length > 0) {
        infos.initApolloInfo();
    }
}

(function($) {

    $.fn.initApolloInfo = function() {
        var $this = $(this);

        // initialize info sections with values from data attributes    
        $this.each(function(){

            var $element = $(this); 
 
            if (typeof $element.data("info") != 'undefined') {
                var $info = $element.data("info");
                apollo.addInfo($info);
            }
        });
    }
})(jQuery);