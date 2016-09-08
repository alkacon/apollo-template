<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content">
<apollo:linksequence
    linkclass="ap-bullets"
    title="${content.value.Title}" 
    links="${content.valueList.LinkEntry}" />
</cms:formatter>