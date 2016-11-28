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

    <div class="head ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">
    
        <div class="head-bg">
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

        <div class="container head-toggle">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                <span class="sr-only">Toggle navigation</span> 
                <span class="fa fa-bars"></span>
            </button>
        </div>

        <div class="head-navbar${cms.modelGroupPage and cms.isEditMode ? ' editor' : ''}">
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