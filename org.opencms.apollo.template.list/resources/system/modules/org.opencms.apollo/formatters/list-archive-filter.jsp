<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages reload="true">

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

<apollo:formatter-settings
    type="${content.value.TypesToCollect}"
    parameters="${content.valueList.Parameters}"
    online="${cms.isOnlineProject}"
/>

<%-- We just want to load facet metadata here, no actual results, so the count is 0 --%>
<apollo:list-search
    source="${content.valueList.Folder}"
    types="${value.TypesToCollect}"
    categories="${content.readCategories}"
    count="0"
    sort="${value.SortOrder}"
    showexpired="${empty formatterSettings.showExpired || formatterSettings.showExpired}"
    filterqueries="${value.FilterQueries}"
/>

<c:set var="csswrapper" value="${not empty formatterSettings.filterWrapper ? formatterSettings.filterWrapper : formatterSettings.listWrapper}" />

<c:set var="elementId"><apollo:idgen prefix="le" uuid="${cms.element.id}" /></c:set>
<c:set var="archiveId"><apollo:idgen prefix="la" uuid="${cms.element.instanceId}" /></c:set>

<c:set var="showSearch" value="${cms.element.setting.showsearch.toBoolean}" />
<c:set var="showCategories" value="${cms.element.setting.showlabels.toBoolean and not empty fieldFacetResult and cms:getListSize(fieldFacetResult.values) > 0}" />
<c:set var="showArchive" value="${cms.element.setting.showarchive.toBoolean and not empty rangeFacet and cms:getListSize(rangeFacet.counts) > 0}" />

<div class="ap-list-archive ${csswrapper}" <%--
--%>id="${archiveId}" <%--
--%>data-id="${elementId}" <%--
--%>data-filter='{<%--
    --%>"search":"${showSearch}", <%--
    --%>"categories":"${showCategories}", <%--
    --%>"archive":"${showArchive}"<%--
