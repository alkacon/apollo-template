<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<cms:secureparams />


<cms:formatter var="content" val="value">

    <apollo:list-item-compact
        date="${value.Date}"
        datetype="date"
        filename="${content.filename}"
        headline="${value.Title}"
        location="${value.Location}"
        text="${content.valueList.Text['0'].value.Text}"
        teaser="${value.Introduction.value.Text}"
        trimteaser="true"
    />

</cms:formatter>
