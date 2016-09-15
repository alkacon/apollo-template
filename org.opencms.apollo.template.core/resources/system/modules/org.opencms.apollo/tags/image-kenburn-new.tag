<%@ tag
    display-name="image-kenburn"
    trimDirectiveWhitespaces="true"
    description="Formates an image with a Ken Burns and / or shadow animation effect." %>
    <%-- See https://en.wikipedia.org/wiki/Ken_Burns" --%>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The image to format. Must be a generic Apollo nested image content."%>

<%@ attribute name="imagestyle" type="java.lang.String" required="false" 
    description="CSS class added directly to the generated image tag."%>

<%@ attribute name="divstyle" type="java.lang.String" required="false" 
    description="CSS class added to the div tag sourrounding the image."%>

<%@ attribute name="shadowanimation" type="java.lang.Boolean" required="false"
    description="If 'true' insert classes that generate a shadow zoom effect."%>

<%@ attribute name="imageanimation" type="java.lang.Boolean" required="false" 
    description="If 'true' insert classes that generate the 'Ken Burns' animation."%>

<%-- ####### These variables are actually set in the apollo:image-vars tag included ####### --%>
<%@ variable name-given="imageLink" declare="true" %>
<%@ variable name-given="imageUnscaledLink" declare="true" %>
<%@ variable name-given="imageCopyright" declare="true" %>
<%@ variable name-given="imageTitle" declare="true" %>
<%@ variable name-given="imageTitleCopyright" declare="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${image.isSet}">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">
<c:set var="imagefound">true</c:set>

<%-- ####### Animated image ####### --%>

<div class="thumbnails
    <c:if test='${imageanimation}'> thumbnail-kenburn</c:if>
    <c:if test='${shadowanimation}'> shadow-border</c:if> 
    <c:out value=' ${divstyle}'/>">

    <div <c:if test="${shadowanimation}">class="shadow-border-inner"</c:if>>

        <div class="ap-img-pic" ${image.value.Image.imageDndAttr}>
            <cms:img 
                src="${imageLink}"
                scaleColor="transparent"
                scaleType="0"
                cssclass="img-responsive ${imagestyle}"
                alt="${imageTitleCopyright}"
                title="${imageTitleCopyright}"
            />
        </div>

        <%-- ####### JSP body inserted here ######## --%>
        <jsp:doBody/>
        <%-- ####### /JSP body inserted here ######## --%>

    </div>
</div>

</c:if>

</apollo:image-vars>
</c:if>

<c:if test="${empty imagefound}">

    <fmt:setLocale value="${cms.locale}" />
    <cms:bundle basename="org.opencms.apollo.template.schemas.section">
        <div class="alert">
            <fmt:message key="apollo.section.message.noimage" />
        </div>
    </cms:bundle>

    <%-- ####### JSP body inserted here ######## --%>
    <jsp:doBody/>
    <%-- ####### /JSP body inserted here ######## --%>
</c:if>

