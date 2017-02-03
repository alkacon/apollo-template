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
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

<apollo:formatter-settings
    type="${value.TypesToCollect}"
    parameters="${content.valueList.Parameters}"
    online="${cms.isOnlineProject}"
/>

<div class="ap-list-content">

        <%-- ####### Headline ######## --%>
        <c:if test="${not cms.element.settings.hideTitle && value.Headline.isSet}">
            <div class="headline">
                <h2 ${content.rdfa.Headline}>
                    <c:out value="${value.Headline}" escapeXml="false" />
                </h2>
            </div>
        </c:if>

        <c:choose>

            <c:when test="${not empty formatterSettings.supportedLists and not fn:contains(formatterSettings.supportedLists, 'dynamic')}">
                <div class="alert alert-warning fade in">
                    <h3>List not configured correctly</h3>
                    <div>
                        The list '${value.Headline}' uses a combination of list formatter and
                        list type that is not compatible.
                        Please change the list formatter using the 'settings' dialog, or the list type in the content editor.
                    </div>
                </div>
            </c:when>

            <c:otherwise>
                <c:set var="count" value="${value.ItemsPerPage.isSet ? value.ItemsPerPage.toInteger : 5}" />
                <c:set var="approxElemHeight" value="150" />
                <c:set var="ajaxlink"><cms:link>/system/modules/org.opencms.apollo/elements/list-ajax.jsp</cms:link></c:set>
                <c:set var="instanceId" value="li_${fn:replace(cms.element.instanceId, '-', '')}"/>
                <c:set var="elementId" value="le_${fn:replace(cms.element.id, '-', '')}"/>

                <%-- ####### The list content will be inserted here with AJAX ####### --%>
                <div
                    class="ap-list-entries ${formatterSettings.listWrapper}"
                    id="${instanceId}"
                    data-id="${elementId}"

                    data-ajax="${ajaxlink}"
                    data-teaser="${cms.element.settings.teaserlength}"
                    data-path="${cms.element.sitePath}"
                    data-sitepath="${cms.requestContext.folderUri}"
                    data-subsite="${cms.requestContext.siteRoot}${cms.subSitePath}"
                    data-dynamic="${cms.element.settings.listOption == 'scrolling' ? 'true' : 'false'}"
                    data-minheight="${count * approxElemHeight}"
                    data-locale="${cms.locale}">

                    <div
                        class="ap-list-box"
                        id="${id}"
                        style="min-height: ${count * approxElemHeight}px;">

                        <div class="col-xs-12">
                            <div class="spinner animated mv-20" style="display: none; transform: none;">
                                <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="ap-list-pagination" style="min-height: 50px;"></div>

                    <%-- ####### Create and edit new entries if empty result ######## --%>
                    <c:set var="createType">${fn:substringBefore(value.TypesToCollect.stringValue, ':')}</c:set>
                    <div class="editbox" style="display: none;" >
                        <apollo:list-messages type="${createType}" />
                    </div>
                </div>

            </c:otherwise>
        </c:choose>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>