<%@ tag 
    display-name="image-zoom"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Displays an image which zoom option." %>


<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The image to format. Must be a generic Apollo nested image content." %>

<%@ attribute name="cssclass" type="java.lang.String" required="false" 
    description="CSS class added to the div tag surrounding the image."%>

<%@ attribute name="cssimage" type="java.lang.String" required="false" 
    description="CSS class added directly to the generated image tag."%>


<%-- ####### These variables are actually set in the apollo:image-vars tag included ####### --%>
<%@ variable name-given="imageLink" declare="true" %>
<%@ variable name-given="imageUnscaledLink" declare="true" %>
<%@ variable name-given="imageCopyright" declare="true" %>
<%@ variable name-given="imageTitle" declare="true" %>
<%@ variable name-given="imageTitleCopyright" declare="true" %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<c:if test="${image.isSet}">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">
<c:set var="imagefound">true</c:set>

<div class="ap-image ${cssclass}">

    <%-- ####### always use originial image, discard all scaling parameters ######## --%>
    <a  class="zoom"
        href="<cms:link>${imageUnscaledLink}</cms:link>"
        data-gallery="true"
        data-size="${cms.vfs.property[imageUnscaledLink]['image.size']}"
        <c:if test="${not empty imageTitleCopyright}">
            data-title="${imageTitleCopyright}"
            title="${imageTitleCopyright}"
        </c:if>
    >
        <span class="zoom-overlay">
            <span ${image.value.Image.imageDndAttr}>
                <cms:img 
                    src="${imageLink}"
                    cssclass="img-responsive ${cssimage}"
                    alt="${imageTitleCopyright}"
                    title="${imageTitleCopyright}"
                />
            </span>
            <%-- ####### zoom icon cancels out shadow and border, only rounded corners remain ######## --%>
            <span class="zoom-icon ${cssimage}">
                <i class="fa fa-search"></i>
            </span>
        </span>

    </a>

</div>

</c:if>

</apollo:image-vars>
</c:if>

<c:if test="${empty imagefound}">

    <c:if test="${empty test or test}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.schemas.section">
            <div class="alert">
                <fmt:message key="apollo.section.message.noimage" />
            </div>
        </cms:bundle>
    </c:if>

</c:if>