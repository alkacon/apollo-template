<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
</cms:formatter>
