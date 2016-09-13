<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:set var="inMemoryMessage"><fmt:message key="apollo.section.message.new" /></c:set>
	<apollo:init-messages textnew="${inMemoryMessage}">
	
		<apollo:image-vars image="${content.value.Image}">
			<c:choose>
				<c:when test="${empty imageLink}">
					<div class="alert">
						<fmt:message key="apollo.section.message.noimage" />
					</div>
				</c:when>
				<c:otherwise>
					<apollo:image-zoom 
						image="${content.value.Image}"
						headline="${content.value.Headline}" />
				</c:otherwise>
			</c:choose>
		</apollo:image-vars>
	
	</apollo:init-messages>
</cms:formatter>
</cms:bundle>
