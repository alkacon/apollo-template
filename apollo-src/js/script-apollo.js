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
var Apollo = function(jQ) {

    // Note: If DEBUG is false, all if clauses using it will be removed
    // by uglify.js during Apollo JS processing as unreachable code
    this.DEBUG = true;

    // container for information passed from CSS to JavaScript
    this.m_info = {};

    // the color theme passed from CSS to JavaScript
    this.m_theme = null;


    function addInfo(info) {

        jQ.extend(m_info, info);

        if (DEBUG) console.info("Apollo info extended to:");
        if (DEBUG) jQ.each(this.info, function( key, value ) { console.info( "- " + key + ": " + value ); });
    }


    function hasInfo(key) {

        return key in m_info;
    }


    function getInfo(key) {

        if(key in m_info) {
            return m_info[key];
        }
        return null;
    }


    function isOnlineProject() {

        return ("online" == m_info["project"]);
    }


    function getThemeColor(color) {

        var result = "#f00"; // default return color when all else fails
        if (m_theme) {
            try {
                var col = Object.byString(m_theme, color);
                if (typeof col != "undefined") {
                    result = col;
                }
            } catch (e) {
                // result will be default
            }
        }

        return result;
    }


    function removeQuotes(string) {
        // passing varaibales from SCSS to JavaScript
        // see https://css-tricks.com/making-sass-talk-to-javascript-with-json/
        if (typeof string === 'string' || string instanceof String) {
            string = string.replace(/^['"]+|\s+|\\|(;\s?})+|['"]$/g, '');
        }
        return string;
    }


    function getApolloTheme(elementId) {
        var theme = null;
        element = document.getElementById(elementId);
        if (window.getComputedStyle && window.getComputedStyle(element, '::before') ) {
            theme = window.getComputedStyle(element, '::before');
            theme = theme.content;
            if (DEBUG) console.info("Apollo theme found in ::before: " + theme);
        }
        return JSON.parse(removeQuotes(theme));
    }


    function initInfo() {

        // initialize info sections with values from data attributes
        jQ('#apollo-info').each(function(){

            var $element = jQ(this);

            if (typeof $element.data("info") != 'undefined') {
                var $info = $element.data("info");
                addInfo($info);
            }

            m_theme = getApolloTheme($element.attr('id'));
            if (DEBUG) console.info("Apollo main theme color: " + getThemeColor("main-theme"));
        });
    }

    // public available functions
    return {
        init: init,
        hasInfo: hasInfo,
        getInfo: getInfo,
        isOnlineProject: isOnlineProject,
        getThemeColor: getThemeColor
    }

    // Apollos main init function!
    // Add you additional modules or init calls here.
    function init() {

        if (DEBUG) console.info("Apollo.init()");

        initInfo();

        ApolloHandlers.init();
        ApolloSliders.init();
        ApolloAnalytics.init();
        ApolloMegaMenu.init();
        ApolloParallax.init();
        ApolloMap.init();
        ApolloImageGallery.init();
        ApolloList.init();
    }

}(jQuery);
