<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />

<cms:bundle basename="org.opencms.apollo.template.navigation.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">

    <c:set var="inMemoryMessage"><fmt:message key="apollo.navigation.message.new" /></c:set>
    <apollo:init-messages textnew="${inMemoryMessage}" />

    <apollo:nav-items
        type="forFolder"
        content="${content}"
        currentPageFolder="${cms.requestContext.folderUri}" 
        currentPageUri="${cms.requestContext.uri}" 
        var="nav">

        <apollo:linksequence 
            wrapperclass="ap-linksequence-boxed ap-navfolder" 
            title="${value.Title}" 
            links="${nav.items}" /> 

    </apollo:nav-items>

</cms:formatter>
</cms:bundle>