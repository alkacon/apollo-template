<%@ tag display-name="copyright"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Formats a copyright text for further internal usage."%>


<%@ attribute name="text" type="java.lang.String" required="true" 
    description="The copyright text to format. Prepends a '(c)' if not already present." %>


<%@ variable name-given="copyright" scope="AT_END" declare="true" 
    description="The formatted copyright text result that is exported." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:if test="${not empty text}">
    <c:set var="copyrightSymbol">(c)</c:set>
    <c:set var="copyright">${fn:replace(text, '&copy;', copyrightSymbol)}</c:set>
    <c:if test="${not fn:contains(copyright, copyrightSymbol)}">
        <c:set var="copyright">${copyrightSymbol}${' '}${copyright}</c:set>
    </c:if>
</c:if>