<%@ tag display-name="gallerydata"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Generates a div with data-attributes and a list of images for use with PhotoSwipe."%>


<%@ attribute name="ajax" type="java.lang.String" required="true" 
    description="The path to the JSP that processes the AJAX call." %>

<%@ attribute name="path" type="java.lang.String" required="true" 
    description="The path to the images that will be shown." %>

<%@ attribute name="searchconf" type="java.lang.String" required="true" 
    description="The search configuration string used to find gallery elements." %>

<%@ attribute name="count" type="java.lang.String" required="true" 
    description="The amount of images that are appended to the gallery with every load cycle." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>


<c:set var="showtitle" value="${cms.element.setting.showTitle.value}" />
<c:set var="showcopyright" value="${cms.element.setting.showCopyright.value}" />

<div id="galleryData" class="col-xs-12" style="display:none;" 
    data-ajax="${ajax}" 
    data-css="${cms.element.settings.cssClass}" 
    data-showtitle="${showtitle}"
    data-showcopyright="${showcopyright}"
    data-path="${path}"
    data-autoload="${cms.element.setting.autoload}"
    data-count="${count}">
    <cms:search configString="${searchconf}" var="search">
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
