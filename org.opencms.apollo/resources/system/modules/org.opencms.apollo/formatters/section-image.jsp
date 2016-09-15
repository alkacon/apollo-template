<%@ page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">

<cms:formatter var="content">
    <c:set var="textnew"><fmt:message key="apollo.section.message.new" /></c:set>
    <apollo:init-messages textnew="${textnew}">
        <apollo:image-simple 
            image="${content.value.Image}"
            headline="${content.value.Headline}" 
            link="${content.value.Link}" />
    </apollo:init-messages>
</cms:formatter>
</cms:bundle>