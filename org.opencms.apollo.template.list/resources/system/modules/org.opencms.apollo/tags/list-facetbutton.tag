<%@ tag display-name="list-facetbutton"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Generates a facet options dropdown button for the list" %>


<%@ attribute name="elementId" type="java.lang.String" required="false"
    description="The id of the list content element (UID of the list resource)." %>

<%@ attribute name="field" type="java.lang.String" required="true"
    description="The name of the solr index field that will be used." %>

<%@ attribute name="label" type="java.lang.String" required="false"
    description="The label that the button will show." %>

<%@ attribute name="color" type="java.lang.String" required="false"
    description="The color of the button." %>

<%@ attribute name="deselect" type="java.lang.String" required="false"
    description="The text on the deselection entry in the list." %>

<%@ attribute name="searchconfig" type="java.lang.String"
    required="false"
    description="The configuration string for the search tag." %>

<%@ attribute name="searchresult"
    type="org.opencms.jsp.search.result.I_CmsSearchResultWrapper"
    required="false"
    description="The result of a previous search tag usage." %>

<%@ attribute name="render" type="java.lang.Boolean" required="false"
    description="This boolean decides if the list items will be rendered directly or used through the listItems variable." %>


<%@ variable name-given="listItems" scope="AT_END" declare="true"
    description="Stores the resulting list items which can be used for custom facet lists." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<%-- ########################################### --%>
<%-- ####### Set needed variables       ######## --%>
<%-- ########################################### --%>

<c:set var="con" value="${cms.vfs.readXml[param.contentpath]}" />

<%-- ####### Merge the list parameters with the default formatter settings ######## --%>
<apollo:formatter-settings type="${con.value.TypesToCollect}"
    parameters="${con.valueList.Parameters}"
    online="${cms.isOnlineProject}" />

<%-- ####### Acquire search var ######## --%>
<c:choose>
    <c:when test="${not empty searchresult}">
        <c:set var="search" value="${searchresult}" />
    </c:when>
    <c:when test="${not empty searchconfig}">
        <cms:search configString="${searchconfig}" var="search"
            addContentInfo="true" />
    </c:when>
    <c:otherwise>
        <%-- If no search results or config given, set error flag --%>
        <c:set var="error" value="true" />
    </c:otherwise>
</c:choose>

<%-- ####### Set label for button ######## --%>
<c:set var="buttonLabel" value="${facetController.config.label}" />
<c:if test="${not empty label}">
    <c:set var="buttonLabel" value="${label}" />
</c:if>

<%-- ####### Set label for deselection item ######## --%>
<c:set var="deselectLabel" value="Show all" />
<c:if test="${not empty deselect}">
    <c:set var="deselectLabel" value="${deselect}" />
</c:if>

<c:set var="buttonColor" value="red" />
<c:if test="${not empty color}">
    <c:set var="buttonColor" value="${color}" />
</c:if>

<%-- ########################################### --%>
<%-- ####### Start processing button    ######## --%>
<%-- ########################################### --%>

