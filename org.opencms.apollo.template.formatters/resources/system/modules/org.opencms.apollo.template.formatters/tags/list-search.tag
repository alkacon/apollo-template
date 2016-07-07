<%@tag display-name="list-search"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Triggers the archive search with the given filters"%>

<%@ attribute name="source" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="false" %>
<%@ attribute name="filterqueries" type="java.lang.String" required="false" %>
<%@ attribute name="count" type="java.lang.Integer" required="false" %>
<%@ attribute name="sortAsc" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showexpired" type="java.lang.Boolean" required="false" %>
 
<%@ variable name-given="search" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" %>
<%@ variable name-given="searchConfig" scope="AT_END" declare="true" %>

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
	<c:when test="${source.isSet}">
		<c:set var="folder">${source}</c:set>
		<c:if test="${not fn:startsWith(folder, '/shared/')}"><c:set var="folder">${cms.requestContext.siteRoot}${folder}</c:set></c:if>
	</c:when>
	<c:otherwise>
		<c:set var="folder">${cms.requestContext.siteRoot}${cms.subSitePath}</c:set>
	</c:otherwise>
</c:choose>
<c:set var="folderpath" value="${folder}" />

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
	<c:set var="solrCats">&fq=category:(${catFilter})</c:set>
</c:if>

<c:set var="solrFilterQue"></c:set>
<c:if test="${not empty filterqueries}">
	<c:set var="solrFilterQue">${filterqueries}</c:set>
</c:if>
<c:set var="extraSolrParams">${solrCats}${solrFilterQue}</c:set>
<c:set var="pageSize">100</c:set>
<c:if test="${not empty count}"><c:set var="pageSize">${count}</c:set></c:if>
<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>



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

	"querymodifier" : "content_en:%(query) OR content_de:%(query) OR spell:%(query) OR Title_prop:%(query)",
	"escapequerychars" : true,
	
	"extrasolrparams" : "fq=parent-folders:\"${folder}\"&fq=-type:image&fq=type:${resType}${fn:replace(extraSolrParams,'"','\\"')}",

	"pagesize" : ${pageSize},
	"pagenavlength" : 5,

	"sortoptions" : [
					<c:choose>
						<c:when test='${sortAsc}'>	
					  		${sortOptionAsc},	  		
					  		${sortOptionDesc}
					  	</c:when>
						<c:otherwise>
							${sortOptionDesc},
					  		${sortOptionAsc}
					  	</c:otherwise>
					</c:choose>,
					{ "label" : sorttitle.asc, "paramvalue" : "title_asc", "solrvalue" : "disptitle_${cms.locale}_s asc" },
					{ "label" : sorttitle.desc, "paramvalue" : "title_desc", "solrvalue" : "disptitle_${cms.locale}_s desc" }
					],

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
			"end" : "NOW/MONTH",
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