--%>}'>

    <c:if test="${showSearch}">
        <div class="filterbox search">
            <form role="form" class="sky-form bo-none" id="queryform" onsubmit="ApolloList.archiveSearch(<%--
                --%>'${archiveId}', <%--
                --%>'${search.stateParameters.resetAllFacetStates}&q='<%--
            --%>); <%--
            --%>return false;">

                    <c:set var="escapedQuery">${fn:replace(search.controller.common.state.query,'"','&quot;')}</c:set>
                    <input type="hidden" name="${search.controller.common.config.lastQueryParam}" value="${escapedQuery}" />
                    <input type="hidden" name="${search.controller.common.config.reloadedParam}" />
                    <label class="input">
                        <i class="icon-prepend fa fa-search"></i>
                        <input <%--
                        --%>name="${search.controller.common.config.queryParam}" <%--
                        --%>id="textsearch" <%--
                        --%>type="text" <%--
                        --%>value="${escapedQuery}" <%--
                        --%>placeholder="<fmt:message key="apollo.list.message.search" />">
                    </label>
            </form>
        </div>
    </c:if>

    <c:if test="${showCategories}">
        <div class="filterbox categories">

            <button type="button" <%--
            --%>class="btn btn-block li-label ${formatterSettings.catPreopened ? '' : 'collapsed'}" <%--
            --%>data-target="#cats_${archiveId}" <%--
            --%>aria-controls="cats_${archiveId}" <%--
            --%>aria-expanded="${formatterSettings.catPreopened}" <%--
            --%>data-toggle="collapse"><%--
            --%><fmt:message key="apollo.list.message.categories" /><%--
         --%></button>

            <div id="cats_${archiveId}" class="collapse${formatterSettings.catPreopened ? ' in' : ''}">
                <ul>
                    <%-- BEGIN: Calculate category filters --%>
                    <c:set var="catFilters"
                        value="${not empty formatterSettings.catfilters ? fn:replace(formatterSettings.catfilters,' ','') : ''}" />
                    <c:set var="blacklistFilter" value="true" />
                    <c:if test="${not empty catFilters}">
                        <c:if test="${fn:startsWith(catFilters,'whitelist:')}">
                            <c:set var="catFilters"
                                value="${fn:replace(catFilters,'whitelist:','')}" />
                            <c:set var="blacklistFilter" value="false" />
                        </c:if>
                        <c:set var="catFilters" value='${fn:split(catFilters, ",")}' />
                    </c:if>
                    <%-- END: Calculate category filters --%>

                    <%-- Read additional options (parameters) that influence the display of categories --%>
                    <c:set var="displayCatPath" value="${fn:toLowerCase(formatterSettings.catlabelfullpath) eq 'true'}" />
                    <c:set var="onlyLeafs" value="${fn:toLowerCase(formatterSettings.catshowonlyleafs) eq 'true'}" />

                    <c:set var="facetValues" value="${fieldFacetResult.values}" />
                    <c:forEach var="value" items="${facetValues}" varStatus="outerStatus">
                        <c:if test="${not onlyLeafs or outerStatus.last or not fn:startsWith(facetValues[outerStatus.count].name, value.name)}">
                            <c:set var="active">${fieldFacetController.state.isChecked[value.name] ? ' class="active"' : ''}</c:set>

                            <%-- BEGIN: Calculate category label --%>
                            <c:set var="catCompareLabel" value="" />
                            <c:set var="label" value="" />
                            <c:forEach var="category" items="${cms.readPathCategories[value.name]}" varStatus="status">
                                <c:if test="${displayCatPath or status.last}">
                                    <c:set var="label">${label}${category.title}</c:set>
                                    <c:set var="catId"><apollo:idgen prefix="cat" uuid="${category.id}" /></c:set>
                                </c:if>
                                <c:set var="catCompareLabel">${catCompareLabel}${category.title}</c:set>
                                <c:if test="${not status.last}">
                                    <c:if test="${displayCatPath}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
                                    <c:set var="catCompareLabel">${catCompareLabel}/</c:set>
                                </c:if>
                            </c:forEach>
                            <%-- END: Calculate category label --%>

                            <c:set var="catCompareLabel" value="${fn:replace(catCompareLabel,' ','')}" />
                            <c:set var="isMatchedByFilter" value="false" />
                            <c:forEach var="filterValue" items="${catFilters}" varStatus="status">
                                <c:if test="${isMatchedByFilter or fn:contains(catCompareLabel, filterValue)}">
                                    <c:set var="isMatchedByFilter" value="true" />
                                </c:if>
                            </c:forEach>

                            <c:if test="${blacklistFilter != isMatchedByFilter}">
                                <li id="${catId}" ${active}>
                                    <a onclick="ApolloList.archiveFilter(<%--
                                            --%>'${archiveId}', <%--
                                            --%>'${catId}', <%--
                                            --%>'${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[categoryFacetField][value.name]}'<%--
                                        --%>);">
                                        <span class="badge"><i class="fa fa-tag"></i> ${label} (${value.count})</span>
                                    </a>
                                </li>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>

    <c:if test="${showArchive}">
        <div class="filterbox archive">

            <button type="button" <%--
            --%>class="btn btn-block li-label ${formatterSettings.archivePreopened ? '' : 'collapsed'}" <%--
            --%>data-target="#arch_${archiveId}" <%--
            --%>aria-controls="arch_${archiveId}" <%--
            --%>aria-expanded="${formatterSettings.archivePreopened}" <%--
            --%>data-toggle="collapse"><%--
            --%><fmt:message key="apollo.list.message.archive" /><%--
        --%></button>

            <div id="arch_${archiveId}" class="collapse${formatterSettings.archivePreopened ? ' in' : ''}">

                <c:set var="archiveHtml" value="" />
                <c:set var="yearHtml" value="" />
                <c:set var="prevYear" value="-1" />

                <%-- get the current year --%>
                <jsp:useBean id="now" class="java.util.Date" />
                <c:set var="thisYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>

                <c:forEach var="facetItem" items="${rangeFacet.counts}" varStatus="status">
                    <c:set var="active">${rangeFacetController.state.isChecked[facetItem.value] ? ' class="active"' : ''}</c:set>
                    <fmt:parseDate var="fDate" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" value="${facetItem.value}"/>
                    <c:set var="currYear"><fmt:formatDate value="${fDate}" pattern="yyyy" /></c:set>
                    <c:set var="activeYear" value="${(not empty active) or (currYear eq thisYear)}" />
                    <c:if test="${prevYear != currYear}">
                        <%-- another year, generate year toggle button --%>
                        <c:if test="${not status.first}">
                            <%-- close month list of previous year --%>
                            <c:set var="yearHtml">${yearHtml}<c:out value='</ul>' escapeXml='false' /></c:set>
                        </c:if>
                        <c:set var="archiveHtml">${yearHtml}${archiveHtml}</c:set>
                        <c:set var="yearId">y_${currYear}_${archiveId}</c:set>
                        <c:set var="yearHtml">
                            <button type="button"<%--
                            --%>class="btn btn-xs btn-block year li-label ${activeYear ? '' : 'collapsed'}" <%--
                            --%>data-target="#${yearId}" <%--
                            --%>aria-controls="${yearId}" <%--
                            --%>aria-expanded="${activeYear}" <%--
                            --%>data-toggle="collapse"><%--
                            --%>${currYear}<%--
                        --%></button>
                            <c:set var="in" value="${activeYear ? 'in' : ''}" />
                            <c:out value='<ul class="year collapse ${in}" id="${yearId}">' escapeXml='false' />
                        </c:set>
                    </c:if>
                    <%-- add month list entry to current year --%>
                    <c:set var="currMonth"><fmt:formatDate value="${fDate}" pattern="MMM" /></c:set>
                    <c:set var="monthId">${yearId}${currMonth}</c:set>
                    <c:set var="yearHtml">
                        ${yearHtml}
                        <li id="${monthId}" ${active} onclick="ApolloList.archiveFilter(<%--
                                --%>'${archiveId}', <%--
                                --%>'${monthId}', <%--
                                --%>'${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[rangeFacetField][facetItem.value]}'<%--
                                --%>);" title="${facetItem.count}">
                            <a>${currMonth}</a>
                        </li>
                    </c:set>
                    <c:set var="prevYear" value="${currYear}" />
                </c:forEach>

                <%-- close month list of last year --%>
                <c:set var="archiveHtml">${yearHtml}<c:out value='</ul>' escapeXml='false' />${archiveHtml}</c:set>
                ${archiveHtml}
            </div> <%-- /ap-list-filter-archive --%>

        </div> <%-- /ap-list-filterbox-archive --%>
    </c:if>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
