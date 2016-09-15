<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">

<cms:formatter var="content" val="value" rdfa="rdfa">

<c:set var="textnew"><fmt:message key="apollo.section.message.new" /></c:set>
<apollo:init-messages textnew="${textnew}">

	<div class="jumbotron p-10">
		<c:if test="${value.Headline.isSet}">
			<h1 ${rdfa.Headline}>${value.Headline}</h1>
		</c:if>

		<p>
			<span ${rdfa.Text}>${value.Text}</span>
		</p>
		
		<c:if test="${value.Link.exists and value.Link.value.URI.isSet}">
			<p>
				<apollo:link link="${value.Link}" cssclass="btn ap-btn-lg" settitle="false"/>
			</p>
		</c:if>
	</div>
</apollo:init-messages>

</cms:formatter>
</cms:bundle>