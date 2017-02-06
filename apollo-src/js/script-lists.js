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

    // all initialized lists by unique instance id
    this.m_lists = {};

    // groups of initialized lists by element id (potentially more then once on a page)
    this.m_listGroups = {};

    // all auto loading lists as array for easy iteration
    this.m_autoLoadLists = [];

    // list locks to prevent triggering actions while load still in process
    var m_list_locked = {};

    function updateList(searchStateParameters, id, resetArchive, keepEntries) {
        resetArchive = resetArchive || false;
        keepEntries = keepEntries || false;

        if (DEBUG) console.info("updateList() called id=" + id);

        if (arguments.length == 3 && resetArchive) {
            archiveRemoveHighlight();
        }
        updateInnerList(id, searchStateParameters, !keepEntries);
    }


    function filterList(searchStateParameters, elementId, resetArchive) {

        if (DEBUG) console.info("filterList() called elementId=" + elementId);

        if (arguments.length == 3 && resetArchive) {
            archiveRemoveHighlight();
        }
        var listGroup = m_listGroups[elementId];
        for (i=0; i<listGroup.length; i++) {
            updateInnerList(listGroup[i].id, searchStateParameters, true);
        }
    }

    // used for both pagination and scroll-reload lists
    function updateInnerList(id, searchStateParameters, reloadEntries) {
        searchStateParameters = searchStateParameters || "";
        reloadEntries = reloadEntries || false;

        var list = m_lists[id];

        if (DEBUG) console.info("updateInnerList() called instanceId=" + list.id + " elementId=" + list.elementId + " parameters=" + searchStateParameters);

        if (!list.locked) {
            list.locked = true;

            var ajaxOptions = "&";
            if (reloadEntries) {
                // hide the "no results found" message during search
                list.$editbox.hide();
            } else {
                // fade out the load more button
                list.$element.find('.loadMore').addClass("fadeOut");
                // we don't need to calculate facets again if we do not reload all entries
                ajaxOptions = "&hideOptions=true&";
            }

            // calculate the spinner position in context to the visible list part
            var scrollTop = jQ(window).scrollTop();
            var windowHeight = jQ(window).height();
            var elementTop = list.$element.offset().top;
            var elementHeight = list.$element.outerHeight(true);
            var topOffset = Math.max(scrollTop - elementTop, 0);
            var visibleHeight = Math.min(scrollTop + windowHeight, elementTop + elementHeight) - Math.max(scrollTop, elementTop);
            var spinnerPos = (visibleHeight * (reloadEntries ? 0.5 : 0.8)) + topOffset - 15;
            // show the spinner
            list.$spinner.hide().removeClass("fadeOut").addClass("fadeIn").css("top", spinnerPos).show();

            var facetOptions = jQ('#facets_' + list.elementId);
            $.get(buildAjaxLink(list, ajaxOptions, searchStateParameters), function(resultList) {

                var $result = jQ(resultList);
                // collect information about the search result
                var resultData = $result.filter('#resultdata').first().data('result');
                if (DEBUG) console.info("Search result: list=" + list.id + ", start=" + resultData.start + ", end=" + resultData.end + ", entries=" + resultData.found + ", pages=" + resultData.pages);

                // append all results from the ajax call to a new element that is not yet displayed
                var $entries = $result.filter(".list-entry");
                var $newPage = jQ('<div class="list-entry-page"></div>');
                $entries.appendTo($newPage);

                // clear the pagination element
                list.$pagination.empty();

                if (reloadEntries) {
                    // remove the old entries when list is relaoded
                    var $oldPage = list.$entrybox.find(".list-entry-page");
                    // set min-height of list to avoid screen flicker
                    list.$entrybox.css("min-height", list.$entrybox.height() + 'px');
                    $oldPage.remove();
                }

                // add the new elements to the list
                $newPage.appendTo(list.$entrybox);

                // set pagination element with new content
                $result.filter('.list-append-position').appendTo(list.$pagination);

                if (reloadEntries) {
                    // reset the list option box
                    facetOptions.find(".list-options").remove();
                    $result.filter(".list-options").appendTo(facetOptions);

                    // check if we have found any results
                    if ($entries.length == 0) {
                        // show the "no results found" message
                        list.$editbox.show();
                        // no results means we don't need any pagination element
                        list.$pagination.hide();
                    } else {
                        // show the pagination element
                        list.$pagination.show();
                    }
                    // reset the min-height of the list now that the elements are visible
                    list.$entrybox.animate({'min-height': "0px"}, 500);
                }

                // fade out the spinner
                list.$spinner.removeClass("fadeIn").addClass("fadeOut");

                // reset the OpenCms edit buttons
                _OpenCmsReinitEditButtons();
                list.locked = false;

                if ((list.appendOption == "clickfirst") && list.notclicked && !reloadEntries) {
                    // this is a auto loading list that is activated on first click
                    m_autoLoadLists.push(list);
                    list.notclicked = false;
                    if (m_autoLoadLists.length == 1) {
                        // enable scroll listener because we now have one autoloading gallery
                        jQ(window).bind('scroll', handleAutoLoaders);
                    }
                    handleAutoLoaders();
                } else if (reloadEntries && list.autoload) {
                    // check if we can render more of this automatic loading list
                    handleAutoLoaders();
                }
            });
        }
    }


    function buildAjaxLink(list, ajaxOptions, searchStateParameters) {

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

        var facets = jQ("#facets_" + list.elementId);
        if (facets.length != 0) {
            params = params + "&facets=" + facets.data("facets");
        }
        params = params + "&option=" + list.option;
        return list.ajax + params + ajaxOptions + searchStateParameters;
    }


    function archiveHighlight(elem) {

        archiveRemoveHighlight();
        elem.parent().addClass("active");
    }


    function archiveRemoveHighlight() {

        jQ(".ap-list-filters li.active").removeClass("active");
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

                    updateInnerList(list.id, list.$element.find('.loadMore').attr('data-load'), false);
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
                var $list = jQ(this);

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
                    list.autoload = false;
                    list.notclicked = true;
                    if (list.appendSwitch.includes(Apollo.gridInfo().grid)) {
                        // I think this is a cool way for checking the screen size ;)
                        list.option = "append";
                    } else {
                        list.option = "paginate";
                    }
                    if ((list.option == "append") && (list.appendOption == "noclick")) {
                        // list automatically loads in scrolling
                        list.autoload = true;
                        m_autoLoadLists.push(list);
                    };
                    // store list data in global array
                    m_lists[list.id] = list;
                    // store list in global group array
                    var group = m_listGroups[list.elementId];
                    if (typeof group != 'undefined') {
                        group.push(list);
                    } else {
                        m_listGroups[list.elementId] = [list];
                    }
                    if (DEBUG) console.info("List data found: id=" + list.id + ", elementId=" + list.elementId + " option=" + list.option);
                }

                // load the initial list
                updateInnerList(list.id, "", true);
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
