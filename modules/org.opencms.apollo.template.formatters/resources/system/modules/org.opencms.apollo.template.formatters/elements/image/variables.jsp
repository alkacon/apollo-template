<c:choose>
	<c:when test="${empty xpath_start}">
		<c:set var="value_start" value="${content.value}" />
	</c:when>
	<c:otherwise>
		<c:set var="value_start" value="${value[xpath_start].value}" />
	</c:otherwise>
</c:choose>
<c:choose>
	<c:when test="${value_start.Image.value.Title.isSet and not empty value_start.Image.value.Title}">
		<c:set var="title">${value_start.Image.value.Title}</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="title">${value.Headline}</c:set>
	</c:otherwise>
</c:choose>
<c:set var="copyright">${value_start.Image.value.Copyright}</c:set>
<%@include
	file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)"%>
