<%@ tag 
    display-name="image-vars"
    trimDirectiveWhitespaces="true" 
    description="Provides quick access to image values from XML"%>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="escapecopyright" type="java.lang.Boolean" required="false" %>

<%@ variable name-given="imageLink" declare="true" %>
<%@ variable name-given="imageUnscaledLink" declare="true" %>
<%@ variable name-given="imageCopyright" declare="true" %>
<%@ variable name-given="imageTitle" declare="true" %>
<%@ variable name-given="imageTitleCopyright" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${empty escapecopyright}"><c:set var="escapecopyright" value="true" /></c:if>

<c:set var="imageLink" value="" />
<c:set var="imageUnscaledLink" value="" />
<c:set var="imageCopyright" value="" />
<c:set var="imageTitle" value="" />
<c:set var="imageTitleCopyright" value="" />

<c:if test="${image.isSet && (image.value.Image.isSet or image.value.Uri.isSet)}">
<%-- We only initialize the other stuff if the image link is set --%>

    <c:set var="imageLink" value="${image.value.Image}" />
    <c:if test="${image.value.Uri.isSet}"><c:set var="imageLink" value="${image.value.Uri}" /></c:if>

    <c:set var="imageUnscaledLink">${imageLink}</c:set>
    <c:if test="${fn:contains(imageLink, '?')}">
        <c:set var="imageUnscaledLink">${fn:substringBefore(imageLink, '?')}</c:set>
    </c:if>

    <%--
        For the copyright, we check if this is set in the content first, 
        if not we try to read it from the property.
    --%>
    <c:choose>
        <c:when test="${image.value.Copyright.isSet}">
            <c:set var="imageCopyright">${image.value.Copyright}</c:set>
        </c:when>
        <c:otherwise>
            <c:set var="imageUri">${imageLink}</c:set>
            <c:if test="${fn:contains(imageUri, '?')}">
                <c:set var="imageUri">${fn:substringBefore(imageUri, '?')}</c:set>
            </c:if>
            <c:set var="imageCopyright"><cms:property name="Copyright" file="${imageUri}" default="" /></c:set>
        </c:otherwise>
    </c:choose>    

    <%--
        Set the image title from the dedicated field.
    --%>
    <c:if test="${image.value.Title.isSet}">
        <c:set var="imageTitle">${image.value.Title}</c:set>
        <c:set var="imageTitleCopyright">${imageTitle}</c:set>        
    </c:if>

    <%--
        Add copyright symbol. Make sure &copy; is replaced 
        with (c) since tooltips / title attributes have problems with HTML entities.
    --%>
    <c:if test="${not empty imageCopyright}">
        <c:choose>
            <c:when test="${escapecopyright}">
                <c:set var="imageCopyright">${fn:replace(imageCopyright, '&copy;', '(c)')}</c:set>
                <c:if test="${not fn:contains(imageCopyright, '(c)')}">
                    <c:set var="imageCopyright">${'(c)'}${' '}${imageCopyright}</c:set>
                </c:if>
            </c:when>
            <c:otherwise>
                <c:set var="imageCopyright">${fn:replace(imageCopyright, '(c)', '&copy;')}</c:set>
                <c:if test="${not fn:contains(imageCopyright, '&copy;')}">
                    <c:set var="imageCopyright">${'&copy;'}${' '}${imageCopyright}</c:set>
                </c:if>
            </c:otherwise>
        </c:choose>

        <c:set var="imageTitleCopyright">${imageTitle}${' '}${imageCopyright}</c:set>        
    </c:if>

</c:if>

<jsp:doBody/>