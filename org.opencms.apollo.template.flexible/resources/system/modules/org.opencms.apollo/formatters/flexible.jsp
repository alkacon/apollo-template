<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content" val="value">
<c:set var="hasScript" value="${fn:contains(fn:toLowerCase(value.Code), 'script')}" />
<apollo:init-messages reload="${value.RequireReload.toBoolean or hasScript}">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.flexible.messages">

<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>

    <c:if test="${not cms.element.settings.hideTitle}">
        <div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
    </c:if>
    ${value.Code}

</div>

</cms:bundle>

</apollo:init-messages>
</cms:formatter>