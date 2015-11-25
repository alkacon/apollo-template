<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.main.OpenCms"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.xml.containerpage.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert">
					<fmt:message key="xmlimage.message.new" />
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<cms:include
						page="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)">
						<cms:param name="copyright">${value.Copyright}</cms:param>
					</cms:include>

					<c:set var="title">
						<cms:property name="Title"
							file="${fn:substringBefore(value.Image.stringValue, '?')}"
							default="" />
					</c:set>

					<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
					<c:if test="${cms.element.setting.cssClass.isSet}">
						<c:set var="cssClass"
							value="${cms.element.setting.cssClass.value}" />
					</c:if>

					<div class="${cssClass}" ${rdfa.Image}>
						<a
							data-gallery="<%=
						OpenCms.getModuleManager().getModule("org.opencms.apollo.template.formatters").getParameter("imageenlarge-gallery")						
						%>"
							class="zoomer"
							data-size="${cms.vfs.property[value.Image]['image.size']}"
							href="<cms:link>${value.Image}</cms:link>"
							title="<c:out value='${title} ${copyright}' escapeXml='false' />"
							data-rel="fancybox-button-${cms.element.instanceId}"
							${content.imageDnd['Image']}
							id="fancyboxzoom${cms.element.instanceId}"> <span
							class="overlay-zoom"> <img ${content.imageDnd['Image']}
								class="img-responsive ${cms.element.setting.cssShape}"
								alt="${title}"
								title="<c:out value='${title} ${copyright}' escapeXml='false' />"
								src="<cms:link>${value.Image}</cms:link>"> <span
								class="zoom-icon"></span>
						</span>
						</a>

					</div>
					<c:if
						test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
						<center>
							<div class="margin-bottom-20"></div>
							<p>
								<strong ${rdfa.Headline}>${value.Headline}</strong>
							</p>
						</center>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>

	</cms:formatter>
</cms:bundle>