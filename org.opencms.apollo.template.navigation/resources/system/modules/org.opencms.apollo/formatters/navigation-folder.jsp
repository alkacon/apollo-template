<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />

<cms:bundle basename="org.opencms.apollo.template.navigation.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">

	<c:set var="inMemoryMessage"><fmt:message key="apollo.navigation.message.new" /></c:set>
	<apollo:init-messages textnew="${inMemoryMessage}" />

		<c:choose>
			<c:when test="${value.NavFolder.isSet}">
				<c:set var="navStartFolder">${value.NavFolder}/</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="pathparts" value="${fn:split(cms.requestContext.folderUri, '/')}" />
				<c:set var="navStartLevel">${value.NavStartLevel.stringValue}</c:set>
				<c:set var="navStartFolder" value="/" />
				<c:set var="lastItem" value="" />
				<c:forEach var="folderName" items="${pathparts}" varStatus="status">
					<c:if test="${status.count <= navStartLevel}">
						<c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
					</c:if>
				</c:forEach>
			</c:otherwise>
		</c:choose>

		<cms:navigation 
            type="forFolder" 
            resource="${navStartFolder}" 
            locale="${cms.locale}"
            var="nav" />

		<apollo:linksequence 
				wrapperclass="ap-linksequence-boxed ap-navfolder" 
				title="${value.Title}" 
				links="${nav.items}" /> 

</cms:formatter>
</cms:bundle>