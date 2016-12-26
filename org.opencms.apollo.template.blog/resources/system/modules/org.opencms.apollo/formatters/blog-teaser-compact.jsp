<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:secureparams />
<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

<apollo:list-item-compact
    filename="${content.filename}"
    headline="${value.Title}"
    text="${content.valueList.Paragraph['0'].value.Text}"
    teaser="${value.Teaser}"
    date="${value.Date}"
    enddate="${value.EndDate}"
    datetype="both"
/>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
