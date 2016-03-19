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
			<c:when test="${empty imageLink}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>

			<c:otherwise>

            <div class="ap-sec-one ${cms.element.setting.istyle}">
				<div class="ap-sec-img ${cms.element.setting.ieffect}">
					<span ${image.rdfa.Image} ${content.imageDnd[image.value.Image.path]}>
                    <img
						src="<cms:link>${imageLink}</cms:link>"
						class="img-responsive ${cms.element.setting.ieffect}"
                        alt="${imageTitle}${' '}${imageCopyright}"
						title="${imageTitle}${' '}${imageCopyright}" />
					</span>
				</div>
                <div class="ap-sec-img-txt">
                <c:if test="${cms.element.setting.showtext.value == 'true'}">
					<c:choose>
						<c:when	test="${image.value.Title.isSet}">
							<div class="ap-sec-img-tit" ${image.rdfa.Title}>${image.value.Title}</div>
						</c:when>
						<c:when	test="${content.value.Headline.isSet}">
							<div class="ap-sec-img-tit" ${content.rdfa.Headline}>${content.value.Headline}</div>
						</c:when>                        
					</c:choose>
                    <c:if test="${image.value.Description.isSet}">
						<div class="ap-sec-img-desc" ${image.rdfa.Description}>${image.value.Description}</div>
					</c:if>
                </c:if>
                </div>
            </div>

			</c:otherwise>
		</c:choose>

	</apollo:image-vars>
	</cms:formatter>
</cms:bundle>
