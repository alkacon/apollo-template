<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="jumbotron p-10">

	<c:if test="${value.Headline.isSet}">
		<h1 ${rdfa.Headline}>${value.Headline}</h1>
	</c:if>

	<p><div ${rdfa.Text}>${value.Text}</div></p>
	<c:if test="${value.Link.exists and value.Link.value.URI.isSet}">
		<p>
			<apollo:link link="${value.Link}" linkclass="btn ap-btn-lg" settitle="false"/>
		</p>
	</c:if>
</div>

</cms:formatter>