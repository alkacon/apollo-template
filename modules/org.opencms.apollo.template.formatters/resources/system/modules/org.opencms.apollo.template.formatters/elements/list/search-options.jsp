<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="buttonColor" scope="request">${param.buttonColor}</c:set>
<c:if test="${empty fn:trim(buttonColor) }">
	<c:set var="buttonColor" scope="request">red</c:set>
</c:if>
<c:set var="showSort" scope="request">${param.showSort}</c:set>
<c:set var="showCategoryFilter" scope="request">${param.showCategoryFilter}</c:set>
<c:set var="solrParamType">fq=type:${cms.vfs.property[param.typesToCollect]['list.type']}</c:set>
<c:set var="solrParamDirs">&fq=parent-folders:${param.pathes}</c:set>
<c:set var="solrFilterQue">${param.extraQueries}</c:set>
<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}${param.extraQueries}</c:set>
<c:set var="categoryFacetField" scope="request">category_exact</c:set>
<c:set var="searchConfig" scope="request">
		{ "ignorequery" : true,
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
		  ],
		  "fieldfacets" : [
		  	{ "field" : "${categoryFacetField}", "label" : "facet.category.label", "order" : "index", "mincount" : 1 }
		  ],
		  pagenavlength: 5
		 }
</c:set>