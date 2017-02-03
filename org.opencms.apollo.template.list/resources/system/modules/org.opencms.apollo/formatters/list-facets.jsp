<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

<apollo:formatter-settings
    type="${content.value.TypesToCollect}"
    parameters="${content.valueList.Parameters}"
    online="${cms.isOnlineProject}"
/>

<%-- ####### Build facet settings ######## --%>
<c:set var="elementId" value="le_${fn:replace(cms.element.id, '-', '')}"/>
<c:set var="settings" value="${cms.element.settings}" />
<c:set var="facetsettings"
    value="none
    ${settings.showfacetcategory ? 'category' : ''}
    ${settings.showsorttitle ? 'sort_title' : ''}
    ${settings.showsortorder ? 'sort_order' : ''}
    ${settings.showsortdate ? 'sort_date' : ''}" />

<%-- ##################################### --%>

<div class="ap-list-options ${formatterSettings.listWrapper}"
    id="listoption_box-${elementId}"
    data-facets="${facetsettings}">

    <%-- The list options are filled by JavaScript --%>

    ${cms.reloadMarker}

    <c:if test="${cms.isEditMode}">
        <div class="list-options editMessage-${elementId} ap-edit-info-message">
            <div class="head">
                <fmt:message key="apollo.list.message.facets" />&nbsp;${value.Headline}
            </div>
            <div class="text">
                <fmt:message key="apollo.list.message.facetsusage" />
            </div>
        </div>
    </c:if>

</div>

</cms:bundle>
</cms:formatter>
