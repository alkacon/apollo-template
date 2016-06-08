<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
    <cms:formatter var="content" val="value" rdfa="rdfa">
		<apollo:image-vars image="${content.value.Image}">
        <c:choose>
			<c:when test="${empty imageLink}">
                <div class="alert">
                    <fmt:message key="no.image" />
                </div>
            </c:when>
            <c:otherwise>
                <div>
                    <div class="thumbnails thumbnail-style thumbnail-kenburn">
						<apollo:image-simple 
							setting="${cms.element.setting}" 
							image="${content.value.Image}"
							headline="${content.value.Headline}" 
							link="${content.value.Link}" 
							content="${content}" />
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
		</apollo:image-vars>
    </cms:formatter>
</cms:bundle>
