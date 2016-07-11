<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" val="value" rdfa="rdfa">
	
		<div class="ap-list-content mb-20">
			<c:set var="textnew"><fmt:message key="apollo.list.message.new" /></c:set>
			<c:set var="textedit"><fmt:message key="apollo.list.message.edit" /></c:set>
			<apollo:init-messages textnew="${textnew}" textedit="${textedit}">
			
				<%-- ####### Headline ######## --%>
			
				<c:if test="${not cms.element.settings.hidetitle && value.Headline.isSet}">
					<div class="headline headline-md">
						<h2 ${rdfa.Headline}>
							<c:out value="${value.Headline}" escapeXml="false" />
						</h2>
					</div>
				</c:if>
		
				<%-- ####### List entries ######## --%>
		
				<apollo:list-main source="${value.Folder}" types="${value.TypesToCollect}" color="${param.buttonColor}" count="${value.ItemsPerPage.toInteger}" 
							showexpired="${cms.element.setting.showexpired.toBoolean}" teaserlength="${cms.element.settings.teaserlength}" showfacets="none" />
								
				<c:if test="${value.Link.exists}">
					<div class="mv-10"><apollo:link link="${value.Link}" linkclass="btn ap-btn-${cms.element.settings.buttoncolor} ap-btn-sm" settitle="false"/></div>
				</c:if>	
				
			</apollo:init-messages>
			
		</div>
		
	</cms:formatter>

</cms:bundle>
