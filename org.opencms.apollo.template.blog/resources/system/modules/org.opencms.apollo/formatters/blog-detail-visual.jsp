<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

<c:set var="partselection" value="${cms.element.setting.partselection}" />
<c:set var="showdate" value="${cms.element.setting.showdate.toBoolean and value.Date.isSet}" />
<c:set var="showauthor" value="${cms.element.setting.showauthor.toBoolean and value.Author.isSet}" />
<c:set var="imagecss" value="${cms.element.setting.ieffect}" />

<c:set var="paragraph0" value="${content.valueList.Paragraph['0']}" />
<c:set var="paragraph1" value="${content.valueList.Paragraph['1']}" />

<c:set var="showhead" value="${paragraph0.isSet and ((partselection == 'all') or (partselection == 'head'))}" />
<c:set var="showbody" value="${paragraph1.isSet and ((partselection == 'all') or (partselection == 'body'))}" />
<c:set var="showwarn" value="${not paragraph1.isSet and ((partselection == 'all') or (partselection == 'body'))}" />

<c:set var="showparallax" value="${cms.element.setting.showparallax.toBoolean}" />

<c:set var="fullScreenClass" value="${(cms.element.setting.wrapperclass == 'is-full-screen' &&  showparallax) ? 'container' : '' }" />
<c:set var="headonly" value="${showhead and not showbody}" />

<c:if test="${showdate}">
    <c:set var="date">
        <fmt:formatDate
            value="${cms:convertDate(value.Date)}"
            dateStyle="SHORT"
            timeStyle="SHORT"
            type="BOTH" />
    </c:set>
</c:if>

<div class="ap-detail-page ap-blog-page ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">
<c:if test="${showhead}">

    <div class="blog-visual">

        <c:choose>
        <c:when test="${showparallax}">
            <apollo:image-vars image="${paragraph0.value.Image}">
                <c:if test="${not empty imageLink}">
                <div class="visual-image parallax-background" data-parallax='{"effect":3}' style="background-image: url(${imageUrl})">
                    <div class="visual-overlay">
                        <h1 ${content.value.Title.rdfaAttr}>${content.value.Title}</h1>
                        <c:if test="${paragraph0.value.Headline.isSet}">
                            <h2 ${paragraph0.rdfa.Headline}>${paragraph0.value.Headline}</h2>
                        </c:if>
                    </div>
                </div>
                </c:if>
            </apollo:image-vars>
        </c:when>
        <c:otherwise>
            <apollo:image-animated image="${paragraph0.value.Image}" cssclass="visual-image ${imagecss}">
                <div class="visual-overlay">
                    <div class="spacer"></div>
                    <h1>${content.value.Title}</h1>
                    <c:if test="${paragraph0.value.Headline.isSet}">
                        <h2 ${paragraph0.rdfa.Headline}>${paragraph0.value.Headline}</h2>
                    </c:if>
                </div>
            </apollo:image-animated>
        </c:otherwise>
        </c:choose>

        <c:if test="${showdate or showauthor}">
            <div class="visual-info clearfix ${fullScreenClass}">
                <c:if test="${showauthor}"><span class="author" ${value.Author.rdfaAttr}>${value.Author}</span></c:if>
                <c:if test="${showdate}"><span class="date">${date}</span></c:if>
            </div>
        </c:if>

        <c:set var="leadText" value="${paragraph0.value.Text}" />
        <c:if test="${leadText.isSet}">
            <div class="visual-text ${fullScreenClass}">
                <span ${leadText.rdfaAttr}>${leadText}</span>
            </div>
        </c:if>
    </div>

</c:if>
<c:if test="${showbody}">

    <c:set var="imgalign" value="${cms.element.setting.imgalign}" />
    <c:set var="editblogpage">${cms.subSitePath}blog/post-a-new-blog-entry/</c:set>

    <div class="ap-blog-content">

        <c:if test="${not showhead and (showdate or showauthor)}">
            <div class="visual-info clearfix">
                <c:if test="${showauthor}"><span class="author" ${value.Author.rdfaAttr}>${value.Author}</span></c:if>
                <c:if test="${showdate}"><span class="date">${date}</span></c:if>
            </div>
        </c:if>

        <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
            <c:if test="${not status.first}">
                <apollo:paragraph
                    showimage="true"
                    imagecss="${imagecss}"
                    imgalign="${imgalign}"
                    paragraph="${paragraph}"
                />
            </c:if>
        </c:forEach>

        <c:if test="${content.isEditable and cms.vfs.existsResource[editblogpage]}">
            <a href="<cms:link>${editblogpage}</cms:link>?fileId=${content.id}">
                <button type="button" class="btn btn-default">Edit this blog entry</button>
            </a>
        </c:if>
    </div>

</c:if>
<c:if test="${cms.isEditMode and showwarn}">

        <fmt:setLocale value="${cms.workplaceLocale}" />
        <cms:bundle basename="org.opencms.apollo.template.core.messages">
        <div id="ap-edit-info" class="box-warn animated fadeIn">
            <div class="head">
                 <fmt:message key="apollo.core.warn.paragraphs" />
            </div>
            <div class="text">
                 <div class="main"><fmt:message key="apollo.core.warn.paragraphs.hint" /></div>
                 <div class="small"><fmt:message key="apollo.core.warn.notonline" /></div>
            </div>
        </div>
        </cms:bundle>

</c:if>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
