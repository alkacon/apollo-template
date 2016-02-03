<c:choose>
	<c:when test="${value.Paragraph.exists}">
		<c:set var="imgValParent" value="${value.Paragraph.value}" />
	</c:when>
	<c:otherwise>
		<c:set var="imgValParent" value="${content.value}" />
	</c:otherwise>
</c:choose>

<c:set var="imgCopyright" value=""/>
<c:if test="${imgValParent.Image.isSet}">
	<c:choose>
		<c:when test="${imgValParent.Image.value.Copyright.isSet}">
			<c:set var="imgCopyright">${imgValParent.Image.value.Copyright}</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="imgUri">${imgValParent.Image.value.Image}</c:set>
			<c:if test="${fn:contains(imgUri, '?')}">
				<c:set var="imgUri">${fn:substringBefore(imgUri, '?')}</c:set>  
			</c:if>
			<c:set var="imgCopyright"><cms:property name="Copyright" file="${imgUri}" default="" /></c:set>
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${not empty imgCopyright}">
	<c:set var="imgCopyrightSymbol">(c)</c:set>
	<c:set var="imgCopyright">${fn:replace(imgCopyright, '&copy;', imgCopyrightSymbol)}</c:set>
	<c:if test="${not fn:contains(imgCopyright, imgCopyrightSymbol)}">
		<c:set var="imgCopyright">${imgCopyrightSymbol}${' '}${imgCopyright}</c:set>
	</c:if>
	<c:set var="imgCopyright">${imgCopyright}</c:set>
</c:if>

<c:choose>
	<c:when test="${imgValParent.Image.isSet and imgValParent.Image.value.Title.isSet}">
		<c:set var="imgTitle">${imgValParent.Image.value.Title}</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="imgTitle">${value.Headline}</c:set>
	</c:otherwise>
</c:choose>