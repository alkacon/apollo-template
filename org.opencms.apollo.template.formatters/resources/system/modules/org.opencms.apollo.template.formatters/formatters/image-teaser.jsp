<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">
<apollo:image-vars image="${value.Image}">

<div class="ap-image-teaser">

<c:choose>

	<c:when test="${empty imageLink}">
        <div class="alert">
            <fmt:message key="no.image" />
        </div>
	</c:when>

	<c:otherwise>
    
    
    <div class="thumbnails thumbnail-style thumbnail-kenburn thumbnail-border-hover <c:if test="${cms.element.settings.showShadow}">shadow-border</c:if>">
        <div class="thumbnail-img">
            <div class="overflow-hidden">
                <img src="<cms:link>${imageLink}</cms:link>" alt="${imageTitle}" title="${imageTitle}" class="img-responsive" />
       		</div>
			<apollo:link link="${value.Link}" linkclass="btn-more hover-effect" />									
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
	</div>

	</c:otherwise>

</c:choose>

</div>

</apollo:image-vars>
</cms:formatter>
</cms:bundle>
