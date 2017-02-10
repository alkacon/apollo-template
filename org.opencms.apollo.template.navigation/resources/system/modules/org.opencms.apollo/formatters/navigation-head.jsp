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

<div class="ap-header">

<c:set var="parent_role" value="${cms.container.param}" />

<div class="head ${cms.modelGroupPage and cms.isEditMode ? 'editor ' : ' '} ${value.PullNavUp.toBoolean ? ' ' : 'head-nopull '} ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">

    <c:if test="${value.Container.toBoolean}">
        <div class="head-container">
            <cms:container
                name="head-bg"
                type="segment"
                width="1200"
                maxElements="50"
                editableby="${parent_role}"
                param="${parent_role}">

                <c:if test="${cms.modelGroupPage}">
                    <cms:bundle basename="org.opencms.apollo.template.core.messages">
                        <c:set var="message"><fmt:message key="apollo.page.text.emptycontainer" /></c:set>
                    </cms:bundle>
                    <apollo:container-box
                        label="${message}"
                        boxType="container-box"
                        type="segment"
                        role="ROLE.DEVELOPER"
                    />
                </c:if>
            </cms:container>
        </div>
    </c:if>

    <c:if test="${value.Inline.isSet and value.Inline.value.LogoImage.isSet}">
        <c:set var="inline" value="${value.Inline.value}" />
        <c:set var="linktext" value="${inline.LogoLink.value.Text.isSet ? inline.LogoLink.value.Text : ''}" />
        <div class="head-inline">
        <div class="container"><div class="row"><div class="col-xs-12">
            <apollo:link link="${inline.LogoLink}" settitle="true">
                <c:choose>
                    <c:when test="${inline.LogoFullWidth.toBoolean}">
                        <img src="<cms:link>${inline.LogoImage}</cms:link>" alt="${linktext}" class="img-responsive" />
                    </c:when>
                    <c:otherwise>
                        <c:if test="${not inline.LogoFullWidth.toBoolean}">
                            <c:if test="${inline.LogoWidth.isSet}">
                                <c:set var="logoWidth"> width="${inline.LogoWidth}"</c:set>
                            </c:if>
                            <c:if test="${inline.LogoHeight.isSet}">
                                <c:set var="logoHeight"> height="${inline.LogoHeight}"</c:set>
                            </c:if>
                            <c:if test="${empty logoWidth && empty logoHeight}">
                                <c:set var="logoWidth"> width="250"</c:set>
                            </c:if>
                        </c:if>
                        <img src="<cms:link>${inline.LogoImage}</cms:link>" alt="${linktext}"${logoWidth}${logoHeight} alt="" />
                    </c:otherwise>
                </c:choose>
            </apollo:link>
        </div></div></div>
        </div>
    </c:if>

    <div class="head-toggle container">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="fa fa-bars"></span>
        </button>
    </div>

    <apollo:nav-items
        type="forSite"
        content="${content}"
        currentPageFolder="${cms.requestContext.folderUri}"
        currentPageUri="${cms.requestContext.uri}"
        var="nav">

        <%-- Set mega menu variables --%>
        <apollo:megamenu test="none" />

        <c:set var="navLength" value="${fn:length(nav.items) - 1}" />
        <div class="head-navbar">
        <div class="collapse navbar-collapse mega-menu navbar-responsive-collapse">
        <div class="container">

        <ul class="nav navbar-nav">
        <c:forEach var="i" begin="0" end="${navLength}" >

            <c:set var="navElem" value="${nav.items[i]}" />
            <c:set var="nextLevel" value="${i < navLength ? nav.items[i+1].navTreeLevel : navStartLevel}" />
            <c:set var="startSubNav" value="${nextLevel > navElem.navTreeLevel}" />
            <c:set var="isFirstLevel" value="${navElem.navTreeLevel eq navStartLevel}" />
            <c:set var="nextIsFirstLevel" value="${nextLevel eq navStartLevel}" />

            <c:set var="isCurrentPage" value="${navElem.navigationLevel ?
                fn:startsWith(cms.requestContext.uri, navElem.parentFolderName) :
                fn:startsWith(cms.requestContext.uri, navElem.resourceName)}" />

            <c:set var="listType">
            ${isFirstLevel ? (nextIsFirstLevel ? '' : 'dropdown') : (startSubNav ? 'dropdown-submenu' : '')}
            ${isCurrentPage ? ' active' : ''}
            </c:set>

            <%-- ###### Check for mega menu ######--%>
            <c:set var="megaMenu" value="" />
            <c:if test="${isFirstLevel}">
                <c:set var="megaMenuVfsPath" value="${navElem.resourceName}${megamenuFilename}" />
                <c:if test="${navElem.navigationLevel}">
                    <%-- ###### Path correction needed if navLevel ###### --%>
                    <c:set var="megaMenuVfsPath" value="${fn:replace(megaMenuVfsPath, navElem.fileName, '')}" />
                </c:if>
                <c:if test="${cms.vfs.existsXml[megaMenuVfsPath]}">
                    <c:set var="megaMenuLink"><cms:link>${megaMenuVfsPath}</cms:link></c:set>
                    <c:set var="megaMenu" value=' data-menu="${megaMenuLink}"' />
                    <c:set var="listType" value="${listType} mega" />
                </c:if>
            </c:if>

            <c:set var="listType" value="${empty listType ? '' : ' class=\"'.concat(listType).concat('\"')}" />

            <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
            <c:out value='<li${listType}${megaMenu}>' escapeXml="false" />

                <c:choose>

                    <c:when test="${startSubNav}">

                        <%-- Output the start of a new sub-navigation level --%>
                        <c:out value='<a href="${navLink}"' escapeXml="false" />
                        <c:if test="${isFirstLevel}">
                            <c:out value=' class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"' escapeXml="false" />
                        </c:if>
                        <c:out value='>${navElem.navText}</a>' escapeXml="false" />
                        <c:out value='<ul class="dropdown-menu">' escapeXml="false" />

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

            <li id="searchButtonHeader">
                <i class="search fa fa-search search-btn"></i>
                <div class="search-open">
                    <form class="form-inline" name="searchFormHeader" action="${cms.functionDetail['Search page']}" method="post">
                        <div class="input-group animated fadeInDown" id="searchContentHeader">
                            <input type="text" name="q" class="form-control" placeholder="Search" id="searchWidgetAutoCompleteHeader" />
                            <span class="input-group-btn">
                                <button class="btn" type="button" onclick="this.form.submit(); return false;">Go</button>
                            </span>
                        </div>
                    </form>
                </div>
            </li>
        </ul>
    </div>
    </div>
    </div>
    </apollo:nav-items>

