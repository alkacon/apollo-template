<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.main.OpenCms"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/imagevariables.jsp:6d9929b8-9f5c-11e5-b3e7-0242ac11002b)"%>
		<c:choose>
			<c:when test="${not imgValParent.Image.isSet or not imgValParent.Image.value.Image.isSet}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>
			<c:otherwise>
				<div>

					<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
					<c:if test="${cms.element.setting.cssClass.isSet}">
						<c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
					</c:if>
					<div class="${cssClass}" ${imgValParent.Image.rdfa.Image}>
						<a
							data-gallery="<%=
						OpenCms.getModuleManager().getModule("org.opencms.apollo.template.formatters").getParameter("imageenlarge-gallery")						
						%>"
							class="zoomer"
							data-size="${cms.vfs.property[imgValParent.Image.value.Image]['image.size']}"
							href="<cms:link>${imgValParent.Image.value.Image}</cms:link>"
							title="${imgTitle}${' '}${imgCopyright}"
							data-rel="fancybox-button-${cms.element.instanceId}"
							id="fancyboxzoom${cms.element.instanceId}"> <span
							class="overlay-zoom"> <img ${content.imageDnd[imgValParent.Image.value.Image.path]}
								class="img-responsive ${cms.element.setting.cssShape}"
								alt="${imgTitle}${' '}${imgCopyright}"
								title="${imgTitle}${' '}${imgCopyright}"
								src="<cms:link>${imgValParent.Image.value.Image}</cms:link>"> <span
								class="zoom-icon"></span>
						</span>
						</a>
					</div>
					<c:if test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
						<center>
							<div class="margin-bottom-20"></div>
							<p>
								<strong ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</strong>
							</p>
						</center>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</cms:formatter>
</cms:bundle>