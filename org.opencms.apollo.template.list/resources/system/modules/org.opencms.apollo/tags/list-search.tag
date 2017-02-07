<%@tag
    display-name="list-search"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Generates the list search configuration and triggers the search."%>


<%@ attribute name="source" type="java.util.List" required="true"
    description="The directories (including subdirectories) from which the elements are read." %>

<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The type of elements, that will be used." %>

<%@ attribute name="sort" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="The sorting field from the XML content." %>

<%@ attribute name="subsite" type="java.lang.String" required="false"
    description="The subsite the current request comes from. Is needed for AJAX requests because of a then differing context." %>

<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="false"
     description="The categories field from the XML content." %>

<%@ attribute name="filterqueries" type="java.lang.String" required="false"
    description="The search filter queries." %>

<%@ attribute name="count" type="java.lang.Integer" required="false"
    description="The amount of elements per page." %>

<%@ attribute name="showexpired" type="java.lang.Boolean" required="false"
    description="Determines if expired elements will be shown when editing the page." %>


<%@ variable name-given="search" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.result.I_CmsSearchResultWrapper"
    description="The results of the search" %>

<%@ variable name-given="searchConfig" scope="AT_END" declare="true"
    description="The configuration string that was used in the search." %>

<%@ variable name-given="categoryPaths" scope="AT_END" declare="true" %>
<%@ variable name-given="categoryFacetField" scope="AT_END" declare="true" %>
<%@ variable name-given="rangeFacetField" scope="AT_END" declare="true" %>
<%@ variable name-given="fieldFacetController" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.controller.I_CmsSearchControllerFacetField" %>
<%@ variable name-given="fieldFacetResult" scope="AT_END" declare="true" variable-class="org.apache.solr.client.solrj.response.FacetField" %>
<%@ variable name-given="rangeFacetController" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.controller.I_CmsSearchControllerFacetRange" %>
<%@ variable name-given="rangeFacet" scope="AT_END" declare="true" variable-class="org.apache.solr.client.solrj.response.RangeFacet" %>
<%@ variable name-given="folderpath" scope="AT_END" declare="true" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="categoryFacetField">category_exact</c:set>
<c:set var="rangeFacetField">newsdate</c:set>

<%-- ####### Set folder in which to search for items ######## --%>
<c:choose>
    <c:when test="${not empty source}">
    	<c:set var="first" value="${true}" />
    	<c:set var="folderFilter"></c:set>
    	<c:forEach var="folder" items="${source}" varStatus="status">
			<c:set var="rootPath">${cms.vfs.resource[folder].rootPath}</c:set>
			<c:if test="${not empty rootPath}">
				<c:if test="${not status.first}">
					<c:set var="folderFilter">${folderFilter}${' OR '}</c:set>
				</c:if>
				<c:set var="folderFilter">${folderFilter}\"${rootPath}\"</c:set>
			</c:if>	
    	</c:forEach>
    </c:when>
    <c:otherwise>
        <c:set var="folderFilter">\"${cms.requestContext.siteRoot}${cms.subSitePath}\"</c:set>
        <c:if test="${not empty subsite}">
        	<c:set var="folderFilter">\"${subsite}\"</c:set>
        </c:if>
    </c:otherwise>
</c:choose>

<c:set var="resType">${fn:substringBefore(types, ":")}</c:set>
<c:set var="solrCats"></c:set>
<c:if test="${not empty categories && not categories.isEmpty}">
    <c:set var="categoryPaths"></c:set>
    <c:set var="catFilter"></c:set>
    <c:forEach var="category" items="${categories.leafItems}" varStatus="status">
        <c:set var="categoryPaths">${categoryPaths}${category.path}</c:set>
        <c:set var="catFilter">${catFilter}${category.path}</c:set>
        <c:if test="${not status.last}">
            <c:set var="categoryPaths">${categoryPaths},</c:set>
            <c:set var="catFilter">${catFilter}&nbsp;</c:set>
        </c:if>
    </c:forEach>
    <c:set var="solrCats">&fq=${categoryFacetField}:(${catFilter})</c:set>
</c:if>

<%-- ################################################################################################################# Sortoptions ######## --%>

<c:set var="sortdateasc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
<c:set var="sortdatedesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
<c:set var="sorttitleasc">{ "label" : sortorder.asc, "paramvalue" : "title_a", "solrvalue" : "disptitle_${cms.locale}_s asc" }</c:set>
<c:set var="sorttitledesc">{ "label" : sortorder.desc, "paramvalue" : "title_d", "solrvalue" : "disptitle_${cms.locale}_s desc" }</c:set>
<c:set var="sortorderasc">{ "label" : sortorder.asc, "paramvalue" : "order_a", "solrvalue" : "newsorder_${cms.locale}_i asc" }</c:set>
<c:set var="sortorderdesc">{ "label" : sortorder.desc, "paramvalue" : "order_d", "solrvalue" : "newsorder_${cms.locale}_i desc" }</c:set>

