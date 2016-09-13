<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:set var="inMemoryMessage"><fmt:message key="apollo.section.message.new" /></c:set>
	<apollo:init-messages textnew="${inMemoryMessage}">
		<apollo:image-vars image="${content.value.Image}">

			<c:choose>
				<c:when test="${empty imageLink}">
						<div class="alert">
								<fmt:message key="apollo.section.message.noimage" />
						</div>
				</c:when>
				<c:otherwise>
					<div class="ap-sec-imagebox %(settings.wrapperclass)">
						<apollo:link link="${value.Link}" linkclass="">
							<apollo:image-simple
							image="${content.value.Image}"
							headline="${content.value.Headline}" />
							<div class="ap-sec-imagebox-overlay">
								<div class="ap-sec-imagebox-title <c:if test="${cms.element.setting.titlecolor.isSet}">fc-${cms.element.setting.titlecolor}</c:if>" ${rdfa.Headline}>
									${value.Headline}
								</div>
								<div class="ap-sec-imagebox-icon <c:if test="${cms.element.setting.titlecolor.isSet}">fc-${cms.element.setting.titlecolor}</c:if>">
									<span class="fa fa-${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : 'arrow-right' }"></span>
								</div>
								<div class="ap-sec-imagebox-text <c:if test="${cms.element.setting.textcolor.isSet}">fc-${cms.element.setting.textcolor}</c:if>" ${rdfa.Text}>
									${value.Text}
								</div>
							</div>
						</apollo:link>
					</div>
				</c:otherwise>
			</c:choose>

		</apollo:image-vars>
	</apollo:init-messages>
</cms:formatter>
</cms:bundle>
