<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="cssClass">${param.css}</c:set>

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
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.extensions.imagegallery">
	<cms:search configString="${searchConfig}" var="search">
		<c:choose>
			<c:when test="${search.numFound > 0 }">

				<c:if
					test="${search.numFound >= param.items*param.page or (search.numFound - (param.items*param.page-1) < param.items and search.numFound - (param.items*(param.page-1)) > 0)}">
					<c:forEach var="result" items="${search.searchResults}"
						varStatus="status">
						
						<c:set var="image" value="${result.searchResource}" />
						<c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
						<c:set var="imagesrc">${image.rootPath}</c:set>

						<c:set var="imgsrclink">
							<cms:link>${imagesrc}</cms:link>
						</c:set>
                        
                        <div class="${cssClass} comein zoom">
                            <a class="content image-gallery" 
                               href="${imgsrclink}" 
                               onclick="openGallery(event, ${status.index+param.items*(param.page-1)})" 
                               title="${showTitle eq 'true' ? title:''}" > 
                                <div class="ap-square-section" style="background-image:url('${imgsrclink}');">
                                    <div class="zoom-overlay">
                                        <div class="zoom-icon">
                                            <i class="fa fa-search"></i>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
					</c:forEach>
					<c:if
						test="${search.numFound < param.items*(param.page+1) and (search.numFound - (param.items*param.page) < 0)}">
						<span class="hideMore" style="display: none;"></span>

					</c:if>
				</c:if>
			</c:when>
			<c:otherwise>
				<fmt:message key="website.imagegallery.message.empty" />
			</c:otherwise>
		</c:choose>
	</cms:search>
</cms:bundle>