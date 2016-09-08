<%@ page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content">
<apollo:image-simple 
    setting="${cms.element.setting}" 
    image="${content.value.Image}"
    headline="${content.value.Headline}" 
    link="${content.value.Link}" />
</cms:formatter>