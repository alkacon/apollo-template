<%@ tag
    display-name="image-kenburn"
    trimDirectiveWhitespaces="true"
    description="Formates an image with a Ken Burns effect" %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="imagestyle" type="java.lang.String" required="false" %>
<%@ attribute name="divstyle" type="java.lang.String" required="false" %>
<%@ attribute name="shadowanimation" type="java.lang.Boolean" required="false" %>
<%@ attribute name="imageanimation" type="java.lang.Boolean" required="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${image.isSet}">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">
<c:set var="imagefound">true</c:set>

<%-- ####### Kenburn image ######## --%>

<div class="thumbnails
    <c:if test='${imageanimation}'> thumbnail-kenburn</c:if>
    <c:if test='${shadowanimation}'> shadow-border</c:if> 
    <c:out value=' ${divstyle}'/>">
    
    <div <c:if test="${shadowanimation}">class="shadow-border-inner"</c:if>>

        <div class="ap-img-pic ${imagestyle} ${image.imageDndAttr}">
            <cms:img 
                src="${imageLink}"
                scaleColor="transparent"
                scaleType="0"
                cssclass="img-responsive"
                alt="${imageTitleCopyright}"
                title="${imageTitleCopyright}"
            />
        </div>

        <%-- ####### JSP body inserted here ######## --%>
        <jsp:doBody/>
        <%-- ####### JSP body inserted here ######## --%>

    </div>
</div>

</c:if>

</apollo:image-vars>
</c:if>

<c:if test="${empty imagefound}">
    <div class="alert">
        <fmt:message key="no.image" />
    </div>

    <%-- ####### JSP body inserted here ######## --%>
    <jsp:doBody/>
    <%-- ####### JSP body inserted here ######## --%>
</c:if>
    
