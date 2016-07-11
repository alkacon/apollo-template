<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" val="value" rdfa="rdfa">
	
	<div>${cms.reloadMarker}
		
		<%-- ####### Init messages wrapper ################################## --%>
		<c:set var="textnew"><fmt:message key="apollo.list.message.new" /></c:set>
		<c:set var="textedit"><fmt:message key="apollo.list.message.edit" /></c:set>
		<apollo:init-messages textnew="${textnew}" textedit="${textedit}">
		
			<%-- ####### List body (holds data for AJAX and gets inserts of list content) ######## --%>
			<apollo:list-body link="${value.Link}" headline="${value.Headline}" types="${value.TypesToCollect}" dynamic="true" />
			
		</apollo:init-messages>
		
	</div>
	</cms:formatter>
</cms:bundle>