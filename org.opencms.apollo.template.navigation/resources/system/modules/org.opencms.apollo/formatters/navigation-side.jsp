<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />

<cms:bundle basename="org.opencms.apollo.template.navigation.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="ap-sidebar-nav ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">

    <c:set var="inMemoryMessage"><fmt:message key="apollo.navigation.message.new" /></c:set>
    <apollo:init-messages textnew="${inMemoryMessage}" />

    <c:set var="rootlevel" value="${value.NavStartLevel.toInteger < 1 ? 1 : value.NavStartLevel.toInteger}" />
    <c:set var="folderUri" value="${cms.requestContext.folderUri}" />
    <c:set var="pageUri" value="${cms.requestContext.uri}" />

    <c:set var="pathparts" value="${fn:split(folderUri, '/')}" />
    <c:set var="startFolder" value="/" />
    <c:forEach var="folderName" items="${pathparts}" varStatus="status">
        <c:if test="${status.count <= rootlevel}">
            <c:set var="startFolder">${startFolder}${folderName}/</c:set>
        </c:if>
    </c:forEach>

    <cms:navigation 
        type="forSite" 
        resource="${startFolder}"
        startLevel="${rootlevel}" 
        endLevel="${rootlevel + 3}"
        locale="${cms.locale}"
        var="nav" />

    <c:set var="navItems" value="${nav.items}" />
    <c:set var="navLength" value="${fn:length(navItems) - 1}" />

    <ul class="sidebar-nav list-group">
    <c:forEach var="i" begin="0" end="${navLength}" >

        <c:set var="navElem" value="${navItems[i]}" />
        <c:set var="navLevel" value="${0 + navElem.navTreeLevel}" />
        <c:set var="nextLevel" value="${i < navLength ? navItems[i+1].navTreeLevel : rootlevel}" />

        <c:set var="activePage" value="${navElem.navigationLevel ? 
            fn:startsWith(pageUri, navElem.parentFolderName) :
            fn:startsWith(pageUri, navElem.resourceName)}" />
        <c:set var="activePageClass" value="${activePage ? ' active currentpage' : ''}" />

        <c:set var="needToggle" value="${nextLevel > navLevel}" />
        <li class="list-group-item ${needToggle ? 'list-toggle' : ''} ${activePageClass}">

            <c:choose>

                <c:when test="${needToggle}">
                    <a class="accordion-toggle ${activePage ? '' : ' collapsed'}" href="#sidenav-${i}" data-toggle="collapse" aria-expanded="${activePage}">${navElem.navText}</a>
                    <c:set var="ulStatus" value="${activePage ? 'in' : ''}" /> 
                    <c:out value='<ul class="collapse ${ulStatus}" id="sidenav-${i}">' escapeXml="false" />

                    <c:if test="${not navElem.navigationLevel}">
                        <c:set var="activeSubPage" value="${activePage and (folderUri eq navElem.resourceName)}" />
                         <li class="list-group-item ${activeSubPage ? activePageClass : ''}">
                            <a href="<cms:link>${navElem.resourceName}</cms:link>">${navElem.navText}</a>
                         </li>
                    </c:if>
                </c:when>

                <c:otherwise>
                    <a href="<cms:link>${navElem.resourceName}</cms:link>">${navElem.navText}</a>
                </c:otherwise>

            </c:choose>

            <c:if test="${nextLevel < navLevel}">
                <c:forEach begin="1" end="${navLevel - nextLevel}" >
                    <c:out value='</ul>' escapeXml="false" />
                </c:forEach>
            </c:if>

        </li>

    </c:forEach>
    </ul>

</div>

</cms:formatter>
</cms:bundle>