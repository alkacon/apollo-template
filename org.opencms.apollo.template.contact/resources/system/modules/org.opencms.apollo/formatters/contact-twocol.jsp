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

<div class="ap-contact ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }" ${kind}>

    <c:set var="fragments1">
        image
        <c:if test="${cms.element.setting.effect.value != 'none'}">${cms.element.setting.effect.value}</c:if>
        <c:if test="${cms.element.setting.link.value == 'animated-link'}">animated-link</c:if>
    </c:set>
    <c:set var="showImage" value="${cms.element.setting.effect.value != 'no-img'}" />

    <c:set var="fragments2">
        name
        ${cms.element.setting.labels.value}
        <c:if test="${cms.element.setting.showOrganization.value}">organization</c:if>
        <c:if test="${cms.element.setting.showPosition.value}">position</c:if>
        <c:if test="${cms.element.setting.showAddress.value == 'true'}">address</c:if>
        <c:if test="${cms.element.setting.showAddress.value == 'always'}">address-always</c:if>
        <c:if test="${cms.element.setting.showPhone.value}">phone</c:if>
        <c:if test="${cms.element.setting.showVcard.value}">vcard</c:if>
        <c:if test="${cms.element.setting.showDescription.value}">description</c:if>
        <c:if test="${cms.element.setting.showEmail.value}">email</c:if>
        <c:if test="${cms.element.setting.link.value == 'static-link'}">static-link</c:if>
    </c:set>

    <div class="row">
        <c:if test="${showImage}">
            <div class="col-xs-12 col-sm-3">
                <apollo:contact
                    image="${value.Image}"
                    link="${value.Link}"
                    fragments="${fragments1}" />
            </div>
        </c:if>

        <div class="${showImage ? 'col-xs-12 col-sm-9' : 'col-xs-12'}">
            <apollo:contact
                data="${value.Contact}"
                name="${value.Name}"
                position="${value.Position}"
                organization="${value.Organization}"
                description="${value.Description}"
                link="${value.Link}"
                fragments="${fragments2}" />
        </div>
    </div>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>