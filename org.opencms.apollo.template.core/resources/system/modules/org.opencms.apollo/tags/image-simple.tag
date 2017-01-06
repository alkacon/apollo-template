<%@ tag 
    display-name="image-simple"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Displays a responsive image without effects." %>


<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The image to display. Must be a generic Apollo nested image content." %>

<%@ attribute name="title" type="java.lang.String" required="false" 
    description="The title to use for the image." %>

<%@ attribute name="width" type="java.lang.String" required="false" 
    description="The optional image width to use, will be added as attribute to the image tag." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<c:if test="${image.isSet}">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">

    <c:if test="${empty title}">
        <c:set var="title" value="${imageTitleCopyright}" />
    </c:if>

    <img
         src="<cms:link>${imageLink}</cms:link>"
         class="img-responsive"
         ${not empty width ? 'width="${width}"' : ''}
         alt="${title}"
         title="${title}"
    />

</c:if>

</apollo:image-vars>
</c:if>