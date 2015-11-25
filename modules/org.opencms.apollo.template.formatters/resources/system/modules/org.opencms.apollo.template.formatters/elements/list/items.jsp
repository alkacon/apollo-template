<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:if test="${not empty searchT}">
		<c:set var="teaserLength">${param.teaserLength}</c:set>
		<c:set var="search" value="${searchT}" />
		<c:forEach var="result" items="${search.searchResults}">
			<c:set var="content" value="${result.xmlContent}" scope="request" />
			<c:set var="paragraph" value="${content.valueList.Paragraph['0']}"
				scope="request" />
			<cms:edit uuid='${result.fields["id"]}' create="true" delete="true">
				<div class="list-entry row mb-20">
					<cms:include page="${param.typesToCollect}"></cms:include>
				</div>
			</cms:edit>
		</c:forEach>
	</c:if>
</cms:bundle>