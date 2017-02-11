<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.tabs.messages">

<div class="ap-tab-section ${cms.element.setting.wrapperclass}">

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline"><h2 ${content.rdfa.Title}>${value.Title}</h2></div>
    </c:if>

    <c:set var="id"><apollo:idgen prefix="tab" uuid="${cms.element.instanceId}" /></c:set>

    <div class="ap-tab">
        <ul class="nav nav-tabs">
            <c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
                <li ${status.first ? ' class="active"' : ''}><a href="#${id}_${status.count}" data-toggle="tab">${label}</a></li>
            </c:forEach>
        </ul>

        <div class="tab-content">
            <fmt:setLocale value="${cms.workplaceLocale}" />
            <cms:bundle basename="org.opencms.apollo.template.tabs.messages">
            <c:forEach var="label" items="${content.valueList.Label}" varStatus="status">

                <div id="${id}_${status.count}" class="tab-pane ap-tab-pane fade ${status.first? 'active in':''}" >
                <cms:container
                    name="tab-container${status.count}"
                    type="row"
                    maxElements="50">
                        <c:set var="msg"><fmt:message key="apollo.tabs.emptycontainer.text"/></c:set>
                        <apollo:container-box
                            label="${msg}"
                            boxType="container-box"
                            role="role.ELEMENT_AUTHOR"
                            type="row" />
                    </cms:container>
                </div>

            </c:forEach>
            </cms:bundle>
        </div>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
