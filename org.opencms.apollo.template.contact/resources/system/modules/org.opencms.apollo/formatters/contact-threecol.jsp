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

<div class="ap-contact ap-contact-threecol vcard">

    <c:set var="fragments1">
        image 
        <c:if test="${cms.element.setting.effect.value != 'none'}">${cms.element.setting.effect.value}</c:if>
        <c:if test="${cms.element.setting.link.value == 'animated-link'}">animated-link</c:if>
    </c:set>

    <c:set var="fragments2">
        name 
        ${cms.element.setting.labels.value}
        <c:if test="${cms.element.setting.showOrganization.value}">organization</c:if>
        <c:if test="${cms.element.setting.showAddress.value}">address</c:if>
        <c:if test="${cms.element.setting.showPhone.value}">phone</c:if>
    </c:set>

    <c:set var="fragments3">
        ${cms.element.setting.labels.value}
        <c:if test="${cms.element.setting.showDescription.value}">description</c:if>
        <c:if test="${cms.element.setting.showEmail.value}">email</c:if>
        <c:if test="${cms.element.setting.link.value == 'static-link'}">static-link</c:if>
    </c:set>

    <div class="row">
        <div class="col-sm-4">
            <apollo:contact
                image="${value.Image}"
                link="${value.Link}"
                fragments="${fragments1}" />
        </div>

        <div class="col-sm-5">
            <apollo:contact
                data="${value.Contact}"
                name="${value.Name}"
                position="${value.Position}"
                organization="${value.Organisation}"
                fragments="${fragments2}" />
        </div>

        <div class="col-sm-3">
            <apollo:contact
                data="${value.Contact}"
                description="${value.Description}"
                link="${value.Link}"
                fragments="${fragments3}" />
        </div>
    </div>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>