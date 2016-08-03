<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.extensions.imagegallery">

	<%-- ####### Build search config JSON ############################################ --%>
	
	<c:set var="showTitle">${param.title}</c:set>
	<c:set var="solrParamType">fq=type:"image"</c:set>
	<c:set var="solrParamDirs">&fq=parent-folders:${param.path}</c:set>
	<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}&page=${param.page}&sort=path asc</c:set>
	<c:set var="searchConfig">
			{ "ignorequery" : true,
			  "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
			  pagesize: ${param.items}			  
			}
	</c:set>

	<%-- ####### Search and display the images ######################################## --%>
	
	<apollo:galleryitems config="${searchConfig}" css="${param.css}" count="${param.items}" page="${param.page}" />
	
</cms:bundle>