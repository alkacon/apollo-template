<%@ tag 
    display-name="headline"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Displays a headline from the given content." %>


<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The headline to format." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:if test="${headline.isSet}">

    <c:set var="headSize">${not empty cms.element.settings.hsize ? cms.element.settings.hsize : "h2"}</c:set>
    <c:set var="headStyle" value="" />
    <c:set var="anchor" value="" />
    <c:choose>
        <c:when test="${empty cms.element.settings.hstyle}">
            <c:set var="headStyle">class="headline"</c:set>
        </c:when>
        <c:when test="${fn:startsWith(cms.element.settings.hstyle, '#')}">
            <c:set var="anchor"><a id="${fn:substringAfter(cms.element.settings.hstyle, '#')}" class="anchor"></a></c:set>
        </c:when>
        <c:otherwise>
            <c:set var="headStyle">class="${cms.element.settings.hstyle}" </c:set>
        </c:otherwise>
    </c:choose>

    <div ${headStyle}>${anchor}
        <${headSize}${' '}${headline.rdfaAttr}>${headline}</${headSize}>
    </div>
</c:if>
