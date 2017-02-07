<%@ tag
    display-name="image-animated-imgur"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Formates an image taken from the imgur server." %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The image to format. Must be a generic Apollo nested image content."%>

<%@ attribute name="cssclass" type="java.lang.String" required="false"
    description="CSS class added to the div tag surrounding the image."%>

<%@ attribute name="cssimage" type="java.lang.String" required="false"
    description="CSS class added directly to the generated image tag."%>

<%@ attribute name="test" type="java.lang.String" required="false"
    description="Can be used to defer the decision to actually create the markup around the body to the calling element.
    If not set or 'true', the markup from this tag is generated around the body of the tag.
    Otherwise everything is ignored and just the body of the tag is returned. "%>

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

<c:set var="imageLink">${image.value.Id}</c:set>
<c:set var="imageTitleCopyright">${image.value.Title}</c:set>
<c:set var="imageDesc">${image.value.Description}</c:set>
<c:set var="imageData">${image.value.Data}</c:set>

<c:if test="${(not empty imageLink) and (empty test or test)}">
    <c:set var="imagefound">true</c:set>

    <%-- ####### Animated image ####### --%>

    <div class="ap-image ${cssclass}">
        <div class="animated-box">
            <div class="image-outer-box">
                <img src="${imageLink}" class="img-responsive image-inner-box" >
            </div>

            <%-- ####### JSP body inserted here ######## --%>
            <jsp:doBody/>
            <%-- ####### /JSP body inserted here ######## --%>

        </div>
    </div>
</c:if>

<c:if test="${empty imagefound}">
    <c:if test="${empty test or test}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.section.messages">
            <div class="alert">
                <fmt:message key="apollo.section.message.noimage" />
            </div>
        </cms:bundle>
    </c:if>

    <%-- ####### JSP body inserted here ######## --%>
    <jsp:doBody/>
    <%-- ####### /JSP body inserted here ######## --%>
</c:if>

