<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">
<apollo:image-vars image="${content.value.Image}">

<c:set var="imageBg" value="" />
<c:if test="${not empty imageLink}">
    <c:set var="imageLink"><cms:link>${imageLink}</cms:link></c:set>
    <c:set var="imageBg"> style="background-image:url('${imageLink}');"</c:set>
</c:if>

<div class="ap-square-section ${cms.element.parent.setting.cssHints}${' '}${cms.element.settings.wrapperclass}" ${imageBg}>
<div class="ap-sq-square">
<div class="ap-sq-table">
<div class="ap-sq-cell">

    <c:if test="${content.value.Headline.isSet}">
        <h2 ${content.rdfa.Headline}>${content.value.Headline}</h2>
    </c:if>
    
    <c:if test="${content.value.Text.isSet}">
        <div <c:if test="${not content.value.Link.exists}">${content.rdfa.Link}</c:if>>
            <div ${content.rdfa.Text} ${not empty imageLink ? content.imageDnd[image.value.Image.path] : ''}>
                ${content.value.Text}
            </div>
            <c:if test="${content.value.Link.exists}">
                <p ${content.rdfa.Link}>
                    <a
                        class="btn btn-sm" 
                        href="<cms:link>${content.value.Link.value.URI}</cms:link>">
                            ${content.value.Link.value.Text}
                    </a>
                </p>
            </c:if>
        </div>
    </c:if>   

</div>
</div>
</div>
</div>

</apollo:image-vars>
</cms:formatter>
</cms:bundle>
