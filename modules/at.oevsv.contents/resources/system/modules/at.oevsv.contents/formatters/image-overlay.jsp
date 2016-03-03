<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
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

				<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
				<c:if test="${cms.element.setting.cssClass.isSet}">
					<c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
				</c:if>
				<div class="${cssClass} img-overlay" >
					<c:if test="${imgValParent.Link.isSet}">
						<a href="<cms:link>${imgValParent.Link.value.URI}</cms:link>">
					</c:if>
					<span ${imgValParent.Image.rdfa.Image}> <img 
						src="<cms:link>${imgValParent.Image.value.Image}</cms:link>"
						class="img-responsive"
						${content.imageDnd[imgValParent.Image.value.Image.path]} alt="${imgTitle}${' '}${imgCopyright}"
						title="${imgTitle}${' '}${imgCopyright}" />
					</span>
                    <span class="overlay overlay-${cms.element.setting.textbg.value}">${imgTitle}</span>
					<c:if test="${imgValParent.Link.isSet}">
						</a>
					</c:if>
					<c:choose>
						<c:when	test="${imgValParent.Image.value.Description.isSet and cms.element.setting.showtext.value == 'true'}">
							<p class="mt-10" ${imgValParent.Image.rdfa.Description}>${imgValParent.Image.value.Description}</p>
						</c:when>
						<c:when	test="${imgValParent.Text.isSet and cms.element.setting.showtext.value == 'true'}">
							<p class="mt-10" ${imgValParent.Text.rdfaAttr}>${imgValParent.Text}</p>
						</c:when>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
	</cms:formatter>
</cms:bundle>