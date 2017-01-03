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
<cms:bundle basename="org.opencms.apollo.template.shariff.messages">

<c:set var="csswrapper">
    ${cms.element.setting.wrapperclass}
    ${' '}${cms.element.setting.theme}
    ${' '}${cms.element.setting.orientation}
    ${' '}${cms.element.setting.verbose}
    ${' '}${cms.element.setting.shape}
</c:set>

<div class="ap-social ${fn:replace(csswrapper, 'default', '')}">
    <c:if test="${cms.element.settings.hidetitle ne 'true'}">
        <div class="headline">
            <h2 ${rdfa.Title}>${value.Title}</h2>
        </div>
    </c:if>
    <c:set var="services">[&quot;${fn:replace(value.Services, ',', '&quot;,&quot;')}&quot;]</c:set>
    <c:set var="mailAttrs" value="" />
    <c:if test="${fn:contains(value.Services.stringValue, 'mail')}">
        <c:if test="${value.MailConfig.isSet}">
            <c:choose>
                <c:when test="${value.MailConfig.value.FormLink.isSet}">
                    <c:set var="mailAttrs">data-mail-url="<cms:link>${value.MailConfig.value.FormLink}</cms:link>"</c:set>
                </c:when>
                <c:when test="${value.MailConfig.value.Mail.isSet}">
                    <c:set var="mailAttrs">data-mail-url="mailto:${value.MailConfig.value.Mail.value.MailTo}"</c:set>
                    <c:if test="${value.MailConfig.value.Mail.value.Subject.isSet}">
                        <c:set var="mailAttrs">${mailAttrs}${' '}data-mail-subject="${value.MailConfig.value.Mail.value.Subject}"</c:set>
                    </c:if>
                    <c:if test="${value.MailConfig.value.Mail.value.Body.isSet}">
                        <c:set var="mailAttrs">${mailAttrs}${' '}data-mail-body="${value.MailConfig.value.Mail.value.Body}"</c:set>
                    </c:if>
                </c:when>
            </c:choose>
        </c:if>
    </c:if>
    <c:set var="lang">en</c:set>
    <c:if test="${fn:contains('bg,de,en,es,fi,hr,hu,ja,ko,no,pl,pt,ro,ru,sk,sl,sr,sv,tr,zh', cms.locale)}">
        <c:set var="lang">${cms.locale}</c:set>
    </c:if>
    <div class="shariff" data-services="${services}" data-lang="${lang}" ${mailAttrs}></div>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>