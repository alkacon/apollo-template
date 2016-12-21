<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">
<cms:formatter var="con" rdfa="rdfa">

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

            <div ${not empty listWrapper ? 'class="'.concat(listWrapper).concat('"')  : '' } id="list-${cms.element.instanceId}">

                <%-- ####### List entries ######## --%>
                <apollo:list-main
                    source="${con.value.Folder}"
                    types="${con.value.TypesToCollect}"
                    count="${con.value.ItemsPerPage.isSet ? con.value.ItemsPerPage.toInteger : 5}" 
                    locale="${cms.locale}"
                    sort="${con.value.SortOrder}"
                    categories="${con.readCategories}" 
                    formatterSettings="${formatterSettings}"

                    listid="${cms.element.instanceId}"
                />

                <%-- ####### Create and edit new entries if empty result ######## --%>
                <c:if test="${search.numFound == 0}">
                    <c:set var="createType">${fn:substringBefore(con.value.TypesToCollect.stringValue, ':')}</c:set>
                    <cms:edit createType="${createType}" create="true" >
                        <div class="alert alert-warning fade in">
                            <h3><fmt:message key="apollo.list.message.empty" /></h3>
                            <div><fmt:message key="apollo.list.message.newentry" /></div>
                        </div>
                    </cms:edit>
                </c:if>

                <c:if test="${con.value.Link.exists}">
                    <div class="separator">
                        <apollo:link link="${con.value.Link}" cssclass="btn btn-sm" settitle="false"/>
                    </div>
                </c:if>
            </div>

        </apollo:init-messages>

    </div>

</cms:formatter>
</cms:bundle>