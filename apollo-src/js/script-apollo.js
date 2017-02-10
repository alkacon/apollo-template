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

// Note: If DEBUG is false, all if clauses using it will be removed
// by uglify.js during Apollo JS processing as unreachable code. See
// https://github.com/mishoo/UglifyJS#use-as-a-code-pre-processor
if (typeof DEBUG === 'undefined') {
    DEBUG = true;
}

// Module implemented using the "revealing module pattern", see
// https://addyosmani.com/resources/essentialjsdesignpatterns/book/#revealingmodulepatternjavascript
// https://www.christianheilmann.com/2007/08/22/again-with-the-module-pattern-reveal-something-to-the-world/
var Apollo = function(jQ) {

    // container for information passed from CSS to JavaScript
    this.m_info = {};

    // the color theme passed from CSS to JavaScript
    this.m_theme = null;

    // the grid size when the page was loaded
    this.m_gridInfo = {};

    // additional init functions
    this.m_init = [];


    function addInit(initFunction) {

        if (DEBUG) console.info("Apollo added init function: " + initFunction.name);
        m_init.push(initFunction);
    }

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


    function getCssData(elementId) {
        var data = null;
        element = document.getElementById(elementId);
        if (window.getComputedStyle && window.getComputedStyle(element, '::before') ) {
            data = window.getComputedStyle(element, '::before');
            data = data.content;
            if (DEBUG) console.info("Apollo data found in ::before: " + data);
        }
        return removeQuotes(data);
    }


    function getCssJsonData(elementId) {
        return JSON.parse(getCssData(elementId));
    }


    function gridInfo() {

        return m_gridInfo;
    }


    function initFunctions() {

        for (i=0; i<m_init.length; i++) {
            m_init[i]();
        }
    }


    function initInfo() {

        // initialize info sections with values from data attributes
        jQ('#apollo-info').each(function(){

            var $element = jQ(this);

            if (typeof $element.data("info") != 'undefined') {
                var $info = $element.data("info");
                addInfo($info);
            }

            m_theme = getCssJsonData($element.attr('id'));
            if (DEBUG) console.info("Apollo main theme color: " + getThemeColor("main-theme"));
        });

        // initialize grid size
        m_gridInfo.grid = getCssData('apollo-grid-info');
        if (DEBUG) console.info("Apollo grid info: " + m_gridInfo.grid);
    }

    // public available functions
    return {
        init: init,
        addInit: addInit,
        hasInfo: hasInfo,
        getCssJsonData: getCssJsonData,
        getInfo: getInfo,
        isOnlineProject: isOnlineProject,
        getThemeColor: getThemeColor,
        gridInfo: gridInfo
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
        ApolloCssSampler.init();

        initFunctions();
    }

}(jQuery);
