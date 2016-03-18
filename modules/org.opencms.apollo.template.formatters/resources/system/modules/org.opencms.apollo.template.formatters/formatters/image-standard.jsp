<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<apollo:image-vars content="${content}">

		<c:choose>
			<c:when test="${not imgVal.Image.isSet or not imgVal.Image.value.Image.isSet}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>

			<c:otherwise>
				<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
				<c:if test="${cms.element.setting.cssClass.isSet}">
					<c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
				</c:if>
				<div class="${cssClass}" >
					<c:if test="${imgVal.Link.isSet}">
						<a href="<cms:link>${imgVal.Link.value.URI}</cms:link>">
					</c:if>
					<span ${imgVal.Image.rdfa.Image}> <img
						src="<cms:link>${imgVal.Image.value.Image}</cms:link>"
						class="img-responsive ${cms.element.setting.cssShape}"
						${content.imageDnd[imgVal.Image.value.Image.path]} alt="${imgTitle}${' '}${imgCopyright}"
						title="${imgTitle}${' '}${imgCopyright}" />
					</span>
					<c:if test="${imgVal.Link.isSet}">
						</a>
					</c:if>
					<c:choose>
						<c:when	test="${imgVal.Image.value.Description.isSet and cms.element.setting.showtext.value == 'true'}">
							<p class="mt-10" ${imgVal.Image.rdfa.Description}>${imgVal.Image.value.Description}</p>
						</c:when>
						<c:when	test="${imgVal.Image.value.Title.isSet and cms.element.setting.showtext.value == 'true'}">
							<p class="mt-10" ${imgVal.Image.rdfa.Title}>${imgVal.Image.value.Title}</p>
						</c:when>
						<c:when	test="${imgVal.Text.isSet and cms.element.setting.showtext.value == 'true'}">
							<p class="mt-10" ${imgVal.Text.rdfaAttr}>${imgVal.Text}</p>
						</c:when>
					</c:choose>
				</div>
			</c:otherwise>
		</c:choose>

	</apollo:image-vars>
	</cms:formatter>
</cms:bundle>
