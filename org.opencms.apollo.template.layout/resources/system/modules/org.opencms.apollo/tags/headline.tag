<%@ tag 
    display-name="headline"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formates a headline from te given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${headline.isSet}">

    <c:set var="headSize">${setting.hsize.isSet ? setting.hsize : "h2"}</c:set>
    <c:set var="headStyle" value="" />
    <c:set var="anchor" value="" />
    <c:choose>
        <c:when test="${! setting.hstyle.isSet}">
            <c:set var="headStyle">class="headline"</c:set>
        </c:when>
        <c:when test="${fn:startsWith(setting.hstyle, '#')}">
            <c:set var="anchor"><a id="${fn:substringAfter(setting.hstyle, '#')}" class="anchor"></a></c:set>
        </c:when>
        <c:otherwise>
            <c:set var="headStyle">class="${setting.hstyle}" </c:set>
        </c:otherwise>
    </c:choose>
    
    <div ${headStyle}>${anchor}
        <${headSize}${' '}${headline.rdfaAttr}>${headline}</${headSize}>
    </div>
</c:if>
