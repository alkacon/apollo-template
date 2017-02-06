<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />
<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.event.messages">

<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
<c:set var="teaserLength" value="${cms.element.settings.teaserLength}" />
<c:set var="showDate" value="${cms.element.settings.showDate}" />
<c:set var="baseUri" value="${cms.element.settings.pageUri}" />

<c:set var="showImageLarge" value="${paragraph.value.Image.exists and (cms.element.settings.displayOption == 'largeImage')}" />
<c:set var="showImageSmall" value="${paragraph.value.Image.exists and (cms.element.settings.displayOption == 'smallImage')}" />
<c:set var="showCalendar" value="${cms.element.settings.displayOption == 'showCalendar'}" />

<c:choose>
    <c:when test="${showImageSmall}">
        <c:set var='divStart' value='<div class="col-sm-4 hidden-xs teaser-visual">' />
        <c:set var='divCenter' value='</div><div class="col-sm-8 teaser-body">' />
        <c:set var='divEnd' value='</div>' />
        <c:set var="animationClass" value="${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}" />
    </c:when>
    <c:when test="${showCalendar}">
        <c:set var='divStart' value='<div class="fixcol-sm-125 hidden-xs teaser-visual">' />
        <c:set var='divCenter' value='</div><div class="col-xs-12 fixcol-sm-125-rest teaser-body">' />
        <c:set var='divEnd' value='</div>' />
        <c:set var="animationClass" value="ap-raise-animation " />
    </c:when>
    <c:otherwise>
        <c:set var='divStart' value='' />
        <c:set var='divCenter' value='<div class="col-xs-12 teaser-body">' />
        <c:set var='divEnd' value='</div>' />
        <c:set var="animationClass" value="${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}" />
    </c:otherwise>
</c:choose>

<div class="row ap-teaser ap-event-teaser ${animationClass}${' '}${cms.element.settings.cssWrapper}">

    <c:if test="${showImageSmall or showCalendar}">
        <c:out value="${divStart}" escapeXml="false" />
        <a class="link" href="<cms:link baseUri="${baseUri}">${content.filename}</cms:link>" >
            <c:choose>
                <%-- ####### Show small image ######## --%>
                <c:when test="${showImageSmall}">
                    <apollo:image-animated image="${paragraph.value.Image}" />
                </c:when>
                <%-- ####### Show calendar sheet ######## --%>
                <c:otherwise>
                    <div class="calendar-sheet animated-box">
                        <div class="day">
                            <fmt:formatDate value="${cms:convertDate(content.value.Date)}"
                                pattern="EEEE" type="date" />
                        </div>
                        <h3>
                            <fmt:formatDate value="${cms:convertDate(content.value.Date)}"
                                pattern="d" type="date" />
                        </h3>
                        <div class="monthYear">
                            <fmt:formatDate value="${cms:convertDate(content.value.Date)}"
                                pattern="MMM yyyy" type="date" />
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </a>
    </c:if>

    <c:out value="${divCenter}" escapeXml="false" />

        <c:if test="${showImageLarge}">
            <c:set var="imgLink"><cms:link baseUri="${baseUri}">${content.filename}</cms:link></c:set>
            <a href="${imgLink}" class="event-image"><apollo:image-animated image="${paragraph.value.Image}" /></a>
        </c:if>

        <c:set var="text">${content.value.Teaser}</c:set>
        <c:if test="${empty text}"><c:set var="text">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</c:set></c:if>
        <c:set var="href"><cms:link baseUri="${baseUri}">${content.filename}</cms:link></c:set>

        <apollo:teaserbody
            text="${text}"
            textlength="${teaserLength}"
            title="${content.value.Title}"
            href="${href}"
            date="${content.value.Date}"
            enddate="${content.value.EndDate}"
            showdate="${showDate}"
        />

    <c:out value="${divEnd}" escapeXml="false" />

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>