<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />
<apollo:init-messages reload="true">

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.jsp-search-formatter">

<%-- get the search form object containing results and controller --%>
<cms:search var="search" configFile="${content.filename}" />
<%-- short cut to access the controllers --%>
<c:set var="controllers" value="${search.controller}" />
<%-- short cut to access the controller for common search settings --%>
<c:set var="common" value="${controllers.common}" />
<div class="ap-search">
    <%-- Uncomment the following div for debugging --%>
    <%-- <div>
        ${search.finalQuery}
    </div> --%>
    <!-- The search form -->
    <%-- search action: link to the current page --%>
    <form id="default-formatter-search-form" role="form" class="form-horizontal"
        action="<cms:link>${cms.requestContext.uri}</cms:link>">
        <%-- important: send this hidden field to have proper resetting of checked facet values and pagination --%>
        <c:set var="escapedQuery">${fn:replace(common.state.query,'"','&quot;')}</c:set>
        <input type="hidden" name="${common.config.lastQueryParam}"
            value="${escapedQuery}" />
        <input type="hidden" name="${common.config.reloadedParam}" />
        <%-- choose layout dependent on the presence of search options --%>
        <c:set var="hasSortOptions" value="${cms:getListSize(controllers.sorting.config.sortOptions) > 0}" />
        <c:set var="colWidthInput" value="${hasSortOptions?4:12}" />
        <div class="row">
            <div class="col-lg-${colWidthInput} col-md-${colWidthInput} col-sm-${colWidthInput} col-xs-12  ap-searchquerycol">
                <div class="input-group">
                    <input name="${common.config.queryParam}" class="form-control"
                        type="text" autocomplete="off" placeholder='<fmt:message key="form.enterquery" />'
                        value="${escapedQuery}" /> <span class="input-group-btn">
                        <button class="btn" type="submit"><fmt:message key="button.submit" /></button>
                    </span>
                </div>
            </div>
            <c:if test="${hasSortOptions}">
                <c:set var="sort" value="${controllers.sorting}" />
                <div class="col-lg-8 col-md-8 col-sm-8 col-xs-12 ap-searchsortcol">
                    <div class="input-group">
                        <%-- Display select box with sort options where the currently chosen option is selected --%>
                        <select name="${sort.config.sortParam}" class="form-control" onchange="submitSearchForm()">
                            <c:forEach var="option" items="${sort.config.sortOptions}">
                                <option value="${option.paramValue}"
                                    ${sort.state.checkSelected[option]?"selected":""}>${option.label}</option>
                            </c:forEach>
                        </select>
                        <%-- Another button to send the form - just to improve handling --%>
                        <span class="input-group-btn">
                            <button class="btn" type="submit"><fmt:message key="button.sort"/></button>
                        </span>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="row mt-20">
            <c:set var="hasFacets" value="${(cms:getListSize(search.fieldFacets) > 0) or (not empty search.facetQuery)}" />
            <c:if test="${hasFacets}">
                <%-- Facets --%>
                <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 ap-searchfacetcol">
                    <%-- Query facet --%>
                    <c:if test="${(not empty controllers.queryFacet) and (not empty search.facetQuery)}">
                        <c:set var="facetController" value="${controllers.queryFacet}" />
                        <div class="panel panel-default">
                            <div class="panel-heading">${facetController.config.label}</div>
                            <div class="panel-body">                
                                <c:forEach var="entry" items="${facetController.config.queryList}">
                                    <c:if test="${not empty search.facetQuery[entry.query]}">
                                        <div class="checkbox">
                                            <label> <input type="checkbox"
                                                name="${facetController.config.paramKey}"
                                                value="${entry.query}"
                                                onclick="submitsearch()"
                                                ${facetController.state.isChecked[entry.query]?"checked":""} />
                                                ${entry.label} (${search.facetQuery[entry.query]})
                                            </label>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>

                    <c:set var="fieldFacetControllers" value="${controllers.fieldFacets}" />
                    <c:forEach var="facet" items="${search.fieldFacets}">
                        <c:set var="facetController"
                            value="${fieldFacetControllers.fieldFacetController[facet.name]}" />
                        <c:if test="${cms:getListSize(facet.values) > 0}">
                            <div class="panel panel-default">
                                <c:set var="flabel"><fmt:message key="search.facet.${fn:toLowerCase(facetController.config.label)}" /></c:set>
                                <c:if test="${fn:contains(flabel, '???')}"><c:set var="flabel">${facetController.config.label}</c:set></c:if>
                                <div class="panel-heading">${flabel}</div>
                                <div class="panel-body">
                                    <c:forEach var="facetItem" items="${facet.values}">
                                        <c:choose>
                                            <c:when test='${facet.name eq "type"}'>
                                                <c:set var="itemName">${facetItem.name}</c:set>
                                                <c:choose>
                                                <c:when test='${itemName eq "containerpage"}'>
                                                    <c:set var="label"><fmt:message key="type.containerpage" /></c:set>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="label"><cms:label>fileicon.${itemName}</cms:label></c:set>
                                                </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:when test='${facet.name eq "category_exact"}'>
                                                <c:set var="label"></c:set>
                                                <c:forEach var="category" items="${cms.readPathCategories[facetItem.name]}" varStatus="status">
                                                    <c:set var="label">${label}${category.title}</c:set>
                                                    <c:if test="${not status.last}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="label" value="${facetItem.name}" />
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="checkbox">
                                            <label> <input type="checkbox"
                                                name="${facetController.config.paramKey}"
                                                value="${facetItem.name}"
                                                onclick="submitSearchForm()"
                                                ${facetController.state.isChecked[facetItem.name]?"checked":""} />
                                                ${label} (${facetItem.count})
                                            </label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <%-- Show option to show more facet entries --%>
                                <c:if test="${not empty facetController.config.limit && cms:getListSize(facet.values) ge facetController.config.limit}">
                                    <div class="panel-footer">
                                    <c:choose>
                                    <c:when test="${facetController.state.useLimit}">
                                        <a href="<cms:link>${cms.requestContext.uri}?${search.stateParameters.addIgnoreFacetLimit[facet.name]}</cms:link>"><fmt:message key="search.facet.link.more" /></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="<cms:link>${cms.requestContext.uri}?${search.stateParameters.removeIgnoreFacetLimit[facet.name]}</cms:link>"><fmt:message key="search.facet.link.less" /></a>
                                        <input type="hidden" name="${facetController.config.ignoreMaxParamKey}" />
                                    </c:otherwise>
                                    </c:choose>
                                    </div>
                                </c:if>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </c:if>
        <!-- Search results -->
            <c:set var="colWidthResults" value="${hasFacets?8:12}" />
            <div class="col-lg-${colWidthResults} col-md-${colWidthResults} col-sm-${colWidthResults} col-xs-12 ap-searchresultcol">
                <c:choose>
                    <c:when test="${not empty search.exception}">
                        <h3><fmt:message key="search.failed_0" /></h3>
                        <p>
                            <fmt:message key="query.compare_2">
                                <fmt:param>${common.state.query}</fmt:param>
                                <fmt:param>${search.finalQuery.query}</fmt:param>
                            </fmt:message>
                        </p>
                    </c:when>
                    <c:when test="${empty search.searchResults && empty search.exception}">
                        <c:choose>
                        <c:when test="${not empty controllers.didYouMean.config}" >
                            <c:set var="suggestion" value="${search.didYouMeanSuggestion}" />
                            <c:choose>
                            <c:when test="${controllers.didYouMean.config.collate && not empty search.didYouMeanCollated}">
                                <h3>
                                    <fmt:message key="results.didyoumean_1">
                                        <fmt:param><a href='<cms:link>${cms.requestContext.uri}?${search.stateParameters.newQuery[search.didYouMeanCollated]}</cms:link>'>${search.didYouMeanCollated}</a></fmt:param>
                                    </fmt:message>
                                </h3>
                            </c:when>
                            <c:when test="${not controllers.didYouMean.config.collate and not empty suggestion.alternatives and cms:getListSize(suggestion.alternatives) > 0}">
                                <h3><fmt:message key="results.didyoumean_0" /></h3>
                                <ul>
                                <c:forEach var="alternative" items="${suggestion.alternatives}" varStatus="status">
                                <li>
                                    <a href='<cms:link>${cms.requestContext.uri}?${search.stateParameters.newQuery[alternative]}</cms:link>'>${alternative} (${suggestion.alternativeFrequencies[status.index]})</a>
                                </li>
                                </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <h3><fmt:message key="results.noResult" /></h3>
                            </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <h3><fmt:message key="results.noResult" /></h3>                                                        
                        </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <h3>
                            <fmt:message key="result.heading"/>
                            <small>
                                <fmt:message key="result.info">
                                    <fmt:param value="${search.start}"/>
                                    <fmt:param value="${search.end}"/>
                                    <fmt:param value="${search.numFound}"/>
                                    <fmt:param value="${search.maxScore}"/>
                                </fmt:message>
                            </small>
                        </h3>
                        <hr />
                        <%-- show search results --%>
                        <c:forEach var="searchResult" items="${search.searchResults}">
                            <div class=" ap-searchresultlist">
                                <c:set var="localizedTitleField">title_${cms.locale}_s</c:set>
                                <c:set var="title">${searchResult.fields[localizedTitleField]}</c:set>
                                <c:if test="${empty title}">
                                <c:set var="title">${searchResult.fields["Title_prop"]}</c:set>
                                </c:if>
                                <h5><a href='<cms:link>${searchResult.fields["path"]}</cms:link>'>${title}</a></h5>
                                <p>
                                    <%-- if highlighting is returned - show it; otherwise show content_en (up to 250 characters) --%>
                                    <c:choose>
                                        <c:when test="${not empty search.highlighting and not empty common.state.query}">
                                            <%-- To avoid destroying the HTML, if the highlighted snippet contains unbalanced tag, use the htmlConverter for cleaning the HTML. --%>
                                            <c:set 
                                                var="highlightSnippet" 
                                                value='${
                                                    search.highlighting
                                                        [searchResult.fields["id"]]
                                                        [search.controller.highlighting.config.hightlightField]
                                                        [0]
                                                    }' 
                                            />
                                            <c:if test="${not empty highlightSnippet}">
                                                ${cms:repairHtml(highlightSnippet)} ...
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="localeContentField">content_${cms.locale}</c:set>
                                            ${cms:trimToSize(searchResult.fields[localeContentField], 250)}
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                            <hr />
                        </c:forEach>
                        <c:set var="onclickAction"><cms:link>${cms.requestContext.uri}?$(LINK)</cms:link></c:set>
                        <apollo:list-pagination 
                            search="${search}" 
                            singleStep="true"
                            onclickAction='window.location.href="${onclickAction}"'
                        />
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        var searchForm = document.forms["default-formatter-search-form"];
        function submitSearchForm() {
            searchForm.submit();
        }
    </script>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>