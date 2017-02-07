<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.section.messages">

<div class="ap-section jumbotron">
    <c:if test="${value.Headline.isSet}">
        <h1 ${content.rdfa.Headline}>${value.Headline}</h1>
    </c:if>

    <div ${content.rdfa.Text}> 
        ${value.Text}
    </div>

    <c:if test="${value.Link.exists and value.Link.value.URI.isSet}">
        <p>
            <apollo:link link="${value.Link}" cssclass="btn btn-lg" settitle="false"/>
        </p>
    </c:if>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>