</div>

<c:set var="showbreadcrumb">
    <c:out value="${cms.element.settings.showbreadcrumb}" default="true" />
</c:set>
<c:if test="${showbreadcrumb == 'true'}">
<div class="breadcrumbs">
    <div class="container">

        <h1 class="pull-left">
            ${cms.title}
            <c:if test="${cms.isEditMode}">
                <span class="badge badge-user">${cms.requestContext.currentUser.name}</span>
                <span class="badge badge-screensize"><span class="apollo-grid-info"></span></span>
            </c:if>
        </h1>

        <apollo:nav-items
            type="breadCrumb"
            content="${content}"
            currentPageFolder="${cms.requestContext.folderUri}"
            currentPageUri="${cms.requestContext.uri}"
            var="nav">

            <ul class="pull-right breadcrumb">
                <c:forEach items="${nav.items}" var="navElem" varStatus="status">
                    <c:set var="navText">${navElem.navText}</c:set>
                    <c:if test="${empty navText or fn:contains(navText, '??? NavText')}">
                        <c:set var="navText">${navElem.title}</c:set>
                    </c:if>
                    <c:if test="${!empty navText}">
                        <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
                        <c:out value='<li><a href="${navLink}">${navText}</a></li>${nl}' escapeXml="false" />
                    </c:if>
                </c:forEach>
            </ul>
        </apollo:nav-items>

    </div>
</div>

</c:if>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>