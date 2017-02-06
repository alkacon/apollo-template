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
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
<c:set var="teaserLength" value="${cms.element.settings.teaserLength}" />
<c:set var="showDate" value="${cms.element.settings.showDate}" />
<c:set var="baseUri" value="${cms.element.settings.pageUri}" />

<c:set var="showImageLarge" value="${paragraph.value.Image.exists && (cms.element.settings.displayOption == 'largeImage')}" />
<c:set var="showImageSmall" value="${paragraph.value.Image.exists && (cms.element.settings.displayOption == 'smallImage')}" />

<c:choose>
    <c:when test="${showImageSmall}">
        <c:set var='divStart' value='<div class="col-sm-4 hidden-xs teaser-visual">' />
        <c:set var='divCenter' value='</div><div class="col-sm-8 teaser-body">' />
        <c:set var='divEnd' value='</div>' />
        <c:set var="animationClass" value="${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}" />
    </c:when>
    <c:when test="${showImageLarge}">
        <c:set var='divStart' value='<div class="col-xs-12 teaser-visual">' />
        <c:set var='divCenter' value='</div><div class="col-xs-12 teaser-body">' />
        <c:set var='divEnd' value='</div>' />
        <c:set var="animationClass" value="${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}" />
    </c:when>
    <c:otherwise>
        <c:set var='divStart' value='' />
        <c:set var='divCenter' value='<div class="col-xs-12 teaser-body">' />
        <c:set var='divEnd' value='</div>' />
    </c:otherwise>
</c:choose>

<div class="row ap-teaser ap-blog-teaser ${animationClass}${' '}${cms.element.settings.cssWrapper}">

    <c:if test="${showImageSmall or showImageLarge}">
        <c:out value="${divStart}" escapeXml="false" />

        <c:set var="imgLink"><cms:link baseUri="${baseUri}">${content.filename}</cms:link></c:set>
        <a href="${imgLink}"><apollo:image-animated image="${paragraph.value.Image}" /></a>
    </c:if>

    <c:out value="${divCenter}" escapeXml="false" />

        <%--
        <c:set var="detailPage" value="/sites/default/apollo-demo/blog/article/" />
        --%>

        <c:set var="text">${content.value.Teaser}</c:set>
        <c:if test="${empty text}"><c:set var="text">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</c:set></c:if>
        <c:set var="href"><cms:link baseUri="${baseUri}" detailPage="${detailPage}">${content.filename}</cms:link></c:set>

        <apollo:teaserbody
            text="${text}"
            textlength="${teaserLength}"
            title="${content.value.Title}"
            href="${href}"
            date="${content.value.Date}"
            showdate="${showDate}"
        />

    <c:out value="${divEnd}" escapeXml="false" />
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>

