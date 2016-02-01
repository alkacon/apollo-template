<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<%@include
			file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/image/xpath.jsp:6d9929b8-9f5c-11e5-b3e7-0242ac11002b)"%>

		<c:choose>
			<c:when test="${not value[xpath_image].isSet}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>
			<c:otherwise>
				<%@include
					file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/image/variables.jsp:e5da6ee0-a000-11e5-b3e7-0242ac11002b)"%>

				<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
				<c:if test="${cms.element.setting.cssClass.isSet}">
					<c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
				</c:if>
				<div class="${cssClass}" >
					<c:if test="${value.Link.isSet}">
						<a href="<cms:link>${value.Link}</cms:link>">
					</c:if>
					<span ${value_start.Image.rdfa.Image}> <img 
						src="<cms:link>${value_start.Image.value.Image}</cms:link>"
						class="img-responsive ${cms.element.setting.cssShape}"
						${content.imageDnd[xpath_image]} alt="${title} ${copyright}"
						title="<c:out value='${title}  ${copyright}' escapeXml='false' />" />
					</span>
					<c:if test="${image.Link.isSet}">
						</a>
					</c:if>
					<c:if
						test="${value_start.Image.value.Description.isSet and cms.element.setting.showtext.value == 'true'}">
						<p class="margin-top-10" ${value_start.Image.rdfa.Description}>${value_start.Image.value.Description}</p>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</cms:formatter>
</cms:bundle>