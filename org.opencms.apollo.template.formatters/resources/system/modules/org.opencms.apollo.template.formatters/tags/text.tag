<%@ tag 
    display-name="text"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formates a text with optional link from te given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="text" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<c:if test="${text.isSet || link.exists}">
    <div class="${setting.tstyle}" <c:if test="${not link.exists}">${content.rdfa.Link}</c:if>>    
    <c:if test="${text.isSet}">
            <div ${text.rdfaAttr}>
                ${text}
            </div>
    </c:if>        
    <c:if test="${link.exists}">
            <p ${link.rdfaAttr}>
                <a
                    class="btn btn-sm" 
                    href="<cms:link>${link.value.URI}</cms:link>">
                        ${link.value.Text}
                </a>
            </p>
    </c:if>
    </div>
</c:if>