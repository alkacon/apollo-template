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

<div class="ap-iconbox ${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : '' }
    ${' '}
    ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }"
    >

    <div class="text-box" ${content.rdfa.Link}>
        <apollo:link link="${value.Link}" settitle="true">
            <h3 ${content.rdfa.Headline}>${value.Headline}</h3>
            <div><i class="icon-box fa fa-${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : 'warning' }"></i></div>
            <div ${content.rdfa.Text}>${value.Text}</div>
        </apollo:link>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>