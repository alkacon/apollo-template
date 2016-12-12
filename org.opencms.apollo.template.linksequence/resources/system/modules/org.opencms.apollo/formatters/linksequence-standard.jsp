<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:formatter var="content">

    <cms:bundle basename="org.opencms.apollo.template.linksequence.messages">

        <c:set var="textnew"><fmt:message key="apollo.linksequence.message.new" /></c:set>
        <apollo:init-messages textnew="${textnew}" textedit="">

            <apollo:linksequence
                wrapperclass="${cms.element.setting.linksequenceType} ${cms.element.setting.wrapperclass}"
                iconclass="${cms.element.setting.iconclass}"
                title="${content.value.Title}" 
                links="${content.valueList.LinkEntry}" />

        </apollo:init-messages>

    </cms:bundle>

</cms:formatter>