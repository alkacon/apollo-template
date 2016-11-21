<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />

<cms:formatter var="content" val="value">
    <cms:bundle basename="org.opencms.apollo.template.job.messages">
        <c:set var="inMemoryMessage"><fmt:message key="apollo.job.message.inmemory" /></c:set>
    </cms:bundle>
    <apollo:init-messages textnew="${inMemoryMessage}">

        <c:set var="showImageLarge" value="${value.Introduction.value.Image.exists && (cms.element.settings.displayOption == 'largeImage')}" />
		<c:set var="showImageSmall" value="${value.Introduction.value.Image.exists && (cms.element.settings.displayOption == 'smallImage')}" />

		<c:choose>
			<c:when test="${showImageSmall}">
				<c:set var='divStart' value='<div class="col-sm-4 hidden-xs teaser-visual">' />
				<c:set var='divCenter' value='</div><div class="col-sm-8 teaser-body">' />
				<c:set var='divEnd' value='</div>' />
				<c:set var="animationClass" value="ap-kenburns-animation " />
			</c:when>
			<c:when test="${showImageLarge}">
				<c:set var='divStart' value='<div class="col-xs-12 teaser-visual">' />
				<c:set var='divCenter' value='</div><div class="col-xs-12 teaser-body">' />
				<c:set var='divEnd' value='</div>' />
			</c:when>
			<c:otherwise>
				<c:set var='divStart' value='' />
				<c:set var='divCenter' value='<div class="col-xs-12 teaser-body">' />
				<c:set var='divEnd' value='</div>' />
			</c:otherwise>
		</c:choose>

		<div class="row ap-event ${animationClass} ${cms.element.settings.cssWrapper}">
            <c:set var="paragraph" value="${content.valueList.Introduction['0']}" />
            <c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
            <c:set var="showDate" value="${cms.element.settings.showdate}" />

            <c:if test="${showImageSmall or showImageLarge}">
				<c:out value="${divStart}" escapeXml="false" />

				<c:set var="imgLink"><cms:link baseUri="${baseUri}">${content.filename}</cms:link></c:set>
				<a href="${imgLink}"><apollo:image-animated image="${value.Introduction.value.Image}" /></a>
			</c:if>

			<c:out value="${divCenter}" escapeXml="false" />

                <c:set var="href"><cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link></c:set>
                <c:set var="text">${content.value.Teaser}</c:set>
                <c:if test="${empty text}"><c:set var="text">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</c:set></c:if>

                <cms:bundle basename="org.opencms.apollo.template.formatters.list">
                    <apollo:teaserbody
                        text="${text}" 
                        textlength="${teaserLength}"
                        title="${content.value.Title}"
                        href="${href}" 
                        date="${content.value.Date}"
                        showdate="${showDate}"
                    />
                </cms:bundle>

            <c:out value="${divEnd}" escapeXml="false" />

        </div>
    </apollo:init-messages>     
</cms:formatter>
