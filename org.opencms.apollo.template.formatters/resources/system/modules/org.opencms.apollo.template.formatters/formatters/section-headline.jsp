<%@ page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content">
<apollo:headline 
    setting="${cms.element.setting}" 
    headline="${content.value.Headline}" />
</cms:formatter>
