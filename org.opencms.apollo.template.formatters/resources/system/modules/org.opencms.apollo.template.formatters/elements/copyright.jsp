<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${not empty copyright}">
	<c:set var="copyrightSymbol">(c)</c:set>
	<c:set var="copyright">${fn:replace(copyright, '&copy;', copyrightSymbol)}</c:set>
	<c:if test="${not fn:contains(copyright, copyrightSymbol)}">
		<c:set var="copyright">${copyrightSymbol}${' '}${copyright}</c:set>
	</c:if>
</c:if>