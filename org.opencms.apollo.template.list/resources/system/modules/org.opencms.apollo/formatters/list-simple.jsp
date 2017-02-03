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

<cms:formatter var="con" rdfa="rdfa">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

<div class="ap-list-content">

    <%-- ####### Headline ######## --%>
    <c:if test="${not cms.element.settings.hideTitle && con.value.Headline.isSet}">
        <div class="headline">
            <h2 ${rdfa.Headline}>
                <c:out value="${con.value.Headline}" escapeXml="false" />
            </h2>
        </div>
    </c:if>

    <apollo:formatter-settings
        type="${con.value.TypesToCollect}"
        parameters="${con.valueList.Parameters}"
        online="${cms.isOnlineProject}"
    />

    <%--
    <h3>Formatter settings:</h3>
    <c:forEach var="setting" items="${formatterSettings}">
        <div>${setting.key}=${setting.value}</div>
    </c:forEach>
    --%>

    <c:set var="listWrapper" value="${formatterSettings.listWrapper} ${formatterSettings.requiredListWrapper}" />

    <%-- Id must not have any "-" character --%>
    <c:set var="id" value="list_${fn:replace(cms.element.instanceId, '-', '')}"/>

    <div class="${listWrapper}" id="${id}">

        <%-- ####### List entries ######## --%>
        <apollo:list-main
            id="${id}"
            source="${con.value.Folder}"
            types="${con.value.TypesToCollect}"
            count="${con.value.ItemsPerPage.isSet ? con.value.ItemsPerPage.toInteger : 5}"
            locale="${cms.locale}"
            sort="${con.value.SortOrder}"
            categories="${con.readCategories}"
            formatterSettings="${formatterSettings}"
        />

        <%-- ####### Create and edit new entries if empty result ######## --%>
        <c:if test="${search.numFound == 0}">
            <c:set var="createType">${fn:substringBefore(con.value.TypesToCollect.stringValue, ':')}</c:set>
            <apollo:list-messages type="${createType}" />
        </c:if>

        <c:if test="${con.value.Link.exists}">
            <div class="separator">
                <apollo:link link="${con.value.Link}" cssclass="btn btn-sm" settitle="false"/>
            </div>
        </c:if>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>