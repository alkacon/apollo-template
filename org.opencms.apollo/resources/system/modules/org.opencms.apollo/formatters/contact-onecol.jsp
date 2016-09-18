<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.contact">
<cms:formatter var="content" val="value">

<%-- #### Contact exposed in hCard microformat, see http://microformats.org/wiki/hcard #### --%>
<c:set var="textnew"><fmt:message key="apollo.contact.message.new" /></c:set>
<apollo:init-messages textnew="${textnew}">

<div class="ap-contact ap-contact-onecol vcard">

    <c:set var="fragments">
        image 
        name 
        ${cms.element.setting.labels.value}
        <c:if test="${cms.element.setting.effect.value != 'none'}">${cms.element.setting.effect.value}</c:if>
        <c:if test="${cms.element.setting.link.value != 'false'}">${cms.element.setting.link.value}</c:if>
        <c:if test="${cms.element.setting.showOrganization.value}">organization</c:if>
        <c:if test="${cms.element.setting.showDescription.value}">description</c:if>
        <c:if test="${cms.element.setting.showAddress.value}">address</c:if>
        <c:if test="${cms.element.setting.showPhone.value}">phone</c:if>
        <c:if test="${cms.element.setting.showEmail.value}">email</c:if>
    </c:set>

    <apollo:contact
        image="${value.Image}"
        link="${value.Link}"
        name="${value.Name}"
        position="${value.Position}"
        organization="${value.Organization}"
        description="${value.Description}"
        data="${value.Contact}"
        fragments="${fragments}" />
</div>

</apollo:init-messages>

</cms:formatter>
</cms:bundle>