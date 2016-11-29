<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />

<cms:bundle basename="org.opencms.apollo.template.navigation.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">
  <div class="ap-header">

    <c:set var="inMemoryMessage"><fmt:message key="apollo.navigation.message.new" /></c:set>
    <apollo:init-messages textnew="${inMemoryMessage}" />
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
									<c:set var="logoWidth">width="${inline.LogoWidth}"</c:set>
								</c:if>
								<c:if test="${inline.LogoHeight.isSet}">
									<c:set var="logoHeight"> height="${inline.LogoHeight}"</c:set>
								</c:if>
								<c:if test="${empty logoWidth && empty logoHeight}">
									<c:set var="logoWidth">width="250"</c:set>
								</c:if>
							</c:if>
                            <img src="<cms:link>${inline.LogoImage}</cms:link>" alt="${linktext}" ${logoWidth} ${logoHeight} alt="" />
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

        <div class="head-navbar">
            <apollo:nav-head
                folderUri="${cms.requestContext.folderUri}" 
                pageUri="${cms.requestContext.uri}" 
                startlevel="${value.NavStartLevel}" 
            />
        </div>

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
                </c:if>
            </h1>
            <apollo:nav-breadcrumb startlevel="${value.NavStartLevel}" />

        </div>
    </div>

    </c:if>

  </div>
</cms:formatter>
</cms:bundle>