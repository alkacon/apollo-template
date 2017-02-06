<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages reload="true">
<cms:formatter var="content" val="value">

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
<c:set var="elementId"><apollo:idgen prefix="le" uuid="${cms.element.id}" /></c:set>

<%-- ##################################### --%>

<div class="ap-list-options ${formatterSettings.listWrapper}"
    id="facets_${elementId}"
    data-facets="${facetsettings}">

    <%-- The list options are filled by JavaScript --%>
    <c:if test="${cms.isEditMode}">
        <fmt:setLocale value="${cms.workplaceLocale}" />
        <cms:bundle basename="org.opencms.apollo.template.list.messages">

        <div id="ap-edit-info" class="box-reload list-options animated fadeIn slow">
            <div class="head">
                <fmt:message key="apollo.list.message.facets">
                    <fmt:param>${value.Headline}</fmt:param>
                </fmt:message>
            </div>
            <div class="text">
                <fmt:message key="apollo.list.message.facetsusage" />
            </div>
        </div>

        </cms:bundle>
    </c:if>

</div>

</cms:formatter>
</apollo:init-messages>
