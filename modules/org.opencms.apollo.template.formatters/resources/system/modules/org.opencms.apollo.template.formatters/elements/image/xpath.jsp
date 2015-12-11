<c:set var="xpath_start"></c:set>
<c:choose>
	<c:when
		test="${cms.element.resourceTypeName == 'a-event'  || cms.element.resourceTypeName == 'a-blog'}">
		<c:set var="xpath_start">Paragraph</c:set>
	</c:when>
</c:choose>
<c:set var="xpath_image">${xpath_start}/Image/Image</c:set>
