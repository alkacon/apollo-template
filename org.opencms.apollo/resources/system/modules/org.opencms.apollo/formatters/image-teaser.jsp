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

    <div class="ap-section ap-image-teaser">

        <apollo:image-animated
            image="${value.Image}"
            cssclass="ap-button-animation"
            shadowanimation="${cms.element.setting.showShadow.value}"
            kenburnsanimation="${cms.element.setting.showKenburn.value}">

            <c:if test="${content.value.Link.isSet}">
                <div class="button-place-box">
                    <apollo:link 
                        link="${value.Link}" 
                        cssclass="btn btn-xs button-box" />
                </div>
            </c:if>

            <c:if test="${cms.element.setting.showCopy.value and not empty imageCopyright}">
                <div class="copyright">
                    <i>${imageCopyright}</i>
                </div>
            </c:if>

            <h3 class="subtitle">
                <apollo:link link="${value.Link}">
                    ${not empty imageTitle ? imageTitle : value.Headline}
                </apollo:link>
            </h3>

            <c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
            <c:set var="teaserText" value="${teaserLength > 0 ? cms:trimToSize(cms:stripHtml(value.Text), teaserLength) : value.Text}" />

            <c:if test="${not empty fn:trim(teaserText)}">
                <div class="text">
                    ${teaserText}
                </div>
            </c:if>

        </apollo:image-animated>
    </div>

</apollo:init-messages>

</cms:formatter>
</cms:bundle>