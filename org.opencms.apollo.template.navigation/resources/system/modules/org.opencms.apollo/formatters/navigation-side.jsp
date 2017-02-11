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
<cms:bundle basename="org.opencms.apollo.template.navigation.messages">

<div class="ap-sidebar-nav ${cms.element.setting.wrapperclass}">

    <apollo:nav-items
        type="forSite"
        content="${content}"
        currentPageFolder="${cms.requestContext.folderUri}"
        currentPageUri="${cms.requestContext.uri}"
        var="nav">

    <c:set var="navLength" value="${fn:length(nav.items) - 1}" />

    <ul class="sidebar-nav list-group">
    <c:forEach var="i" begin="0" end="${navLength}" >

        <c:set var="navElem" value="${nav.items[i]}" />
        <c:set var="nextLevel" value="${i < navLength ? nav.items[i+1].navTreeLevel : navStartLevel}" />
        <c:set var="startSubNav" value="${nextLevel > navElem.navTreeLevel}" />

        <c:set var="isCurrentPage" value="${navElem.navigationLevel ?
            fn:startsWith(cms.requestContext.uri, navElem.parentFolderName) :
            fn:startsWith(cms.requestContext.uri, navElem.resourceName)}" />

        <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
        <li class="list-group-item${isCurrentPage ? ' currentpage' : ''}"><%--

    --%><c:choose>

            <c:when test="${startSubNav}">

                <%-- Output the start of a new sub-navigation level --%>
                <c:set var="collapseId"><apollo:idgen prefix="nav" uuid="${cms.element.instanceId}" />_${i}</c:set>
                <a href="#${collapseId}" <%--
                --%>class="nav-toggle${isCurrentPage ? '' : ' collapsed'}" <%--
                --%>data-toggle="collapse" <%--
                --%>aria-expanded="${isCurrentPage}"><%--
            --%><c:out value='${navElem.navText}' escapeXml="false" /></a><%--

            --%><c:set var="collapseIn" value="${isCurrentPage ? ' in' : ''}" />
                <c:out value='<ul class="collapse${collapseIn}" id="${collapseId}">' escapeXml="false" />

                <c:if test="${not navElem.navigationLevel}">
                    <%-- Sub navigation started by a page (i.e. not a nav level), so we must add another navigation item here --%>
                    <c:set var="isCurrentSubPage" value="${isCurrentPage and (cms.requestContext.folderUri eq navElem.resourceName)}" />
                    <li class="list-group-item${isCurrentSubPage ? ' currentpage'  : ''}"><%--
                    --%><a href="${navLink}">${navElem.navText}</a><%--
                --%></li><%--
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

    </apollo:nav-items>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>