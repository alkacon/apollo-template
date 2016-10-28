<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
    <cms:formatter var="content" val="value" rdfa="rdfa">
    
        <c:set var="inMemoryMessage"><fmt:message key="apollo.list.message.inmemory" /></c:set>
        <c:set var="editMessage"><fmt:message key="apollo.list.message.edited" /></c:set>
        <apollo:init-messages textnew="${inMemoryMessage}" textedit="${editMessage}">
        
            <apollo:formatter-settings 
                type="${content.value.TypesToCollect}" 
                parameters="${content.valueList.Parameters}"
                online="${cms.isOnlineProject}" 
            />

            <apollo:list-search source="${value.Folder}" types="${value.TypesToCollect}" categories="${content.readCategories}" 
                            count="${value.ItemsPerPage.toInteger}" sort="${value.SortOrder}" showexpired="${cms.element.settings.showexpired}" filterqueries="${value.FilterQueries}" />
            <div class="${formatterSettings.listWrapper}">
                <div class="ap-list-filters ${formatterSettings.filterWrapper}" data-id="${cms.element.id}">

                    <c:if test="${cms.element.settings.showsearch}">
                        <div class="ap-list-filterbox ap-list-filterbox-search">
                            <form role="form" class="form-inline" id="queryform" onsubmit="return false;">
                                <div class="input-group">
                                    <c:set var="escapedQuery">${fn:replace(search.controller.common.state.query,'"','&quot;')}</c:set>
                                    <input type="hidden" name="${search.controller.common.config.lastQueryParam}" value="${escapedQuery}" />
                                    <input type="hidden" name="${search.controller.common.config.reloadedParam}" />
                                    <span class="input-group-addon"><span class="icon-magnifier"></span></span>
                                    <input name="${search.controller.common.config.queryParam}" id="queryinput" class="form-control" type="text" value="${escapedQuery}" placeholder="<fmt:message key="apollo.list.message.search" />">
                                </div>
                            </form>
                        </div>
                    </c:if>
                    
                    <c:set var="catDisplay">${formatterSettings.catPreopened ? 'style="display:block;"' : ''}</c:set>
                    <c:set var="archiveDisplay">${formatterSettings.archivePreopened ? 'style="display:block;"' : ''}</c:set>

                    <c:if test="${cms.element.settings.showlabels and not empty fieldFacetResult and cms:getListSize(fieldFacetResult.values) > 0}">
                        <div class="ap-list-filterbox ap-list-filterbox-labels">

                            <button type="button" class="btn-block btn ap-list-filterbtn-labels" onclick="toggleApListFilter('labels');this.blur();">
                                <span class="pull-left pr-10"><span class="fa fa-tag"></span></span>
                                <span class="pull-left"><fmt:message key="apollo.list.message.labels" /></span>
                                <span id="aplistlabels_toggle" class="fa fa-chevron-down pull-right"></span>
                            </button>

                            <div id="aplistlabels" class="ap-list-filter-labels-wrapper" ${catDisplay}>
                                <hr>
                                <ul class="ap-list-filter-labels">
                                    <c:set var="catFilters" value=",${fn:replace(formatterSettings.catfilters,' ','')}," />
                                    <c:set var="blacklistFilter" value="${fn:startsWith(catFilters,',whitelist') ? 'false' : 'true'}" />
                                    <c:forEach var="value" items="${fieldFacetResult.values}">
                                        <c:set var="selected">${fieldFacetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>
                                        <c:set var="itemName">${value.name}</c:set>
                                        <c:set var="currCat" value="${cms.readCategory[itemName]}" />
                                        <c:set var="currCatTitle" value=",${fn:replace(currCat.title,' ','')}," />
                                        <c:if test="${blacklistFilter != fn:contains(catFilters, currCatTitle)}">
                                            <c:set var="showLabel" value="false" />
                                            <c:choose>
                                                <c:when test="${not empty categoryPaths}">
                                                    <c:forTokens var="testCat" items="${categoryPaths}" delims=",">
                                                        <c:if test="${fn:startsWith(currCat.path, testCat)}">
                                                            <c:set var="showLabel" value="true" />
                                                        </c:if> 
                                                    </c:forTokens>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="showLabel" value="true" />  
                                                </c:otherwise>
                                            </c:choose>

                                            <c:if test="${showLabel}">
                                                <li ${selected}>
                                                    <a href="javascript:void(0)"
                                                        onclick="reloadInnerList('${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[categoryFacetField][value.name]}', 
                                                        $('#list-' + $(this).parents('.ap-list-filters').data('id'))); archiveHighlight($(this)); clearQuery();">
                                                        ${currCat.title}    (${value.count})
                                                    </a>
                                                </li>
                                            </c:if>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${cms.element.settings.showarchive and not empty rangeFacet and cms:getListSize(rangeFacet.counts) > 0}">
                        <div class="ap-list-filterbox ap-list-filterbox-archive ${formatterSettings.archiveWrapper}">
                            <button type="button" class="btn-block btn ap-list-filterbtn-archive" onclick="toggleApListFilter('archive');this.blur();">
                                <span class="pull-left pr-10"><span class="fa fa-archive"></span></span>
                                <span class="pull-left"><fmt:message key="apollo.list.message.archive" /></span>
                                <span id="aplistarchive_toggle" class="fa fa-chevron-down pull-right"></span>
                            </button>

                            <div id="aplistarchive" class="ap-list-filter-archive"  ${archiveDisplay}>

                                <c:set var="archiveHtml" value="" />
                                <c:set var="yearHtml" value="" />
                                <c:set var="prevYear" value="-1" />
                                <c:set var="monthSelected" value="false" />
                                <c:forEach var="facetItem" items="${rangeFacet.counts}" varStatus="status">
                                    <c:set var="selected">${rangeFacetController.state.isChecked[facetItem.value] ? ' class="active"' : ""}</c:set>
                                    <fmt:parseDate var="fDate" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" value="${facetItem.value}"/>
                                    <c:set var="currYear"><fmt:formatDate value="${fDate}" pattern="yyyy" /></c:set>

                                    <c:if test="${prevYear != currYear}">
                                        <%-- another year, generate year toggle button --%>
                                        <c:if test="${not status.first}">
                                            <%-- close month list of previous year --%>
                                            <c:set var="yearHtml">${yearHtml}</ul></c:set>
                                        </c:if>
                                        <c:set var="archiveHtml">${yearHtml}${archiveHtml}</c:set>
                                        <c:set var="yearHtml">
                                            <button type="button" class="btn-block btn btn-xs ap-list-filterbtn-year" onclick="toggleApListFilter('year${currYear}');this.blur();">
                                                <span class="pull-left">${currYear}</span>
                                                <i id="aplistyear${currYear}_toggle" class="fa fa-chevron-down pull-right"></i>
                                            </button>
                                            <ul class="ap-list-filter-year" id="aplistyear${currYear}" style="display:none;">
                                        </c:set>
                                    </c:if>
                                    <%-- add month list entry to current year --%>
                                    <c:set var="yearHtml">
                                        ${yearHtml}
                                        <li ${selected}>
                                            <a href="javascript:void(0)"
                                                    onclick="reloadInnerList('${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[rangeFacetField][facetItem.value]}', 
                                                    $('#list-' + $(this).parents('.ap-list-filters').data('id'))); archiveHighlight($(this)); clearQuery();" title="${facetItem.count}">
                                                <fmt:formatDate value="${fDate}" pattern="MMM" />
                                            </a>
                                        </li>
                                    </c:set>
                                    <c:if test="${not empty selected}">
                                        <c:set var="yearHtml">${fn:replace(yearHtml, 'style="display:none;"', '')}</c:set>
                                        <c:set var="yearHtml">${fn:replace(yearHtml, 'fa-chevron-down', 'fa-chevron-up')}</c:set>
                                        <c:set var="monthSelected" value="true" />
                                    </c:if>
                                    <c:set var="prevYear" value="${currYear}" />
                                </c:forEach>
                                <%-- close month list of last year, remove style attribute, replace chevron and add it to archive HTML --%>
                                <c:if test="${not monthSelected}">
                                    <c:set var="yearHtml">${fn:replace(yearHtml, 'style="display:none;"', '')}</c:set>
                                    <c:set var="yearHtml">${fn:replace(yearHtml, 'fa-chevron-down', 'fa-chevron-up')}</c:set>
                                </c:if>
                                <c:set var="archiveHtml">${yearHtml}</ul>${archiveHtml}</c:set>

                                ${archiveHtml}
                            </div> <%-- /ap-list-filter-archive --%>

                        </div> <%-- /ap-list-filterbox-archive --%>
                    </c:if>

                </div> <%-- /ap-list-filters --%>

                <script type="text/javascript">
                    function toggleApListFilter(fType) {
                        $("#aplist" + fType + "_toggle").toggleClass("fa-chevron-down");
                        $("#aplist" + fType + "_toggle").toggleClass("fa-chevron-up");
                        $("#aplist" + fType + "").slideToggle();
                    }

                    window.onload = function () {
                        $( "#queryform" ).submit(function( event ) {
                            reloadInnerList("${search.stateParameters.resetAllFacetStates}&q=" + $("#queryinput").val(), $('#list-' + $(this).parents('.ap-list-filters').data('id')));
                        });
                    }

                    function clearQuery(){
                        if(window.jQuery){
                            $("#queryinput").val('');
                        }
                    }
                </script>

            </div>
        </apollo:init-messages> 
    </cms:formatter>

</cms:bundle>
