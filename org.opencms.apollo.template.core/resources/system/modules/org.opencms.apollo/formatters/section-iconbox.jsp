<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.text">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="ap-iconbox ${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : '' }${' '}${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }" ${rdfa.Link}>
    <c:set var="textnew"><fmt:message key="apollo.text.message.new" /></c:set>

    <div class="text-box">
        <apollo:init-messages textnew="${textnew}">
            <apollo:link link="${value.Link}" cssclass="no-underline" settitle="true">
                <h3 ${rdfa.Headline}>${value.Headline}</h3>
                <div><i class="icon-box fa fa-${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : 'warning' }"></i></div>
                <div ${rdfa.Text}>${value.Text}</div>
            </apollo:link>
        </apollo:init-messages>
    </div>

</div>

</cms:formatter>
</cms:bundle>