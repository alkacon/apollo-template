<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.flexible">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>
	
		<c:set var="textnew"><fmt:message key="apollo.flexible.message.edit" /></c:set>
		<c:set var="textedit"><fmt:message key="apollo.flexible.message.changed" /></c:set>
		<apollo:init-messages textnew="${textnew}" textedit="${textedit}">
			<c:if test="${not cms.element.settings.hideTitle}">
				<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
			</c:if>	
			${value.Code}
		</apollo:init-messages>
		
	</div>
</cms:formatter>

</cms:bundle>