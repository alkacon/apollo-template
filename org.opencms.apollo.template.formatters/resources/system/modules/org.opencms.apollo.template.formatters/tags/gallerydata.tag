<%@ tag display-name="gallerydata"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Generates a div with needed data-attributes and a list of all images paths and other data for use with the PhotoSwipe-Gallery."%>

<%@ attribute name="ajax" type="java.lang.String" required="true" %>
<%@ attribute name="path" type="java.lang.String" required="true" %>
<%@ attribute name="searchconf" type="java.lang.String" required="true" %>
<%@ attribute name="count" type="java.lang.String" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<div id="galleryData" class="col-xs-12" style="display:none;" 
	data-ajax="${ajax}" 
	data-css="${cms.element.settings.cssClass}" 
	data-showtitle="${cms.element.settings.showTitle}"
	data-path="${path}"
	data-autoload="${cms.element.settings.autoload}"
	data-count="${count}">
	<cms:search configString="${searchconf}" var="search">
		<c:if test="${search.numFound > 0 }">
			<ul>
				<c:forEach var="result" items="${search.searchResults}"
					varStatus="status">
					<c:set var="image" value="${result.searchResource}" />
					<c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
					<c:set var="copyright">${fn:trim(result.fields['Copyright_dprop_s'])}</c:set>
					<apollo:copyright text="${copyright}" />
					
					<c:set var="titletext" value="${title}${not empty title ? ' ' : ''}${copyright}" />
					<li data-gallery="true" 
						data-size="${result.fields['image.size_dprop_s']}" 
						data-src="<cms:link>${image.rootPath}</cms:link>"
						data-title="${titletext}"></li>
				</c:forEach>
			</ul>
		</c:if>
	</cms:search>
</div>
