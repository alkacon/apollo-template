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
var ApolloMegaMenu = function(jQ) {

    // Note: If DEBUG is false, all if clauses using it will be removed
    // by uglify.js during Apollo JS processing as unreachable code
    this.DEBUG = false;

    function insertMenu(path, $megaMenu) {

        jQ.ajax({
            method : "POST",
            url : path + "?__disableDirectEdit=true&ajaxreq=true"
        }).done(function(content) {

            var $dropdown = jQuery("<div></div>").addClass("dropdown-menu").addClass("dropdown-megamenu");
            var $row = jQuery(content).find(".row").eq(0);
            $dropdown.append($row);

            $megaMenu.find("ul").remove();
            $megaMenu.append($dropdown);
        });
    }

    function init() {

        if (DEBUG) console.info("ApolloMegaMenu.init()");

        var $megaMenus = jQ("[data-menu]");
        if (DEBUG) console.info("[data-menu] elements found: " + $megaMenus.length);

        if ($megaMenus.length > 0) {
            jQ(document).on('click', '.mega-menu .dropdown-menu', function(e) {
                e.stopPropagation();
            });
            for (var i = 0; i < $megaMenus.length; i++) {
                var $megaMenu = $megaMenus.eq(i);
                insertMenu($megaMenu.data("menu"), $megaMenu);
            }
        }
    }

    // public available functions
    return {
        init: init
    }

}(jQuery);

