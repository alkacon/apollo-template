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
<c:set var="settings" value="${cms.element.settings}" />
<c:set var="facetsettings" 
    value="none
    ${settings.showfacetcategory ? 'category' : ''}
    ${settings.showsorttitle ? 'sort_title' : ''}
    ${settings.showsortorder ? 'sort_order' : ''}
    ${settings.showsortdate ? 'sort_date' : ''}" />

<%-- ##################################### --%>

<div class="ap-list-options ${formatterSettings.listWrapper}" 
    id="listoption_box-${cms.element.id}" 
    data-id="${cms.element.id}" 
    data-facets="${facetsettings}">

    ${cms.reloadMarker}

    <c:if test="${cms.isEditMode}">
        <div class="list-options editMessage-${cms.element.id} ap-edit-info-message">
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
