<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:set var="cssID">${param.cssID}</c:set>
		
		<cms:contentload collector="singleFile" param="${param.contentpath}">
			<cms:contentinfo var="info" />
			<c:if test="${info.resultSize > 0}">
				<cms:contentaccess var="content" />
				
				<%-- ####### Simple list with facets ######## --%>
				<apollo:list-simple source="${content.value.Folder}" types="${content.value.TypesToCollect}" color="${param.buttonColor}"
									count="${content.value.ItemsPerPage.toInteger}" showexpired="${param.showexpired == 'true'}" 
									teaserlength="${param.teaserlength}" categories="${content.readCategories}" showfacets="true" />
									
				<%-- ####### Load pagination (dynamic or normal) ######## --%>
				<c:set var="label"><fmt:message key="pagination.next"/></c:set>
				<c:set var="arialabel"><fmt:message key="pagination.next.title"/></c:set>
				
				<c:choose>
				<c:when test="${param.dynamic}">
					<apollo:list-loadbutton search="${search}" label="${label}" arialabel="${arialabel}" />
				</c:when>
				<c:otherwise>
					<apollo:list-pagination search="${search}" />
				</c:otherwise>
				</c:choose>
				
			</c:if>
		</cms:contentload>
		
</cms:bundle>
