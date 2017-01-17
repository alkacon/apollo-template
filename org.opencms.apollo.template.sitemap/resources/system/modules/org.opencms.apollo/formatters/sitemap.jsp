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

<c:set var="startLevel">0</c:set>
<c:set var="maxDepth">${value.MaximumDepth.isSet ? value.MaximumDepth : 100}</c:set>

<div class="ap-sitemap ${cms.element.setting.wrapperclass}">

    <c:if test="${not cms.element.settings.hideTitle}">
        <div class="headline">
            <h2 ${value.Title.rdfaAttr}>${value.Title}</h2>
        </div>
    </c:if>

    <c:if test="${not cms.element.settings.hideText}">
        <div ${value.Text.rdfaAttr}>${value.Text}</div>
    </c:if>

    <cms:navigation
        type="forSite"
        startLevel="${startLevel}"
        endLevel="${startLevel + maxDepth}"
        var="nav"
        resource="${value.ShowFrom.isSet and not empty value.ShowFrom? value.ShowFrom:cms.subSitePath}" />

    <c:set var="navLength" value="${fn:length(nav.items) - 1}" />

    <div class="clearfix">
    <ul class="col-${not empty cms.element.settings.cols?cms.element.settings.cols: '4'}">
    <c:forEach var="i" begin="0" end="${navLength}" >

        <c:set var="navElem" value="${nav.items[i]}" />
        <c:set var="nextLevel" value="${i < navLength ? nav.items[i+1].navTreeLevel : navStartLevel}" />
        <c:set var="startSubNav" value="${nextLevel > navElem.navTreeLevel}" />
        <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
        <li${navElem.navTreeLevel eq 1 ? ' class="top"' : ''}><%--

    --%><c:choose>

            <c:when test="${startSubNav}">

                <%-- Output the start of a new sub-navigation level --%>
                <c:set var="collapseId" value="nav-${cms.element.instanceId}-${i}" />
                <a href="#${collapseId}" <%--
                --%>class="nav-toggle collapsed" <%--
                --%>data-toggle="collapse" <%--
                --%>aria-expanded="false">${navElem.navText}</a><%--
            --%><c:out value='<ul class="collapse" id="${collapseId}">' escapeXml="false" />
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

</div>


</cms:bundle>
</cms:formatter>

</apollo:init-messages>
