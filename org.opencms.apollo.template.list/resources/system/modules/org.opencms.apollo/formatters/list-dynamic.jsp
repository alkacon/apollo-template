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

<c:set var="showTitle" value="${not cms.element.settings.hideTitle && value.Headline.isSet}" />

<div class="ap-list-content ${cms.isEditMode and !showTitle ? 'oc-point-T-25_L15' : ''}">

        <%-- ####### Headline ######## --%>
        <c:if test="${showTitle}">
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
                <c:set var="instanceId"><apollo:idgen prefix="li" uuid="${cms.element.instanceId}" /></c:set>
                <c:set var="elementId"><apollo:idgen prefix="le" uuid="${cms.element.id}" /></c:set>

                <%-- ####### The list content will be inserted here with AJAX ####### --%>
                <div
                    class="ap-list-entries ${formatterSettings.listWrapper}"
                    id="${instanceId}"
                    data-id="${elementId}"
                    data-list='{<%--
                    --%>"ajax":"${ajaxlink}", <%--
                    --%>"teaser":"${cms.element.settings.teaserlength}", <%--
                    --%>"path":"${cms.element.sitePath}", <%--
                    --%>"sitepath":"${cms.requestContext.folderUri}", <%--
                    --%>"subsite":"${cms.requestContext.siteRoot}${cms.subSitePath}", <%--
                    --%>"appendSwitch":"${cms.element.settings.appendSwitch}", <%--
                    --%>"appendOption":"${cms.element.settings.appendOption}", <%--
                    --%>"minheight":"${count * approxElemHeight}", <%--
                    --%>"locale":"${cms.locale}"<%--
                --%>}'>
                    <div
                        class="ap-list-box"
                        style="min-height: ${count * approxElemHeight}px;">

                        <div class="col-xs-12">
                            <div class="spinner animated" style="display: none; transform: none;">
                                <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
                            </div>
                        </div>
                    </div>
                    <div class="ap-list-pagination"></div>

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