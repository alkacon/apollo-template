<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
    <div class="${cms.element.setting.hstyle}">
        <${cms.element.setting.hsize}${' '}${rdfa.Headline}>${value.Headline}</${cms.element.setting.hsize}>
    </div>
</cms:formatter>
