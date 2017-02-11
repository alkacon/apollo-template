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
<cms:bundle basename="org.opencms.apollo.template.sitemap.messages">

<div class="ap-sitemap ${cms.element.setting.wrapperclass}">

    <c:if test="${not cms.element.settings.hideTitle}">
        <div class="headline">
            <h2 ${value.Title.rdfaAttr}>${value.Title}</h2>
        </div>
    </c:if>

    <c:if test="${value.Text.isSet and not cms.element.settings.hideText}">
        <div ${value.Text.rdfaAttr}>${value.Text}</div>
    </c:if>

    <cms:navigation
        type="forSite"
        startLevel="0"
        var="nav"
        resource="${value.ShowFrom.isSet ? value.ShowFrom : cms.subSitePath}" />

    <c:set var="navLength" value="${fn:length(nav.items) - 1}" />
    <c:if test="${navLength >= 0}">
        <%-- ###### Filter the sitemap entries to display ###### --%>
        <c:set var="topLevel" value="${nav.items[0].navTreeLevel}" />
        <c:set var="maxLevel" value="${(value.MaximumDepth.isSet and (value.MaximumDepth.toInteger > 0)) ? topLevel + value.MaximumDepth.toInteger : 100}" />
        <c:set var="navItems" value="${cms:createList()}" />
        <c:set var="subPrefix" value="" />

        <c:forEach var="i" begin="0" end="${navLength}" >
            <c:choose>
                <c:when test="${nav.items[i].navTreeLevel >= maxLevel}">
                    <%-- ###### Sitemap level is too deep, ignore entry ###### --%>
                </c:when>
                <c:when test="${value.IncludeSubSiteMaps.toBoolean}">
                    <%-- ###### Include subsitemap entries in the list ###### --%>
                    ${cms:addToList(navItems, nav.items[i])}
                </c:when>
                <c:otherwise>
                    <%-- ###### Filter subsitemap entries from the list  ###### --%>
                        <c:set var="curPath" value="${nav.items[i].resource.rootPath}" />
                        <c:if test="${(not empty subPrefix) and not fn:startsWith(curPath, subPrefix)}">
                            <c:set var="subPrefix" value="" />
                        </c:if>
                        <c:if test="${empty subPrefix}">
                            ${cms:addToList(navItems, nav.items[i])}
                        </c:if>
                        <c:if test="${cms:isSubSitemap(nav.items[i].resource)}">
                            <c:set var="subPrefix" value="${curPath}" />
                        </c:if>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </c:if>

    <c:set var="navLength" value="${fn:length(navItems) - 1}" />
    <c:if test="${navLength >= 0}">
        <c:set var="openFirst" value="${value.SitemapOpenedPerDefault.toBoolean}" />
        <c:set var="openAll" value="${value.SubFoldersOpenedPerDefault.toBoolean}" />

        <div class="clearfix">
        <ul class="col-${not empty cms.element.settings.cols ? cms.element.settings.cols: '4'}">
        <c:forEach var="i" begin="0" end="${navLength}" >

            <c:set var="navElem" value="${navItems[i]}" />
            <c:set var="nextLevel" value="${i < navLength ? navItems[i+1].navTreeLevel : navStartLevel}" />
            <c:set var="startSubNav" value="${nextLevel > navElem.navTreeLevel}" />
            <c:set var="openCurrent" value="${(navElem.navTreeLevel eq topLevel) ? openFirst : openAll}" />
            <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>

            <li${navElem.navTreeLevel eq topLevel ? ' class="top"' : ''}><%--
        --%><c:choose>

                <c:when test="${startSubNav}">

                    <%-- Output the start of a new sub-navigation level --%>
                    <c:set var="collapseId"><apollo:idgen prefix="nav" uuid="${cms.element.instanceId}" />_${i}</c:set>
                    <a href="#${collapseId}" <%--
                    --%>class="nav-toggle ${openCurrent ? '' : 'collapsed'}" <%--
                    --%>data-toggle="collapse" <%--
                    --%>aria-expanded="${openCurrent}">${navElem.navText}</a><%--
                --%><c:set var="collapseIn" value="${openCurrent ? 'in' : ''}" />
                    <c:out value='<ul class="collapse ${collapseIn}" id="${collapseId}">' escapeXml="false" />
                    <c:if test="${not navElem.navigationLevel}">
                        <%-- Sub navigation started by a page (i.e. not a nav level), so we must add another navigation item here --%>
                        <li><a href="${navLink}">${navElem.navText}</a></li><%--
                --%></c:if>

                </c:when>
                <c:otherwise>

                    <%-- Output a regular navigation item --%>
                    <c:out value='<a href="${navLink}">${navElem.navText}</a>' escapeXml="false" />

                </c:otherwise>

            </c:choose>

            <c:if test="${nextLevel < navElem.navTreeLevel}">
                <c:forEach begin="1" end="${navElem.navTreeLevel - nextLevel}" >
                    <c:out value='</ul>' escapeXml="false" />
                </c:forEach>
            </c:if>

            <c:out value='</li>${nl}' escapeXml="false" />

        </c:forEach>
        </ul>
        </div>
    </c:if>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
