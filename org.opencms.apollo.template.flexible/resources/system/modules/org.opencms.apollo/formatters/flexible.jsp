<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages reload="true">

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.flexible.messages">

<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>

    <c:if test="${not cms.element.settings.hideTitle}">
        <div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
    </c:if>
    ${value.Code}

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>