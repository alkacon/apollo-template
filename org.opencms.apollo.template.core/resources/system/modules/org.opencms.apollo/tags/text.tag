<%@ tag 
    display-name="text"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Displays a text with optional link from the given content." %>


<%@ attribute name="text" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The text to format." %>

<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" 
    required="true" description="The link to show below the text. Must be a generic Apollo nested link content." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>  

<c:if test="${text.isSet || link.exists}">
    <div class="${cms.element.settings.tstyle}" <c:if test="${not link.exists}">${link.rdfaAttr}</c:if>>    
    <c:if test="${text.isSet}">
            <div ${text.rdfaAttr}>
                ${text}
            </div>
    </c:if>
    <c:if test="${link.exists}">
            <p ${link.rdfaAttr}>
                <apollo:link link="${link}" cssclass="btn btn-sm" settitle="false"/>
            </p>
    </c:if>
    </div>
</c:if>