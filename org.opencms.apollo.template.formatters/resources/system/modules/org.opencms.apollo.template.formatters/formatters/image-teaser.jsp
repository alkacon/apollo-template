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

<c:choose>

	<c:when test="${empty imageLink}">
			<div class="alert">
					<fmt:message key="no.image" />
			</div>
	</c:when>

	<c:otherwise>
    
    
    <div class="thumbnails thumbnail-style thumbnail-kenburn">
        <div class="thumbnail-img">
            <div class="overflow-hidden">
                <img class="img-responsive" style="width:100%" src="/medien/78444eed-e072-41a5-8bcd-b31516b61071/bild-7-bildreportage-mutter-teresa.jpg?width=480&amp;quadratic=true" alt="Mutter Theresa" title="Mutter Theresa">
       		</div>
			<a target="_self" href="//bistumaachen.de/detailansicht/heiligsprechung-von-mutter-teresa/2a916161-bbe2-4fe0-8b19-f627b0c048bf?mode=detail" class="btn-more hover-effect">mehr +</a>										
		</div>
		<div class="info">
			<p class="copyright"><i>&copy; Karl-Heinz Melters / missio Aachen</i></p>
		</div>
		<div class="caption">
			<h3>
				<a target="_self" href="//bistumaachen.de/detailansicht/heiligsprechung-von-mutter-teresa/2a916161-bbe2-4fe0-8b19-f627b0c048bf?mode=detail">
                    Heiligsprechung von Mutter Teresa
				</a>
			</h3>
		</div>
		<p>
            Internetdossier der Deutschen Bischofskonferenz 
		</p>
	</div>

    <div class="ap-sec-imagebox %(settings.wrapperclass)">
        <apollo:link link="${value.Link}" linkclass="">
            <apollo:image-simple 
            setting="${cms.element.setting}"
            image="${content.value.Image}"
            headline="${content.value.Headline}" />
            <div class="ap-sec-imagebox-overlay">
                <div class="ap-sec-imagebox-title <c:if test="${cms.element.setting.titlecolor.isSet}">fc-${cms.element.setting.titlecolor}</c:if>" ${rdfa.Headline}>
                    ${value.Headline}
                </div>
                <div class="ap-sec-imagebox-icon <c:if test="${cms.element.setting.titlecolor.isSet}">fc-${cms.element.setting.titlecolor}</c:if>"><span class="fa fa-${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : 'arrow-right' }"></span></div>
                <div class="ap-sec-imagebox-text <c:if test="${cms.element.setting.textcolor.isSet}">fc-${cms.element.setting.textcolor}</c:if>" ${rdfa.Text}>
                    ${value.Text}
                </div>
            </div>
        </apollo:link>
    </div>

	</c:otherwise>

</c:choose>

</apollo:image-vars>
</cms:formatter>
</cms:bundle>
