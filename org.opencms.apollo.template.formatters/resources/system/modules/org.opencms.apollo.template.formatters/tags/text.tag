<%@ tag 
    display-name="text"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a text with optional link from the given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="text" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>  

<c:if test="${text.isSet || link.exists}">
    <div class="${setting.tstyle}" <c:if test="${not link.exists}">${content.rdfa.Link}</c:if>>    
    <c:if test="${text.isSet}">
            <div ${text.rdfaAttr}>
                ${text}
            </div>
    </c:if>        
    <c:if test="${link.exists}">
            <p ${link.rdfaAttr}>
                <apollo:link link="${link}" linkclass="btn btn-sm" settitle="false"/>
            </p>
    </c:if>
    </div>
</c:if>