<c:set var="xpath_start"></c:set>
<c:choose>
	<c:when
		test="${cms.element.resourceTypeName == 'a-event'  || cms.element.resourceTypeName == 'a-blog'}">
		<c:set var="xpath_start">Paragraph</c:set>
        <c:set var="xpath_image">Paragraph/Image/Image</c:set>
	</c:when>
    <c:when
		test="${cms.element.resourceTypeName == 'xmlimage'}">
		<c:set var="xpath_image">Image</c:set>
	</c:when>
    <c:otherwise>
        <c:set var="xpath_image">Image/Image</c:set>
    </c:otherwise>
</c:choose>

