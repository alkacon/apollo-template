<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="org.opencms.file.*, org.opencms.jsp.*, org.opencms.main.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
    CmsObject cms = new CmsJspActionElement(pageContext, request, response).getCmsObject();
    pageContext.setAttribute("sites", OpenCms.getSiteManager().getAvailableSites(cms, false));
    pageContext.setAttribute("siteRoot", cms.getRequestContext().getSiteRoot());
%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="at.oevsv.sites">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="mb-20">

		<div class="header topheader-oevsv">

            <div class="container oevsv">
                    <!--=== Top ===-->
                    <div class="topbar">
                        <ul class="loginbar pull-right">
                            <li class="hoverSelector">
                                <i class="fa fa-globe"></i>
                                <a>ÖVSV - LANDESVERBÄNDE</a>
                                <ul class="languages hoverSelectorBlock">
                                    <c:forEach var="site" items="${sites}">
                                        <c:set var="sitePath">${fn:substringAfter(site.siteRoot, '/sites/')}</c:set>
                                        <c:set var="title"><fmt:message key="title.site.${sitePath}" /></c:set>
                                        <c:if test="${not fn:contains(title, '??')}">
                                            <c:choose>
                                                <c:when test="${site.siteRoot == siteRoot}">
                                                    <li class="active"><a href="${site.url}">${title}&nbsp;<i class="fa fa-check"></i></a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li><a href="${site.url}">${title}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                            </li>
                            <li class="topbar-devider"></li>
                            <li class="hoverSelector">
                                <i class="fa fa-key"></i>
                                <a href="<cms:link>/login/</cms:link>">Login</a>
                            </li>
                        </ul>
                        <%-- ${value.Header} --%>
                    </div>
                    <!--=== End Top ===-->
            </div>

        </div>
        
        <div class="container oevsv">
            <div class="row">
            <div class="col-xs-12">
            <a href="<cms:link>${value.LogoLink}</cms:link>">
                <img src="<cms:link>${value.LogoImage}</cms:link>" alt="" class="img-responsive">
            </a> 
            </div>
            </div>
        </div>
        
        <div class="header">
			<div class="container oevsv">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-responsive-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="fa fa-bars"></span>
				</button>
			</div>
			<!--/end container-->

			<!-- Menu -->
			<cms:include
				file="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/nav-main.jsp:f94e9fdc-5606-11e5-b868-0242ac11002b)">
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
							<span class="badge badge-dark-blue rounded superscript">${cms.requestContext.currentUser.name}</span>
						</c:if>
					</h1>
					<cms:include
						file="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/nav-breadcrumb.jsp:f93dafe7-5606-11e5-b868-0242ac11002b)">
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