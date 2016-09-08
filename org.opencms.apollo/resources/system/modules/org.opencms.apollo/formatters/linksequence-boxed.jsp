<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content">
<apollo:linksequence 
    wrapperclass="ap-linksequence-boxed" 
    title="${content.value.Title}" 
    links="${content.valueList.LinkEntry}" />
</cms:formatter>