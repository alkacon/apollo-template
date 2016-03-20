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

    <div class="ap-img ${cms.element.setting.istyle}">
        
        <c:if test="${content.value.Link.isSet && cms.element.setting.ilink.value != 'none'}">
            <a href="<cms:link>${content.value.Link.value.URI}</cms:link>"
                <c:if test="${content.value.Link.value.Text.isSet}">
                title="${content.value.Link.value.Text}"
                </c:if>
            >
        </c:if>
            
        <div class="ap-img-pic ${cms.element.setting.ieffect != 'none' ? cms.element.setting.ieffect : ''}">
            <span ${image.rdfa.Image} ${content.imageDnd[image.value.Image.path]}>
                <img
                    src="<cms:link>${imageLink}</cms:link>"
                    class="img-responsive ${cms.element.setting.ieffect != 'none' ? cms.element.setting.ieffect : ''}"
                    alt="${imageTitle}${' '}${imageCopyright}"
                    title="${imageTitle}${' '}${imageCopyright}" 
                />
            </span>
        </div>
        
        <c:if test="${cms.element.setting.itext.value != 'none'}">
            <div class="ap-img-txt">
            <c:if test="${fn:contains(cms.element.setting.itext.value, 'title')}">
                <c:choose>
                    <c:when	test="${image.value.Title.isSet}">
                        <div class="ap-img-title" ${image.rdfa.Title}>${image.value.Title}</div>
                    </c:when>
                    <c:when	test="${content.value.Headline.isSet}">
                        <div class="ap-img-title" ${content.rdfa.Headline}>${content.value.Headline}</div>
                    </c:when>                        
                </c:choose>
            </c:if>
            <c:if test="${fn:contains(cms.element.setting.itext.value, 'desc') && image.value.Description.isSet}">
                <div class="ap-img-desc" ${image.rdfa.Description}>${image.value.Description}</div>
            </c:if>
            </div>
        </c:if>          

        <c:if test="${content.value.Link.isSet && cms.element.setting.ilink.value != 'none'}">
            </a>
        </c:if>
        
    </div>

    </c:otherwise>
    
</c:choose>

</apollo:image-vars>
</cms:formatter>
</cms:bundle>
