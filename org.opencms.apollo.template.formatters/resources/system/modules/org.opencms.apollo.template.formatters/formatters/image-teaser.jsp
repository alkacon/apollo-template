<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="ap-image-teaser">

    <apollo:image-kenburn-new
        image="${value.Image}"
        divstyle="thumbnail-style"
        shadowanimation="${cms.element.setting.showShadow.value}"
        imageanimation="false"
    >

    <div class="thumbnail-kenburn">
        <c:set var="linktext"><fmt:message key="apollo.link.frontend.more" /></c:set>
        <apollo:link link="${value.Link}" linkclass="btn-more hover-effect" linktext="${linktext}" />
    </div>
    
    <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">
        <div class="info">
            <p class="copyright"><i>${imageCopyright}</i></p>
        </div>
    </c:if>
    <div class="caption">
        <h3>
            <apollo:link link="${value.Link}">
                ${value.Headline}
            </apollo:link>
        </h3>
    </div>
    <p>
        <c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
        ${cms:trimToSize(cms:stripHtml(value.Text), teaserLength)}
    </p>

    </apollo:image-kenburn-new>

</div>

</cms:formatter>
</cms:bundle>
