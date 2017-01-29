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
<cms:bundle basename="org.opencms.apollo.template.navigation.messages">

<apollo:nav-items
    type="forFolder"
    content="${content}"
    currentPageFolder="${cms.requestContext.folderUri}"
    currentPageUri="${cms.requestContext.uri}"
    var="nav">

    <apollo:linksequence
        wrapperclass="ap-sidebar-nav ${cms.element.setting.wrapperclass}"
        ulwrapper="sidebar-nav list-group"
        liwrapper="list-group-item"
        iconclass="${cms.element.setting.iconclass.isSet ? cms.element.setting.iconclass : 'none'}"
        title="${value.Title}"
        links="${nav.items}" />

</apollo:nav-items>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>