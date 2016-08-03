<%@ tag display-name="galleryitems"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Searches for images and displays the results with provided searchconfig."%>

<%@ attribute name="config" type="java.lang.String" required="true" %>
<%@ attribute name="css" type="java.lang.String" required="true" %>
<%@ attribute name="count" type="java.lang.String" required="true" %>
<%@ attribute name="page" type="java.lang.String" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:search configString="${config}" var="search">
	<c:choose>
		<c:when test="${search.numFound > 0 }">

			<c:if test="${search.numFound > count*(page-1)}">
				<c:forEach var="result" items="${search.searchResults}"	varStatus="status">
					
					<c:set var="image" value="${result.searchResource}" />
					<c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
					<apollo:copyright text="${fn:trim(result.fields['Copyright_dprop_s'])}" />
					<c:set var="imagesrc"><cms:link>${image.rootPath}</cms:link></c:set>

					<div class="${css} comein zoom">
						<a class="content image-gallery" 
						   href="${imagesrc}" 
						   onclick="openGallery(event, ${status.index+count*(page-1)})" 
						   title="${showTitle ? title : ''}${empty title or not showTitle ? '' : ' '}${copyright}" > 
							<div class="ap-square-section" style="background-image:url('${imagesrc}');">
								<div class="zoom-overlay">
									<div class="zoom-icon">
										<i class="fa fa-search"></i>
									</div>
								</div>
							</div>
						</a>
					</div>
				</c:forEach>
				
				<%-- ####### If last results found, include stopper which disables loading ######## --%>
				<c:if test="${search.numFound <= count*page}">
					<span class="hideMore" style="display: none;"></span>
				</c:if>
				
			</c:if>
		</c:when>
		<c:otherwise>
			<fmt:message key="website.imagegallery.message.empty" />
		</c:otherwise>
	</c:choose>
</cms:search>