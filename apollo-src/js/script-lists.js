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

var list_lock = new Array();

function initLists() {

    $(".ap-list-entries").each(function() {

        reloadInnerList("", $(this));
        var list = $(this);
        if (list.data("dynamic") === true) {
            // load more from list if scrolled to last item
            $(window).scroll(function(event) {

                var pag = list.find(".list-append-position");
                if (pag.length && pag.data("dynamic") && pag.visible(true)) {
                    appendInnerList(list.find('.loadMore').attr('data-load'), list);
                }
            });
        }
    });
}

function reloadInnerList(searchStateParameters, elem, resetArchive) {

    if (arguments.length == 3 && resetArchive) {
        archiveRemoveHighlight();
    }
    doReloadInnerList(searchStateParameters, elem);
}

// Used for both pagination and scroll-reload lists
function doReloadInnerList(searchStateParameters, elem) {

    if (typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]) {
        list_lock[elem.attr("id")] = true;
        if (typeof elem === 'undefined') {
            elem = $('.ap-list-entries').first();
        }
        var entryBox = elem.find(".ap-list-box");
        var spinner = elem.find(".spinner");
        spinner.hide().removeClass("fadeOut").addClass("fadeIn").show();
        entryBox.find(".list-entry").each(function() {

            $(this).remove();
        });

        entryBox.css("min-height", elem.data("minheight"));
        elem.find(".ap-list-pagination").empty();
        var listOptionBox = $('#listoption_box-' + elem.data('id'));
        $.get(buildAjaxLink(elem) + "&".concat(searchStateParameters), function(resultList) {

            listOptionBox.find(".list-options").remove();
            $(resultList).filter(".list-entry").appendTo(entryBox);
            $(resultList).filter('.list-append-position').appendTo(elem.find('.ap-list-pagination'));
            $(resultList).filter(".list-options").appendTo(listOptionBox);
            if (list_lock && $(resultList).filter(".list-entry").length == 0) {
                showEmpty(elem);
            }
            spinner.removeClass("fadeIn").addClass("fadeOut");
            entryBox.css("min-height", "0");
            _OpenCmsReinitEditButtons();
            list_lock[elem.attr("id")] = false;
        });
    }
}

// Used for scroll-reload lists
function appendInnerList(searchStateParameters, elem) {

    if (typeof list_lock[elem.attr("id")] === "undefined" || !list_lock[elem.attr("id")]) {
        list_lock[elem.attr("id")] = true;
        var spinner = elem.find(".spinner");
        var entryBox = elem.find(".ap-list-box");
        spinner.hide().removeClass("fadeOut").addClass("fadeIn").css("top", entryBox.height() - 200).show();
        elem.find('.loadMore').addClass("fadeOut");

        // reload elements with AJAX here
        $.get(buildAjaxLink(elem) + "&hideOptions=true&".concat(searchStateParameters), function(resultList) {

            elem.find('.list-append-position').remove();
            $(resultList).filter(".list-entry").appendTo(elem.find('.ap-list-box'));
            $(resultList).filter(".list-append-position").appendTo(elem.find('.ap-list-pagination'));
            if ($(resultList).filter(".list-append-position").length == 0) {
                elem.find('.ap-list-pagination').css("min-height", "0");
            }
            spinner.removeClass("fadeIn").addClass("fadeOut");
            _OpenCmsReinitEditButtons();
            list_lock[elem.attr("id")] = false;
        });
    }
}

function buildAjaxLink(elem) {

    var params = "?contentpath=" + elem.data("path")
        + "&id="
        + elem.data("id")
        + "&sitepath="
        + elem.data("sitepath")
        + "&subsite="
        + elem.data("subsite")
        + "&__locale="
        + elem.data("locale")
        + "&loc="
        + elem.data("locale");

    var facets = $("#listoption_box-" + elem.data("id"));
    if (facets.length != 0) {
        params = params + "&facets=" + facets.data("facets");
    }
    if (elem.data("dynamic") === true) {
        params = params + "&dynamic=true";
    }
    return elem.data("ajax") + params;
}

function archiveHighlight(elem) {

    archiveRemoveHighlight();
    elem.parent().addClass("active");
}

function archiveRemoveHighlight() {

    $(".ap-list-filters li.active").removeClass("active");
}

function showEmpty(elem) {

    elem.find(".editbox").show();
}