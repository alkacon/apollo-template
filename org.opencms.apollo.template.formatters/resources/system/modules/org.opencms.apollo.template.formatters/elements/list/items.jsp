<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:if test="${not empty param.searchConfig}">
		<cms:contentload collector="singleFile" param="%(param.listConfig)">
			<cms:contentaccess var="listConfig" />
		</cms:contentload>

		<cms:search configString="${param.searchConfig}" var="search" addContentInfo="true" />

		<c:forEach var="result" items="${search.searchResults}">
			<cms:display value="${result.xmlContent.filename}" displayFormatters="${listConfig.value.TypesToCollect}" editable="true" create="true" delete="true">
				<cms:param name="teaserlength" value="${param.teaserLength}" />
				<cms:param name="buttoncolor">${param.buttonColor}</cms:param>
				<cms:param name="showdate">${param.showDate}</cms:param>
				<cms:param name="compactform">${param.compactForm}</cms:param>
			</cms:display>
		</c:forEach>
	</c:if>
</cms:bundle>
