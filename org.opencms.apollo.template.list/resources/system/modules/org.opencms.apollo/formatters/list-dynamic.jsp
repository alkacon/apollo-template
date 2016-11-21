<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
<cms:formatter var="con" rdfa="rdfa">

<apollo:formatter-settings 
    type="${con.value.TypesToCollect}" 
    parameters="${con.valueList.Parameters}"
    online="${cms.isOnlineProject}" 
/>

    <div class="ap-list-content">
        <c:set var="textnew"><fmt:message key="apollo.list.message.new" /></c:set>
        <c:set var="textedit"><fmt:message key="apollo.list.message.edit" /></c:set>
        <apollo:init-messages textnew="${textnew}" textedit="${textedit}">

            <%-- ####### Headline ######## --%>
            <c:if test="${not cms.element.settings.hideTitle && con.value.Headline.isSet}">
                <div class="headline">
                    <h2 ${rdfa.Headline}>
                        <c:out value="${con.value.Headline}" escapeXml="false" />
                    </h2>
                </div>
            </c:if>

            <c:choose>

                <c:when test="${not empty formatterSettings.supportedLists and not fn:contains(formatterSettings.supportedLists, 'dynamic')}">
                    <div class="alert alert-warning fade in">
                        <h3>List not configured correctly</h3>
                        <div>
                            The list '${con.value.Headline}' uses a combination of list formatter and 
                            list type that is not compatible.
                            Please change the list formatter using the 'settings' dialog, or the list type in the content editor.
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <c:set var="count" value="${con.value.ItemsPerPage.isSet ? con.value.ItemsPerPage.toInteger : 5}" />
                    <c:set var="approxElemHeight" value="150" />
                    <c:set var="ajaxlink"><cms:link>/system/modules/org.opencms.apollo/elements/list-ajax.jsp</cms:link></c:set>

                    <%-- ####### The list content will be inserted here with AJAX ####### --%>
                    <div 
                        class="ap-list-entries ${formatterSettings.listWrapper}" 
                        id="list-${cms.element.id}"
                        data-id="${cms.element.id}" 
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
                            id="list-${cms.element.id}" 
                            style="min-height: ${count * approxElemHeight}px;">

                            <div class="col-xs-12">
                                <div class="spinner animated mv-20" style="display: none; transform: none;">
                                    <div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
                                </div>
                            </div>
                        </div>
                        <div class="ap-list-pagination" style="min-height: 50px;"></div>

                        <%-- ####### Create and edit new entries if empty result ######## --%>
                        <c:set var="createType">${fn:substringBefore(con.value.TypesToCollect.stringValue, ':')}</c:set>
                        <div class="editbox" style="display: none;" >
                            <cms:edit createType="${createType}" create="true" >
                                <div class="alert alert-warning fade in">
                                    <h3><fmt:message key="apollo.list.message.empty" /></h3>
                                    <div><fmt:message key="apollo.list.message.newentry" /></div>
                                </div>
                            </cms:edit>
                        </div>
                    </div>

                </c:otherwise>
            </c:choose>

        </apollo:init-messages>
    </div>


</cms:formatter>
</cms:bundle>