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

<div class="ap-detail-page ap-blog-page blog-visual">

    <c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
    <c:set var="showImage" value="${paragraph.value.Image.exists}" />

    <c:if test="${showImage}">

        <apollo:image-vars image="${paragraph.value.Image}">

        <c:if test="${not empty imageLink}">
            <div class="visual-image parallax-background" data-parallax='{"effect":2}' style="background-image: url(${imageUrl})">
                <div class="visual-overlay">
                    <h1>${content.value.Title}</h1>
                    <c:if test="${paragraph.value.Headline.isSet}">
                        <h2 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h2>
                    </c:if>
                </div>
            </div>
        </c:if>

        </apollo:image-vars>
        <div class="container visual-text" ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
    </c:if>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>