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

    <div class="ap-image-teaser">
        <apollo:image-kenburn-new
            image="${value.Image}"
            divstyle="thumbnail-style"
            shadowanimation="${cms.element.setting.showShadow.value}"
            imageanimation="${cms.element.setting.showKenburn.value}">

            <c:if test="${content.value.Link.isSet and cms.element.setting.ilink.value == 'image'}">
                <div class="thumbnail-kenburn">
                    <apollo:link 
                        link="${value.Link}" 
                        cssclass="btn-more hover-effect" />
                </div>
            </c:if>

            <c:if test="${cms.element.setting.showCopy.value and not empty imageCopyright}">
                <div class="info">
                    <p class="copyright"><i>${imageCopyright}</i></p>
                </div>
            </c:if>

            <c:if test="${cms.element.setting.itext.value == 'title'}">
                <div class="caption">
                    <h3>
                        <apollo:link link="${value.Link}">
                            ${value.Headline}
                        </apollo:link>
                    </h3>
                </div>
            </c:if>

        </apollo:image-kenburn-new>
    </div>

</apollo:init-messages>

</cms:formatter>
</cms:bundle>