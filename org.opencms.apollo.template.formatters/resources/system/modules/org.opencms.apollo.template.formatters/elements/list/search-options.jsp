<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="resType">${fn:substringBefore(param.typesToCollect, ":")}</c:set>

<c:set var="solrParamType">fq=type:${resType}</c:set>
<c:set var="solrParamCats"></c:set>
<c:if test="${not empty param.categoriesToCollect}">
	<c:forTokens items="${param.categoriesToCollect}" delims="," var="catPath" varStatus="status">
		<c:if test="${not status.first}"><c:set var="catFilter">${catFilter} OR </c:set></c:if>
		<c:set var="catFilter">${catFilter} "${catPath}"</c:set>
	</c:forTokens>
	<c:set var="solrParamCats">&fq=category:(${catFilter})</c:set>
</c:if>
<c:set var="solrFilterQue">${param.extraQueries}</c:set>
<c:set var="solrParamDirs">&fq=parent-folders:"${param.pathes}"</c:set>
<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}${solrParamCats}${solrFilterQue}</c:set>

{ "test": "${solrFilterQue}",
    "ignorequery" : true,
    <c:if test="${param.showExpired == 'true'}">
	    "ignoreExpirationDate" : true,
		"ignoreReleaseDate" : true,
	</c:if>
    "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
    "pagesize" : ${param.itemsPerPage}, 
    "sortoptions" : [
<c:choose>
	<c:when test='${param.sortOrder eq "asc"}'>	
		  		${sortOptionAsc},	  		
		  		${sortOptionDesc}
		  	</c:when>
	<c:otherwise>
				${sortOptionDesc},
		  		${sortOptionAsc}
		  	</c:otherwise>
</c:choose>
],"fieldfacets" : [ { "field" : "${categoryFacetField}", "label" :
"facet.category.label", "order" : "index", "mincount" : 1 } ],
pagenavlength: 5 }${param.pathes}