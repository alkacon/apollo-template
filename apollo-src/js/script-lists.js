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

    // list locks to prevent triggering actions while load still in process
    var m_list_locked = {};

    function updateList(searchStateParameters, id, resetArchive) {

        if (DEBUG) console.info("updateList() called id=" + id);

        var elem = jQ('#' + id);
        reloadList(searchStateParameters, elem, resetArchive);
    }


    function filterList(searchStateParameters, className, resetArchive) {

        if (DEBUG) console.info("filterList() called className=" + className);

        jQ('div[data-id="' + className + '"]').each(function () {
                reloadList(searchStateParameters, $(this), resetArchive);
        });
    }


    function reloadList(searchStateParameters, elem, resetArchive) {

        if (arguments.length == 3 && resetArchive) {
            archiveRemoveHighlight();
        }
        doReloadInnerList(searchStateParameters, elem);
    }


    // Used for both pagination and scroll-reload lists
    function doReloadInnerList(searchStateParameters, elem) {

        var instanceId = elem.attr("id");
        var elementId = elem.data("id");

        if (DEBUG) console.info("doReloadInnerList() called instanceId=" + instanceId + " elementId=" + elementId + " parameters=" + searchStateParameters);

        if (!m_list_locked[instanceId]) {
            m_list_locked[instanceId] = true;

            // hide the "no resluts found" message during search
            elem.find(".editbox").hide();

            var entryBox = elem.find(".ap-list-box");
            var spinner = elem.find(".spinner");
            spinner.hide().removeClass("fadeOut").addClass("fadeIn").show();
            entryBox.find(".list-entry").each(function() {

                $(this).remove();
            });

            entryBox.css("min-height", elem.data("minheight"));
            elem.find(".ap-list-pagination").empty();
            var listOptionBox = $('#listoption_box-' + elementId);
            $.get(buildAjaxLink(elem, instanceId, elementId) + "&".concat(searchStateParameters), function(resultList) {

                listOptionBox.find(".list-options").remove();
                $(resultList).filter(".list-entry").appendTo(entryBox);
                $(resultList).filter('.list-append-position').appendTo(elem.find('.ap-list-pagination'));
                $(resultList).filter(".list-options").appendTo(listOptionBox);
                if ($(resultList).filter(".list-entry").length == 0) {
                    // show the "no resluts found" message
                    elem.find(".editbox").show();
                    elem.find(".ap-list-pagination").hide();
                } else {
                    elem.find(".ap-list-pagination").show();
                }
                spinner.removeClass("fadeIn").addClass("fadeOut");
                entryBox.css("min-height", "0");
                _OpenCmsReinitEditButtons();
                m_list_locked[instanceId] = false;
            });
        }
    }

    // Used for scroll-reload lists
    function appendInnerList(searchStateParameters, elem) {

        var instanceId = elem.attr("id");
        var elementId = elem.data("id");

        if (DEBUG) console.info("appendInnerList() called instanceId=" + instanceId + " elementId=" + elementId + " parameters=" + searchStateParameters);

        if (!m_list_locked[instanceId]) {
            m_list_locked[instanceId] = true;
            var spinner = elem.find(".spinner");
            var entryBox = elem.find(".ap-list-box");
            spinner.hide().removeClass("fadeOut").addClass("fadeIn").css("top", entryBox.height() - 200).show();
            elem.find('.loadMore').addClass("fadeOut");

            // reload elements with AJAX here
            $.get(buildAjaxLink(elem, instanceId, elementId) + "&hideOptions=true&".concat(searchStateParameters), function(resultList) {

                elem.find('.list-append-position').remove();
                $(resultList).filter(".list-entry").appendTo(elem.find('.ap-list-box'));
                $(resultList).filter(".list-append-position").appendTo(elem.find('.ap-list-pagination'));
                if ($(resultList).filter(".list-append-position").length == 0) {
                    elem.find('.ap-list-pagination').css("min-height", "0");
                }
                spinner.removeClass("fadeIn").addClass("fadeOut");
                _OpenCmsReinitEditButtons();
                m_list_locked[instanceId] = false;
            });
        }
    }

    function buildAjaxLink(elem, instanceId, elementId) {

        var params = "?contentpath=" + elem.data("path")
            + "&instanceId="
            + instanceId
            + "&elementId="
            + elementId
            + "&sitepath="
            + elem.data("sitepath")
            + "&subsite="
            + elem.data("subsite")
            + "&__locale="
            + elem.data("locale")
            + "&loc="
            + elem.data("locale");

        var facets = $("#listoption_box-" + elementId);
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

    function init() {

        if (DEBUG) console.info("ApolloList.init()");

        var $listElements = jQ('.ap-list-entries');

        if (DEBUG) console.info(".ap-list-entries elements found: " + $listElements.length);

        if ($listElements.length > 0 ) {
            $listElements.each(function() {

                var $list = $(this);
                var instanceId = $list.attr("id");
                m_list_locked[instanceId] = false;
                reloadList("", $list);

                if ($list.data("dynamic") === true) {
                    // load more from list if scrolled to last item
                    $(window).scroll(function(event) {

                        var appendPosition = $list.find(".list-append-position");

                        if (appendPosition.length
                            && !m_list_locked[instanceId]
                            && appendPosition.data("dynamic")
                            && appendPosition.visible(true)) {
                            appendInnerList($list.find('.loadMore').attr('data-load'), $list);
                        }
                    });
                }
            });
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