<c:choose>
    <c:when test="${fn:contains(sort, 'datedesc')}">
        <c:set var="sortoptions" value="${sortdatedesc},${sortdateasc},${sorttitleasc},${sorttitledesc},${sortorderasc},${sortorderdesc}" />
    </c:when>
    <c:when test="$fn:contains(sort, 'titleasc')}">
        <c:set var="sortoptions" value="${sorttitleasc},${sortdateasc},${sortdatedesc},${sorttitledesc},${sortorderasc},${sortorderdesc}" />
    </c:when>
    <c:when test="${fn:contains(sort, 'titledesc')}">
        <c:set var="sortoptions" value="${sorttitledesc},${sortdateasc},${sortdatedesc},${sorttitleasc},${sortorderasc},${sortorderdesc}" />
    </c:when>
    <c:when test="$fn:contains(sort, 'orderasc')}">
        <c:set var="sortoptions" value="${sortorderasc},${sortdateasc},${sortdatedesc},${sorttitleasc},${sorttitledesc},${sortorderdesc}" />
    </c:when>
    <c:when test="${fn:contains(sort, 'orderdesc')}">
        <c:set var="sortoptions" value="${sortorderdesc},${sortdatedesc},${sortdateasc},${sorttitleasc},${sorttitledesc},${sortorderasc}" />
    </c:when>
    <c:otherwise>
        <%-- ### Default: Sort by date asc ### --%>
        <c:set var="sortoptions" value="${sortdateasc},${sortdatedesc},${sorttitleasc},${sorttitledesc},${sortorderasc},${sortorderdesc}" />
    </c:otherwise>
</c:choose>

<%-- ################################################################################################################# END Sortoption ######## --%>

<c:set var="solrFilterQue"></c:set>
<c:if test="${not empty filterqueries}">
    <c:set var="solrFilterQue">${filterqueries}</c:set>
    <c:if test="${not fn:startsWith(solrFilterQue,'&')}">
    	<c:set var="solrFilterQue">&${solrFilterQue}</c:set>
	</c:if>    
</c:if>
<c:set var="extraSolrParams">${solrCats}${solrFilterQue}</c:set>
<c:set var="pageSize">100</c:set>
<c:if test="${not empty count}"><c:set var="pageSize">${count}</c:set></c:if>



<%-- ########################################### --%>
<%-- ####### Build search config JSON   ######## --%>
<%-- ########################################### --%>

<c:set var="searchConfig">
{
    "searchforemptyquery" : true,

<c:if test="${showexpired}">
    "ignoreExpirationDate" : true,
    "ignoreReleaseDate" : true,
</c:if>

    "querymodifier" : '{!type=edismax qf="content_${cms.locale} Title_prop spell"}%(query)',
    "escapequerychars" : true,

    "extrasolrparams" : "fq=parent-folders:(${folderFilter})&fq=-type:image&fq=type:${resType}${fn:replace(extraSolrParams,'"','\\"')}",

    "pagesize" : ${pageSize},
    "pagenavlength" : 5,

    "sortoptions" : [ ${sortoptions} ],

    "fieldfacets" : [
        {
            "field" : "${categoryFacetField}",
            "label" : "Category",
            "mincount" : 1,
            "limit" : 200,
            "order" : "index",
            "ignoreAllFacetFilters" : true
        }

    ],

    "rangefacets" : [
        {
            "range" : "newsdate_${cms.locale}_dt",
            "name" : "${rangeFacetField}",
            "label" : "Date",
            "start" : "NOW/YEAR-20YEARS",
            "end" : "NOW/MONTH+2YEARS",
            "gap" : "+1MONTHS",
            "mincount" : 1,
            "ignoreAllFacetFilters" : true
        }
    ]

}
</c:set>

<%-- ############################################# --%>
<%-- ####### Perform search based on JSON ######## --%>
<%-- ############################################# --%>
<cms:search configString="${searchConfig}" var="searchResultWrapper" addContentInfo="true" />

<c:set var="search" value="${searchResultWrapper}" />

<c:set var="fieldFacetController" value="${search.controller.fieldFacets.fieldFacetController[categoryFacetField]}" />
<c:set var="fieldFacetResult" value="${search.fieldFacet[categoryFacetField]}" />
<c:set var="rangeFacetController" value="${search.controller.rangeFacets.rangeFacetController[rangeFacetField]}" />
<c:set var="rangeFacet" value="${search.rangeFacet[rangeFacetField]}" />
