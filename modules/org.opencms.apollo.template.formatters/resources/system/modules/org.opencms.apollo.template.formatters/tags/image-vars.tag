<%@tag display-name="image-vars" description="Provides quick access to image values from XML"%>

<%@attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true" %>

<%@ variable name-given="imgVal" declare="true" variable-class="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" %>
<%@ variable name-given="imgCopyright" declare="true" %>
<%@ variable name-given="imgTitle" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:choose>
	<c:when test="${content.value.Paragraph.exists}">
		<c:set var="imgVal" value="${value.Paragraph.value}" />
	</c:when>
	<c:otherwise>
		<c:set var="imgVal" value="${content.value}" />
	</c:otherwise>
</c:choose>

<c:set var="imgCopyright" value=""/>
<c:if test="${imgVal.Image.isSet}">
	<c:choose>
		<c:when test="${imgVal.Image.value.Copyright.isSet}">
			<c:set var="imgCopyright">${imgVal.Image.value.Copyright}</c:set>
		</c:when>
		<c:otherwise>
			<c:set var="imgUri">${imgVal.Image.value.Image}</c:set>
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
</c:if>

<c:choose>
	<c:when test="${imgVal.Image.isSet and imgVal.Image.value.Title.isSet}">
		<c:set var="imgTitle">${imgVal.Image.value.Title}</c:set>
	</c:when>
	<c:otherwise>
		<c:set var="imgTitle">${value.Headline}</c:set>
	</c:otherwise>
</c:choose>

<jsp:doBody/>
