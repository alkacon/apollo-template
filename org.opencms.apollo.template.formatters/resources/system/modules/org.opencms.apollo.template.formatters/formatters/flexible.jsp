<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.flexible">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="apollo.flexible.message.edit" /></div>
		</c:when>
		<c:when test="${cms.element.settings.requireReload && cms.edited}">
			<div class="alert"><fmt:message key="apollo.flexible.message.changed" /></div>
			${cms.enableReload}
		</c:when>
		<c:otherwise>
			<c:if test="${not cms.element.settings.hideTitle}">
				<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
			</c:if>	
			${value.Code}
		</c:otherwise>
	</c:choose>
	</div>
</cms:formatter>

</cms:bundle>