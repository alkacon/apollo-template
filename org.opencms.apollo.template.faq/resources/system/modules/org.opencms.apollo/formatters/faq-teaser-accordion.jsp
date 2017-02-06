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
<cms:bundle basename="org.opencms.apollo.template.faq.messages">

<c:set var="id"><apollo:idgen prefix="faq" uuid="${cms.element.instanceId}" /></c:set>

<%--

Note about how this elements works in the list:

There are hidden element settings configured in the formatter configuration.
These will add the required "ap-panel panel-group" classes to the surrounding <div>

--%>

<div class="panel ${cms.element.settings.cssWrapper}">

    <div class="panel-heading">
        <h4 class="panel-title">
            <a
                class="accordion-toggle ${cms.element.settings.index == 0 ? '':'collapsed'}"
                data-parent="#${cms.element.settings.listid}"
                data-toggle="collapse"
                href="#${id}_${cms.element.settings.index}">

                <div>${content.value.Question}</div>
            </a>
        </h4>
    </div>

    <div id="${id}_${cms.element.settings.index}"
        class="panel-collapse collapse ${cms.element.settings.index == 0 ? 'in' : ''}">
        <div class="panel-body">
            <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
                <apollo:paragraph
                    showimage="true"
                    headline="inline"
                    headlinestyle="ap-faq-header"
                    paragraph="${paragraph}" />
            </c:forEach>
        </div>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>