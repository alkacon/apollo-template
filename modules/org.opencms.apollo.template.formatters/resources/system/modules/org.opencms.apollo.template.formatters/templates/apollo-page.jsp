<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<!DOCTYPE html>
<html lang="en">
<head>

<c:set var="titleprefix"><cms:property name="apollo.title.prefix" file="search" default="" /></c:set>
<title>${titleprefix}${not empty titleprefix ? ' ':''}${cms.title}</title>

<meta charset="${cms.requestContext.encoding}">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="<cms:property name="Description" file="search" default="" />">
<meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />">
<meta name="robots" content="index, follow">
<meta name="revisit-after" content="7 days">

<c:set var="faviconPath">${cms.subSitePath}favicon.png</c:set>
<c:if test="${not cms.vfs.existsResource[faviconPath]}">
	<c:set var="faviconPath">/system/modules/org.opencms.apollo.template.basics/resources/img/favicon_120.png</c:set>
</c:if>
<link rel="apple-touch-icon" href="<cms:link>${faviconPath}</cms:link>" />
<link rel="icon" href="<cms:link>${faviconPath}</cms:link>" type="image/png" />

<cms:enable-ade />
<cms:headincludes type="css" />

<c:set var="colortheme"><cms:property name="apollo.theme" file="search" default="red" /></c:set>
<c:if test="${not fn:startsWith(colortheme, '/')}"><c:set var="colortheme">/system/modules/org.opencms.apollo.template.basics/resources/css/style-${colortheme}.min.css</c:set></c:if>
<link rel="stylesheet" href="<cms:link>${colortheme}</cms:link>" />

<c:set var="ahead"><cms:property name="apollo.template.head" file="search" default="" /></c:set>
<c:if test="${not empty ahead}"><cms:include file="${ahead}" /></c:if>

</head>
<body>
	<div class="wrapper">
		<c:if test="${cms.isEditMode}">
			<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
			<div style="background: #fff; height: 52px;">&nbsp;</div>
		</c:if>
		<cms:container name="page-complete" type="page" width="1200" maxElements="50" editableby="ROLE.DEVELOPER"> 
            <cms:bundle basename="org.opencms.apollo.template.formatters.messages">        
                <c:set var="message"><fmt:message key="apollo.page.text.emptycontainer" /></c:set>
            </cms:bundle>
			<apollo:container-box label="${message}" boxType="container-box" type="mainsection" role="ROLE.DEVELOPER" />
		</cms:container>

	</div>
	<!--/wrapper-->

	<%-- JavaScript files placed at the end of the document so the pages load faster --%>
	<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/org.opencms.apollo.template.basics/resources/js/scripts-all.min.js:0fc90357-5155-11e5-abeb-0242ac11002b)" />
	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
			try {
				createBanner();
			} catch (e) {}
			try {
				$("#list_pagination").bootstrapPaginator(options);
			} catch (e) {}
		});
	</script>
	<!--[if lt IE 9]>
    <script src="<cms:link>%(link.weak:/system/modules/org.opencms.apollo.template.basics/resources/compatibility/respond.js:164f5662-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
    <script src="<cms:link>%(link.weak:/system/modules/org.opencms.apollo.template.basics/resources/compatibility/html5shiv.js:163824de-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
    <script src="<cms:link>%(link.weak:/system/modules/org.opencms.apollo.template.basics/resources/compatibility/placeholder-IE-fixes.js:16423700-515b-11e5-abeb-0242ac11002b)</cms:link>"></script>
	<![endif]-->
	<c:set var="afoot"><cms:property name="apollo.template.foot" file="search" default="" /></c:set>
	<c:if test="${not empty afoot}"><cms:include file="${afoot}" /></c:if>
</body>
</html>
