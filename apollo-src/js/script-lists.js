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
var ApolloList = function(jQ) {

    // all initialized Lists
    this.m_lists = {};

    // all auto loading LISTS as array for easy iteration
    this.m_autoLoadLists = [];

    // list locks to prevent triggering actions while load still in process
    var m_list_locked = {};

    function updateList(searchStateParameters, id, resetArchive) {

        if (DEBUG) console.info("updateList() called id=" + id);

        if (arguments.length == 3 && resetArchive) {
            archiveRemoveHighlight();
        }
        reloadInnerList(id, searchStateParameters);
    }


    function filterList(searchStateParameters, elementId, resetArchive) {

        if (DEBUG) console.info("filterList() called elementId=" + elementId);

        if (arguments.length == 3 && resetArchive) {
            archiveRemoveHighlight();
        }
        jQ('div[data-id="' + elementId + '"]').each(function () {
            reloadInnerList($(this).attr("id"), searchStateParameters);
        });
    }


    // Used for both pagination and scroll-reload lists
    function reloadInnerList(id, searchStateParameters) {
        searchStateParameters = searchStateParameters || "";

        var list = m_lists[id];

        if (DEBUG) console.info("reloadInnerList() called instanceId=" + list.id + " elementId=" + list.elementId + " parameters=" + searchStateParameters);

        if (!list.locked) {
            list.locked = true;

            // hide the "no results found" message during search
            list.$editbox.hide();
            list.$spinner.hide().removeClass("fadeOut").addClass("fadeIn").show();

            // clear the current displayed list entries
            list.$entrybox.find(".list-entry").each(function() {
                $(this).remove();
            });

            list.$entrybox.css("min-height", list.minheigh);
            list.$pagination.empty();

            var listOptionBox = $('#listoption_box-' + list.elementId);
            $.get(buildAjaxLink(list) + "&" + searchStateParameters, function(resultList) {

                listOptionBox.find(".list-options").remove();
                $(resultList).filter(".list-entry").appendTo(list.$entrybox);
                $(resultList).filter('.list-append-position').appendTo(list.$pagination);
                $(resultList).filter(".list-options").appendTo(listOptionBox);
                if ($(resultList).filter(".list-entry").length == 0) {
                    // show the "no resluts found" message
                    list.$editbox.show();
                    list.$pagination.hide();
                } else {
                    list.$pagination.show();
                }
                list.$spinner.removeClass("fadeIn").addClass("fadeOut");
                list.$entrybox.css("min-height", "0");
                _OpenCmsReinitEditButtons();
                list.locked = false;
                if (list.dynamic == "true") {
                    // check if we can render more of this dynamic loading list
                    handleAutoLoaders()
                }
            });
        }
    }

    // Used for scroll-reload lists
    function appendInnerList(id, searchStateParameters) {
        searchStateParameters = searchStateParameters || "";

        var list = m_lists[id];

        if (DEBUG) console.info("appendInnerList() called instanceId=" + list.id + " elementId=" + list.elementId + " parameters=" + searchStateParameters);

        if (!list.locked) {
            list.locked = true;

            list.$spinner.hide().removeClass("fadeOut").addClass("fadeIn").css("top", list.$entrybox.height() - 200).show();

            list.$element.find('.loadMore').addClass("fadeOut");

            // reload elements with AJAX here
            $.get(buildAjaxLink(list) + "&hideOptions=true&" + searchStateParameters, function(resultList) {

                list.$element.find('.list-append-position').remove();
                $(resultList).filter(".list-entry").appendTo(list.$entrybox);
                $(resultList).filter(".list-append-position").appendTo(list.$pagination);
                if ($(resultList).filter(".list-append-position").length == 0) {
                    list.$pagination.css("min-height", "0");
                }
                list.$spinner.removeClass("fadeIn").addClass("fadeOut");
                _OpenCmsReinitEditButtons();
                list.locked = false;
            });
        }
    }


    function buildAjaxLink(list) {

        var params = "?contentpath=" + list.path
            + "&instanceId="
            + list.id
            + "&elementId="
            + list.elementId
            + "&sitepath="
            + list.sitepath
            + "&subsite="
            + list.subsite
            + "&__locale="
            + list.locale
            + "&loc="
            + list.locale;

        var facets = $("#listoption_box-" + list.elementId);
        if (facets.length != 0) {
            params = params + "&facets=" + facets.data("facets");
        }
        if (list.dynamic == "true") {
            params = params + "&dynamic=true";
        }
        return list.ajax + params;
    }


    function archiveHighlight(elem) {

        archiveRemoveHighlight();
        elem.parent().addClass("active");
    }


    function archiveRemoveHighlight() {

        $(".ap-list-filters li.active").removeClass("active");
    }


    function handleAutoLoaders() {
        if (m_autoLoadLists != null) {
            for (i=0; i<m_autoLoadLists.length; i++) {

                var list = m_autoLoadLists[i];
                var appendPosition = list.$element.find(".list-append-position");

                if (appendPosition.length
                    && !list.locked
                    && appendPosition.data("dynamic")
                    // NOTE: jQuery.visible() is defined in script-jquery-extensions.js
                    && appendPosition.visible()) {

                    appendInnerList(list.id, list.$element.find('.loadMore').attr('data-load'));
                }
            }
        }
    }


    function init() {

        if (DEBUG) console.info("ApolloList.init()");

        var $listElements = jQ('.ap-list-entries');

        if (DEBUG) console.info(".ap-list-entries elements found: " + $listElements.length);

        if ($listElements.length > 0 ) {
            $listElements.each(function() {

                // initialize lists with values from data attributes
                var $list = $(this);

                if (typeof $list.data("list") != 'undefined') {
                    // read list data
                    var list = $list.data("list");
                    // add more data to list
                    list.$element = $list;
                    list.locked = false;
                    list.id = $list.attr("id");
                    list.elementId = $list.data("id");
                    list.$editbox = $list.find(".editbox");
                    list.$entrybox = $list.find(".ap-list-box");
                    list.$spinner = $list.find(".spinner");
                    list.$pagination = $list.find(".ap-list-pagination");
                    if (list.dynamic == "true") {
                        // this is a auto loading list (on scrolling)
                        m_autoLoadLists.push(list);
                    }
                    // store list data in global array
                    m_lists[list.id] = list;
                    if (DEBUG) console.info("List data found: id=" + list.id + ", elementId=" + list.elementId);
                }

                // load the initial list
                reloadInnerList(list.id);
            });

            if (m_autoLoadLists.length > 0) {
                // only enable scroll listener if we have at least one autoloading gallery
                jQ(window).bind('scroll', handleAutoLoaders);
            }
        }
    }

    // public available functions
    return {
        init: init,
        archiveHighlight: archiveHighlight,
        archiveRemoveHighlight: archiveRemoveHighlight,
        update: updateList,
        filter: filterList
    }

}(jQuery);
