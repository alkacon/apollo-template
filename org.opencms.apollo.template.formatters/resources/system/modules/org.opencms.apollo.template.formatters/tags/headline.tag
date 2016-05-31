<%@ tag 
    display-name="headline"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formates a headline from te given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<c:if test="${headline.isSet}">
    <c:set var="headSize">${setting.hsize.isSet ? setting.hsize : "h2"}</c:set>
    <c:set var="headStyle">${setting.hstyle.isSet ? setting.hstyle : "headline"}</c:set>
    <div class="${headStyle}">
        <${headSize}${' '}${headline.rdfaAttr}>${headline}</${headSize}>
    </div>
</c:if>
