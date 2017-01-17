<%@ tag display-name="imagegallery"
  trimDirectiveWhitespaces="true"
  body-content="empty"
  description="Displays an image gallery based on a content search."%>

<%@ attribute name="id" type="java.lang.String" required="true"
    description="The id the image gallery should use, usually the UID of the element." %>

<%@ attribute name="path" type="java.lang.String" required="true"
    description="The path to the images that will be shown." %>

<%@ attribute name="count" type="java.lang.String" required="true"
    description="The number of images loaded with one request." %>

<%@ attribute name="page" type="java.lang.String" required="true"
    description="The page to load. The 'count' parameter defines the page size." %>

<%@ attribute name="css" type="java.lang.String" required="true"
    description="CSS to apply to each image in the gallery." %>

<%@ attribute name="searchconfig" type="java.lang.String" required="false"
    description="The full search configuration for finding the gallery elements with the cms:search tag.
    If this is not provided, the 'path' attribute will be used to create a default search configuration." %>

<%@ attribute name="showtitle" type="java.lang.Boolean" required="false"
    description="Determines if the image title will be shown as tooltip and in the gallery-overlay." %>

<%@ attribute name="showcopyright" type="java.lang.Boolean" required="false"
    description="Determines if the copyright text will be shown as tooltip and in the gallery-overlay." %>

<%@ attribute name="autoload" type="java.lang.Boolean" required="false"
    description="If 'false' each page will be loaded separately when the user clicks a button.
    If 'true', only the first page requires a click, subsequent pages are loaded automatically when scrolling down." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>


<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.imagegallery.messages">

<c:if test="${empty searchconfig}">
    <c:set var="extraSolrParams">fq=type:"image"&fq=parent-folders:"${path}"&page=${page}&sort=path asc</c:set>
    <c:set var="searchconfig">
    {
        "ignorequery" : true,
        "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
        "pagesize" : 500
    }
    </c:set>
</c:if>

<%-- Id must not have any "-" character --%>
<c:set var="id" value="imagegallery_${fn:replace(id, '-', '')}"/>

<c:set var="ajaxLink">
    <cms:link>/system/modules/org.opencms.apollo/elements/imagegallery-ajax.jsp</cms:link>
</c:set>

<c:set var="template">
    <div class="ap-square square-m-2 ${css} comein zoom">
        <a class="image-gallery" href="%(src)" title="%(titleAttr)">
            <span class="content" style="background-image:url('%(src)');">
                <span class="zoom-overlay">
                    <span class="zoom-icon">
                        <i class="fa fa-search"></i>
                    </span>
                </span>
            </span>
        </a>
    </div>
</c:set>

<div
    id="${id}"
    class="gallery"
    data-imagegallery='{
        "id": "${id}",
        "ajax": "${ajaxLink}",
        "css": "${css}",
        "showtitle": "${showtitle}",
        "showcopyright": "${showcopyright}",
        "path": "${path}",
        "autoload": "${autoload}",
        "count": "${count}",
        "template": "${cms:encode(template)}"
    }'>

    <div id="images" class="clearfix"></div>

    <div class="spinner">
        <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
    </div>

    <button class="btn btn-block" id="more">
        <fmt:message key="apollo.imagegallery.message.more" />
    </button>

    <div id="imagedata">
        <cms:search configString="${searchconfig}" var="search">
            <c:if test="${search.numFound > 0 }">
                <ul>
                    <c:forEach var="result" items="${search.searchResults}" varStatus="status">
                        <c:set var="src"><cms:link>${result.searchResource.rootPath}</cms:link></c:set>
                        <c:set var="size">${result.fields['image.size_dprop_s']}</c:set>

                        <c:set var="title">${showtitle ? fn:trim(result.fields['Title_dprop_s']) : ''}</c:set>
                        <c:set var="copyright">${showcopyright ? fn:trim(result.fields['Copyright_dprop_s']) : ''}</c:set>

                        <%-- Caption shown in gallery can contain HTML markup for formatting --%>
                        <c:set var="caption">
                            <c:if test="${not empty title}">
                                <div class="gtitle">${title}</div>
                            </c:if>
                            <c:if test="${not empty copyright}">
                                <div class="gcopyright">${copyright}</div>
                            </c:if>
                        </c:set>

                        <%-- Title attribute for a href tag can not contain any HTML markup--%>
                        <c:set var="titleAttr">
                            <apollo:copyright text="${copyright}"/>
                            <c:if test="${not empty title}">${title}</c:if>
                            <c:if test="${not empty title || not empty copyright}"> </c:if>
                            <c:if test="${not empty copyright}">${copyright}</c:if>
                        </c:set>

                        <li data-image='{<%--
                            --%>"src": "${src}",
                                "size": "${size}",
                                "caption": "${cms:encode(caption)}",
                                "titleAttr": "${cms:encode(titleAttr)}"<%--
                        --%>}' />
                    </c:forEach>
                </ul>
            </c:if>
        </cms:search>
    </div>

</div>

</cms:bundle>
