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
<cms:bundle basename="org.opencms.apollo.template.linksequence.messages">

<c:choose>
<c:when test="${cms.element.setting.linksequenceType eq 'boxed'}">
    <c:set var="wrapperclass">ap-linksequence boxed ${cms.element.setting.wrapperclass}</c:set>
</c:when>
<c:when test="${cms.element.setting.linksequenceType eq 'navigation'}">
    <c:set var="wrapperclass">ap-sidebar-nav ${cms.element.setting.wrapperclass}</c:set>
    <c:set var="ulwrapper">sidebar-nav list-group</c:set>
    <c:set var="liwrapper">list-group-item</c:set>
</c:when>
<c:otherwise>
    <c:set var="wrapperclass">ap-linksequence ${cms.element.setting.wrapperclass}</c:set>
</c:otherwise>
</c:choose>


<apollo:linksequence
    wrapperclass="${wrapperclass}"
    ulwrapper="${ulwrapper}"
    liwrapper="${liwrapper}"
    iconclass="${cms.element.setting.iconclass}"
    title="${content.value.Title}"
    links="${content.valueList.LinkEntry}"
/>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>