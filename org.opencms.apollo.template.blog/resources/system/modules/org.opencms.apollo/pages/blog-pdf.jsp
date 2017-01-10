<%@page trimDirectiveWhitespaces="true" buffer="none" session="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">
<cms:contentload collector="singleFile" param="%(opencms.uri)" >
<cms:contentaccess var="content" />

<?xml version="1.0" encoding="${cms.requestContext.encoding}"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict //EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
<head>
<title>${content.value.Title}</title>
<c:set var="colortheme"><cms:property name="apollo.theme" file="search" default="red" /></c:set>
<c:if test="${not fn:startsWith(colortheme, '/')}">
    <c:set var="colortheme">/system/modules/org.opencms.apollo.theme/resources/css/style-${colortheme}.min.css</c:set>
</c:if>
<link rel="stylesheet" href="<cms:link>${colortheme}</cms:link>" />
</head>

<body>
<div class="blog-page">

    <div>
        <div class="headline">
            <h2>${content.value.Title}</h2>
        </div>
        <c:set var="author" value="${fn:trim(content.value.Author)}" />
        <c:if test="${author ne ''}">
            <div><i><fmt:message key="apollo.blog.message.by" />${' '}${author}</i></div>
        </c:if>
        <div>
            <small><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></small>
        </div>
    </div>

    <c:if test="${not content.readCategories.isEmpty}">
    <div class="mt-10">
        <ul class="list-unstyled list-inline blog-tags">
            <li>
            <c:forEach var="category" items="${content.readCategories.leafItems}" varStatus="status">
                <span class="label">${category.title}</span>
                <c:if test="${not status.last}"> </c:if>
            </c:forEach>
            </li>
        </ul>
    </div>
    </c:if>
</div>

<c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

    <div class="paragraph mt-20">

        <c:if test="${paragraph.value.Headline.isSet}">
            <h4>${paragraph.value.Headline}</h4>
        </c:if>

        <c:choose>
            <c:when test="${paragraph.value.Image.exists}">
                <div>
                    <apollo:image-simple image="${paragraph.value.Image}" width="400" />
                </div>
                <div class="mt-20">
                    ${paragraph.value.Text}
                </div>
                <c:if test="${paragraph.value.Link.exists}">
                    <button type="button">
                        <a href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a>
                    </button>
                </c:if>
            </c:when>

            <c:otherwise>
                <div>${paragraph.value.Text}</div>
                <c:if test="${paragraph.value.Link.exists}">
                    <p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
                </c:if>
            </c:otherwise>
        </c:choose>

    </div>

</c:forEach>

</body>
</html>

</cms:contentload>
</cms:bundle>
