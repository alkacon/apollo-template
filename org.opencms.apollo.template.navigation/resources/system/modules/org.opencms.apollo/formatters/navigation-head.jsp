<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />

<cms:bundle basename="org.opencms.apollo.template.schemas.navigation">
<cms:formatter var="content" val="value" rdfa="rdfa">
  <div>
  
    <c:set var="inMemoryMessage"><fmt:message key="apollo.navigation.message.new" /></c:set>
    <apollo:init-messages textnew="${inMemoryMessage}" />
    
    <div class="ap-header">

      <c:if test="${not value.Header.isEmpty}">
                <div class="container">
                    <div class="topbar">${value.Header}</div>
                </div>
            </c:if>
      <div class="container <c:if test="${value.LogoFullWidth == 'true'}">ap-container-fullwidth</c:if>">

        <c:set var="logoPath">${value.LogoImage}</c:set>

                <c:choose>
                    <c:when test="${value.LogoFullWidth == 'true'}">
                        <c:if test="${not empty value.LogoLink}"><a class="ap-logo-fullwidth" href="<cms:link>${value.LogoLink}</cms:link>"></c:if>
                            <img src="<cms:link>${logoPath}</cms:link>" alt="" class="img-responsive" />
                        <c:if test="${not empty value.LogoLink}"></a></c:if>
                    </c:when>
                    <c:otherwise>
                        <c:set var="logoSizes"><cms:property name="image.size" file="${logoPath}" default="170x42" /></c:set>
                        <c:if test="${not empty logoPath}"><c:set var="backgroundLogo">background-image:url('<cms:link>${logoPath}</cms:link>');</c:set></c:if> 
                        <c:if test="${not empty value.LogoLink}"><c:set var="logoLink"><cms:link>${value.LogoLink}</cms:link></c:set></c:if>
                        <a class="ap-logo" href="${logoLink}" style="width: ${fn:substringAfter(fn:substringBefore(logoSizes,','), 'w:')}px;height: ${fn:substringAfter(logoSizes,'h:')}px;${backgroundLogo}"></a>
                    </c:otherwise>
                </c:choose>

        <button type="button" class="navbar-toggle" data-toggle="collapse"
          data-target=".navbar-responsive-collapse">
          <span class="sr-only">Toggle navigation</span> <span
            class="fa fa-bars"></span>
        </button>

      </div>
      <!--/end container-->

      <!-- Menu -->
      <cms:include
        file="%(link.weak:/system/modules/org.opencms.apollo/elements/nav-main.jsp:f94e9fdc-5606-11e5-b868-0242ac11002b)">
        <cms:param name="startlevel">${value.NavStartLevel}</cms:param>
      </cms:include>

    </div>
    <!--/header -->

    <c:set var="showbreadcrumb">
      <c:out value="${cms.element.settings.showbreadcrumb}" default="true" />
    </c:set>
    <c:if test="${showbreadcrumb == 'true'}">
      <!--=== Breadcrumbs ===-->
      <div class="breadcrumbs">
        <div class="container">
          <h1 class="pull-left">
            ${cms.title}
            <c:if test="${cms.isEditMode}">
              <span class="badge badge-user">${cms.requestContext.currentUser.name}</span>
            </c:if>
          </h1>
          <cms:include
            file="%(link.weak:/system/modules/org.opencms.apollo/elements/nav-breadcrumb.jsp:f93dafe7-5606-11e5-b868-0242ac11002b)">
            <cms:param name="startlevel">${value.NavStartLevel}</cms:param>
          </cms:include>
        </div>
        <!--/container-->
      </div>
      <!--/breadcrumbs-->
      <!--=== End Breadcrumbs ===-->
    </c:if>

  </div>
</cms:formatter>
</cms:bundle>