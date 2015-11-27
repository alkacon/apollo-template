<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:if test="${not empty param.searchConfig}">
		<cms:search configString="${param.searchConfig}" var="search"
			addContentInfo="true" />
		<c:forEach var="result" items="${search.searchResults}">
			<c:set var="content" value="${result.xmlContent}" />
			<cms:edit uuid='${result.fields["id"]}' create="true" delete="true">
				<div class="list-entry row mb-20">
					<cms:include page="${param.typesToCollect}">
						<cms:param name="filename" value="${content.filename}" />
						<cms:param name="teaserLength" value="${param.teaserLength}" />
					</cms:include>
				</div>
			</cms:edit>
		</c:forEach>
	</c:if>
</cms:bundle>