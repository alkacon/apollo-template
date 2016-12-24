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

function initMegamenu() {

    var menus = $("[data-menu]");
    for (var i = 0; i < menus.length; i++) {
        var menu = menus.eq(i);
        insertMenu(menu.data("menu"), menu);
    }
}

function insertMenu(path, navElem) {

    $.ajax({
        method : "POST",
        url : path + "?__disableDirectEdit=true&ajaxreq=true"
    }).done(function(content) {

        var dropdown = $("<div></div>").addClass("dropdown-menu").addClass("dropdown-megamenu");
        var row = $(content).find(".row").eq(0);
        dropdown.append(row);
        navElem.find("ul").remove();
        navElem.append(dropdown);
    });
}

$(document).ready(function() {

    initMegamenu();
});