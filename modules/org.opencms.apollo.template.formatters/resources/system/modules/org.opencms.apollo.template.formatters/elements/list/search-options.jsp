<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.file.*, org.opencms.relations.*, org.opencms.jsp.*, org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="resType">${fn:substringBefore(param.typesToCollect, ":")}</c:set>

<c:set var="solrParamType">fq=type:${resType}</c:set>
<c:set var="solrParamCats"></c:set>
<c:if test="${not empty param.categoriesToCollect}">
	<c:set var="firstCat" value="true" />
	<c:forTokens items="${param.categoriesToCollect}" delims="," var="catPath">
		<c:if test="${not firstCat}"><c:set var="catFilter">${catFilter} OR </c:set></c:if>
		<%
			CmsJspActionElement jsp = new CmsJspActionElement(pageContext, request, response);
			CmsObject cms = jsp.getCmsObject();
			String cPath = (String)pageContext.getAttribute("catPath");
			CmsCategory cat = CmsCategoryService.getInstance().getCategory(cms, cms.getRequestContext().addSiteRoot(cPath));
            pageContext.setAttribute("catPath", cat.getPath());
		%>
		<c:set var="catFilter">${catFilter} "${catPath}"</c:set>
		<c:set var="firstCat" value="false" />
	</c:forTokens>
	<c:set var="solrParamCats">&fq=category:(${catFilter})</c:set>
</c:if>
<c:set var="solrFilterQue">${param.extraQueries}</c:set>
<c:set var="solrParamDirs">&fq=parent-folders:"${param.pathes}"</c:set>
<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}${solrParamCats}${solrFilterQue}</c:set>

{ "test": "${solrFilterQue}",
    "ignorequery" : true, "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
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