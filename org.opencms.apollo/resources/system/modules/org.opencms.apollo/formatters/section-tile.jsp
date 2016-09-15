<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:set var="textnew"><fmt:message key="apollo.section.message.new" /></c:set>
	<apollo:init-messages textnew="${textnew}">
		<apollo:image-vars image="${value.Image}">

		<c:set var="imageBg" value="" />
		<c:if test="${not empty imageLink}">
			<c:set var="imageLink"><cms:link>${imageLink}</cms:link></c:set>
			<c:set var="imageBg"> style="background-image:url('${imageLink}');"</c:set>
		</c:if>

		<div class="ap-square-section ${cms.element.parent.setting.cssHints}${' '}${cms.element.settings.wrapperclass}" ${imageBg}>
		<div class="ap-sq-square">
		<div class="ap-sq-table">
		<div class="ap-sq-cell">

			<c:if test="${value.Headline.isSet}">
				<h2 ${rdfa.Headline}>${value.Headline}</h2>
			</c:if>

			<c:if test="${value.Text.isSet}">
				<div <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
					<div ${rdfa.Text} ${not empty imageLink ? content.imageDnd[value.Image.value.Image.path] : ''}>
						${value.Text}
					</div>
					<c:if test="${value.Link.exists}">
						<p ${rdfa.Link}>
							<apollo:link link="${value.Link}" cssclass="btn btn-sm" settitle="false"/>
						</p>
					</c:if>
				</div>
			</c:if>   

		</div>
		</div>
		</div>
		</div>

		</apollo:image-vars>
	</apollo:init-messages>
</cms:formatter>
</cms:bundle>
