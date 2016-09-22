<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
		
		<cms:contentload collector="singleFile" param="${param.contentpath}">
			<cms:contentinfo var="info" />
			<c:if test="${info.resultSize > 0}">
				<cms:contentaccess var="content" />
				
				<%-- ####### Simple list with facets ######## --%>
				<c:set var="itemCount" value="5" />
				<c:if test="${content.value.ItemsPerPage.isSet}">
					<c:set var="itemCount" value="${content.value.ItemsPerPage.toInteger}" />
				</c:if>
				<apollo:list-main 
							source="${content.value.Folder}" 
							types="${content.value.TypesToCollect}" 
							color="${param.buttoncolor}"
							count="${itemCount}" 
							showexpired="${param.showexpired == 'true'}" 
							teaserlength="${param.teaserlength}" 
							sort="${content.value.SortOrder}"
							categories="${content.readCategories}" 
							showfacets="${param.facets}" 
							showdate="${param.showdate}"
							path="${param.sitepath}"
							locale="${param.loc}"/>
									
				<%-- ####### Load pagination (dynamic or normal) ######## --%>
				<c:set var="label"><fmt:message key="pagination.next"/></c:set>
				<c:set var="arialabel"><fmt:message key="pagination.next.title"/></c:set>
				
				<c:choose>
				<c:when test="${param.dynamic}">
					<apollo:list-loadbutton search="${search}" label="${label}" arialabel="${arialabel}" color="${param.buttoncolor}" />
				</c:when>
				<c:otherwise>
					<apollo:list-pagination search="${search}" />
				</c:otherwise>
				</c:choose>
				
			</c:if>
		</cms:contentload>
		
</cms:bundle>
