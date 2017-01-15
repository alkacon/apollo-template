<%@ tag display-name="imagegallery"
  trimDirectiveWhitespaces="true"
  body-content="empty"
  description="Displays an image gallery based on a content search."%>


<%@ attribute name="usecase" type="java.lang.String" required="true"
    description="The use case of the tag. Valid values are 'gallery' and 'item'." %>

<%@ attribute name="path" type="java.lang.String" required="true"
    description="The path to the images that will be shown." %>

<%@ attribute name="count" type="java.lang.String" required="true"
    description="The number of images loaded with one request." %>

<%@ attribute name="page" type="java.lang.String" required="true"
    description="The page to load. The 'count' parameter defines the page size." %>

<%@ attribute name="searchconfig" type="java.lang.String" required="false"
    description="The full search configuration for finding the gallery elements with the cms:search tag.
    If this is not provided, the 'path' attribute will be used to create a default search configuration." %>

<%@ attribute name="css" type="java.lang.String" required="false"
    description="Class attributes used in the wrapper of each image in the gallery." %>

<%@ attribute name="showtitle" type="java.lang.Boolean" required="false"
    description="Determines if the image title will be shown as tooltip and in the gallery-overlay." %>

<%@ attribute name="showcopyright" type="java.lang.Boolean" required="false"
    description="Determines if the copyright text will be shown as tooltip and in the gallery-overlay." %>



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
        "pagesize" : ${usecase == 'gallery' ? 500 : count}
    }
    </c:set>
</c:if>

<c:choose>
<c:when test="${usecase == 'gallery'}">

    <c:set var="showtitle" value="${cms.element.setting.showTitle.value}" />
    <c:set var="showcopyright" value="${cms.element.setting.showCopyright.value}" />
    <c:set var="ajaxLink">
        <cms:link>/system/modules/org.opencms.apollo/elements/imagegallery-ajax.jsp</cms:link>
    </c:set>

    <div id="imagegallery" class="ap-image-gallery clearfix">
        <div id="links"></div>
        <div class="spinner animated">
            <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
        </div>
        <button class="btn animated" id="more" data-page="1" >
            <fmt:message key="apollo.imagegallery.message.more" />
        </button>

        <div id="galleryData" class="col-xs-12" style="display:none;"
            data-ajax="${ajaxLink}"
            data-css="${cms.element.settings.cssClass}"
            data-showtitle="${showtitle}"
            data-showcopyright="${showcopyright}"
            data-path="${path}"
            data-autoload="${cms.element.setting.autoload}"
            data-count="${count}">

            <cms:search configString="${searchconfig}" var="search">
                <c:if test="${search.numFound > 0 }">
                    <ul>
                        <c:forEach var="result" items="${search.searchResults}"
                            varStatus="status">
                            <c:set var="image" value="${result.searchResource}" />
                            <c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
                            <c:set var="copyright">${fn:trim(result.fields['Copyright_dprop_s'])}</c:set>
                            <c:set var="titleEmpty">${empty title or not showtitle}</c:set>
                            <c:set var="copyEmpty">${empty copyright or not showcopyright}</c:set>
                            <apollo:copyright text="${copyright}" />

                            <c:set var="titletext" value="${titleEmpty ? '' : title}${copyEmpty or titleEmpty ? '' : ' '}${copyEmpty ? '' : copyright}" />
                            <li data-gallery="true"
                                data-size="${result.fields['image.size_dprop_s']}"
                                data-src="<cms:link>${image.rootPath}</cms:link>"
                                data-title="${titletext}"></li>
                        </c:forEach>
                    </ul>
                </c:if>
            </cms:search>
        </div>
    </div>

</c:when>
<c:when test="${usecase == 'item'}">

    <c:if test="${empty showtitle}"><c:set var="showtitle" value="false" /></c:if>

    <cms:search configString="${searchconfig}" var="search">
        <c:choose>

        <c:when test="${search.numFound > 0 }">

            <c:if test="${search.numFound > count*(page-1)}">
                <c:forEach var="result" items="${search.searchResults}" varStatus="status">

                    <c:set var="image" value="${result.searchResource}" />
                    <c:set var="title">${fn:trim(result.fields['Title_dprop_s'])}</c:set>
                    <apollo:copyright text="${fn:trim(result.fields['Copyright_dprop_s'])}" />
                    <c:set var="imagesrc"><cms:link>${image.rootPath}</cms:link></c:set>
                    <c:set var="titleEmpty">${empty title or not showtitle}</c:set>
                    <c:set var="copyEmpty">${empty copyright or not showcopyright}</c:set>

                    <div class="${css} comein zoom">
                        <a class="image-gallery"
                           href="${imagesrc}"
                           onclick="openGallery(event, ${status.index+count*(page-1)})"
                           title="${not titleEmpty ? title : ''}${titleEmpty or copyEmpty  ? '' : ' '}${not copyEmpty ? copyright : ''}">
                            <span class="content" style="background-image:url('${imagesrc}');">
                                <span class="zoom-overlay">
                                    <span class="zoom-icon">
                                        <i class="fa fa-search"></i>
                                    </span>
                                </span>
                            </span>
                        </a>
                    </div>
                </c:forEach>

                <%-- ####### If last results found, include stopper which disables loading ######## --%>
                <c:if test="${search.numFound <= count*page}">
                    <span class="hideMore" style="display: none;"></span>
                </c:if>

            </c:if>
        </c:when>

        <c:otherwise>
            <fmt:message key="apollo.imagegallery.message.empty" />
        </c:otherwise>

        </c:choose>
    </cms:search>

</c:when>
</c:choose>

</cms:bundle>
