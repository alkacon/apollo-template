<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">
<cms:formatter var="content" val="value">

<c:set var="inMemoryMessage"><fmt:message key="apollo.blog.message.edit" /></c:set>
<apollo:init-messages textnew="${inMemoryMessage}">

<div class="ap-detail-page ap-blog-page ap-blog-visual">

    <c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
    <c:set var="showImage" value="${paragraph.value.Image.exists}" />

    <c:if test="${showImage}">

        <apollo:image-vars image="${paragraph.value.Image}">

        <c:if test="${not empty imageLink}">

            <div class="ap-blog-visual-image" style="background-image: url(${imageUrl})">
                <h1>${content.value.Title}</h1>
                <c:if test="${paragraph.value.Headline.isSet}">
                    <h2 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h2>
                </c:if>
            </div>
        </c:if>

        </apollo:image-vars>
        <div class="container ap-blog-visual-text" ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
    </c:if>
</div>

</apollo:init-messages>
</cms:formatter>
</cms:bundle>