<c:if test="${not error}">

    <c:set var="categoryFacetField" value="${field}" />
    <c:set var="facetController"
        value="${search.controller.fieldFacets.fieldFacetController[categoryFacetField]}" />
    <c:set var="facetResult"
        value="${search.fieldFacet[categoryFacetField]}" />
    <c:if
        test="${not empty facetResult and cms:getListSize(facetResult.values) > 0 || field == 'sort' }">

        <%-- ################################################################################################################# HEAD ######## --%>
        <c:set var="head">
            <c:out value='<div class="list-option btn-group">' escapeXml='false' />
            <button type="button" class="dropdown-toggle btn"
                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                id="dropdownMenu1" aria-expanded="true">
                <span class="pr-5">${buttonLabel}</span> <span
                    class="fa fa-chevron-down"></span>
            </button>

            <c:out
                value='<ul class="list-optionlist dropdown-menu dropdown-${buttonColor}">'
                escapeXml='false' />
        </c:set>

        <c:set var="delimiter" value="|" />

        <%-- ################################################################################################################# ITEMS ####### --%>
        <c:set var="items">

            <%-- ##### Default 'Show all' option ##### --%>
            <li ${cms:getListSize(facetController.state.checkedEntries) == 0?'class="active"' : ""}>
                <a href="javascript:void(0)" onclick="ApolloList.facetFilter(<%--
                    --%>'${elementId}', <%--
                    --%>null, <%--
                    --%>'${search.stateParameters.resetAllFacetStates.newQuery['']}')"><%--
                --%>${deselectLabel}</a>
            </li>${delimiter}

            <li role="separator" class="divider"></li>${delimiter}

            <%-- ####### Render category labels ######## --%>

            <%-- BEGIN: Calculate category filters --%>
            <c:set var="catFilters"
                value="${not empty formatterSettings.catfilters ? fn:replace(formatterSettings.catfilters,' ','') : ''}" />
            <c:set var="blacklistFilter" value="true" />
            <c:if test="${not empty catFilters}">
                <c:if test="${fn:startsWith(catFilters,'whitelist:')}">
                    <c:set var="catFilters"
                        value="${fn:replace(catFilters,'whitelist:','')}" />
                    <c:set var="blacklistFilter" value="false" />
                <c:set var="catFilters" value='${fn:split(catFilters, ",")}' />
                </c:if>
            </c:if>
            <%-- END: Calculate category filters --%>

            <%-- Read additional options (parameters) that influence the display of categories --%>
            <c:set var="displayCatPath" value="${fn:toLowerCase(formatterSettings.catlabelfullpath) eq 'true'}" />
            <c:set var="onlyLeafs" value="${fn:toLowerCase(formatterSettings.catshowonlyleafs) eq 'true'}" />

            <c:set var="facetValues" value="${facetResult.values}" />
            <c:forEach var="value" items="${facetValues}"
                varStatus="outerStatus">

                <c:if test="${not onlyLeafs or outerStatus.last or not fn:startsWith(facetValues[outerStatus.count].name, value.name)}">
                    <c:set var="selected">${facetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>

                    <%-- BEGIN: Calculate category label --%>
                    <c:set var="catCompareLabel"></c:set>
                    <c:set var="label"></c:set>
                    <c:forEach var="category"
                        items="${cms.readPathCategories[value.name]}" varStatus="status">
                        <c:if test="${displayCatPath or status.last}">
                            <c:set var="label">${label}${category.title}</c:set>
                            <c:set var="catId"><apollo:idgen prefix="cat" uuid="${category.id}" /></c:set>
                        </c:if>
                        <c:set var="catCompareLabel">${catCompareLabel}${category.title}</c:set>
                        <c:if test="${not status.last}">
                            <c:if test="${displayCatPath}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
                            <c:set var="catCompareLabel">${catCompareLabel} / </c:set>
                        </c:if>
                    </c:forEach>
                    <%-- END: Calculate category label --%>

                    <c:set var="catCompareLabel"
                        value="${fn:replace(catCompareLabel,' ','')}" />
                    <c:set var="isMatchedByFilter" value="false" />
                    <c:forEach var="filterValue" items="${catFilters}" varStatus="status">
                        <!-- Filter value: ${filterValue} -->
                        <c:if test="${isMatchedByFilter or fn:contains(catCompareLabel, filterValue)}">
                            <c:set var="isMatchedByFilter" value="true" />
                        </c:if>
                    </c:forEach>
                    <c:if test="${blacklistFilter != isMatchedByFilter}">
                        <li ${selected}>
                            <a href="javascript:void(0)" onclick="ApolloList.facetFilter(<%--
                                --%>'${elementId}', <%--
                                --%>'${catId}', <%--
                                --%>'${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[categoryFacetField][value.name]}')"><%--
                            --%>${label} (${value.count})</a>
                        </li>${delimiter}
                      </c:if>
                  </c:if>
            </c:forEach>

        </c:set>

        <%-- ################################################################################################################# FOOT ######## --%>
        <c:set var="foot">
            <c:out value='</ul>' escapeXml='false' />

            <c:out value='</div>' escapeXml='false' />
        </c:set>
    </c:if>

    <%-- ####### build list of list-items ######## --%>
    <c:set var="listItems" value="${items}" />

    <c:if test="${render != 'false'}">
        ${head}
        <c:forTokens items="${items}" delims="|" var="item">
            ${item}
        </c:forTokens>
        ${foot}
    </c:if>

</c:if>
