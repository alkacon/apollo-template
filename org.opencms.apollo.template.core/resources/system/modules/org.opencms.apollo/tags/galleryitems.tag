<%@ tag display-name="galleryitems"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Searches for images and displays the results with provided searchconfig."%>

<%@ attribute name="config" type="java.lang.String" required="true" %>
<%@ attribute name="css" type="java.lang.String" required="true" %>
<%@ attribute name="count" type="java.lang.String" required="true" %>
<%@ attribute name="page" type="java.lang.String" required="true" %>
<%@ attribute name="showtitle" type="java.lang.Boolean" required="false" %>
<%@ attribute name="showcopyright" type="java.lang.Boolean" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<c:if test="${empty showtitle}"><c:set var="showtitle" value="false" /></c:if>

<cms:search configString="${config}" var="search">
	<c:choose>
		<c:when test="${search.numFound > 0 }">

			<c:if test="${search.numFound > count*(page-1)}">
				<c:forEach var="result" items="${search.searchResults}"	varStatus="status">
					
					<c:set var="image" value="${result.searchResource}" />
					<c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
					<apollo:copyright text="${fn:trim(result.fields['Copyright_dprop_s'])}" />
					<c:set var="imagesrc"><cms:link>${image.rootPath}</cms:link></c:set>
					<c:set var="titleEmpty">${empty title or not showtitle}</c:set>
					<c:set var="copyEmpty">${empty copyright or not showcopyright}</c:set>

					<div class="${css} comein zoom">
						<a class="content image-gallery" 
						   href="${imagesrc}" 
						   onclick="openGallery(event, ${status.index+count*(page-1)})" 
						   title="${not titleEmpty ? title : ''}${titleEmpty or copyEmpty  ? '' : ' '}${not copyEmpty ? copyright : ''}"> 
							<span class="ap-square-section" style="background-image:url('${imagesrc}');">
								<span class="zoom-overlay">
									<span class="zoom-icon">
										<i class="fa fa-search"></i>
									</span>
								</span>
							</span>
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
            <fmt:setLocale value="${cms.locale}" />
            <cms:bundle basename="org.opencms.apollo.template.schemas.imagegallery">
                <fmt:message key="apollo.imagegallery.message.empty" />
            </cms:bundle>
		</c:otherwise>
	</c:choose>
</cms:search>