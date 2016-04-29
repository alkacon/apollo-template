<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content">

<c:if test="${content.value.Headline.isSet}">
    <div class="${cms.element.setting.hstyle}">
        <${cms.element.setting.hsize}${' '}${content.rdfa.Headline}>${content.value.Headline}</${cms.element.setting.hsize}>
    </div>
</c:if>

</cms:formatter>
