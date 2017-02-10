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
<cms:bundle basename="org.opencms.apollo.template.contact.messages">

<%-- #### Contact exposed as 'Person', see http://schema.org/Person #### --%>

<c:choose>
    <c:when test="${value.Kind eq 'org'}">
        <c:set var="kind">itemscope itemtype="https://schema.org/Organization"</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="kind">itemscope itemtype="http://schema.org/Person"</c:set>
    </c:otherwise>
</c:choose>

<div class="ap-contact ap-contact-onecol ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }" ${kind}>

    <c:set var="fragments">
        name
        ${cms.element.setting.labels.value}
        <c:if test="${cms.element.setting.effect.value != 'no-img'}">image</c:if>
        <c:if test="${cms.element.setting.effect.value != 'none'}">${cms.element.setting.effect.value}</c:if>
        <c:if test="${cms.element.setting.link.value != 'false'}">${cms.element.setting.link.value}</c:if>
        <c:if test="${cms.element.setting.showPosition.value}">position</c:if>
        <c:if test="${cms.element.setting.showOrganization.value}">organization</c:if>
        <c:if test="${cms.element.setting.showDescription.value}">description</c:if>
        <c:if test="${cms.element.setting.showAddress.value == 'true'}">address</c:if>
        <c:if test="${cms.element.setting.showAddress.value == 'always'}">address-always</c:if>
        <c:if test="${cms.element.setting.showPhone.value}">phone</c:if>
        <c:if test="${cms.element.setting.showEmail.value}">email</c:if>
        <c:if test="${cms.element.setting.showVcard.value}">vcard</c:if>
    </c:set>

    <apollo:contact
        kind="${value.Kind}"
        image="${value.Image}"
        link="${value.Link}"
        name="${value.Name}"
        position="${value.Position}"
        organization="${value.Organization}"
        description="${value.Description}"
        data="${value.Contact}"
        fragments="${fragments}" />

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>