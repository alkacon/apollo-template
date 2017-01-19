<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<fmt:setLocale value="${cms.locale}" />
<!DOCTYPE html>
<html lang="${cms.locale}">
<head>

<c:set var="containerName" value="apollo-page" scope="request" /> <%-- Standard container name (can be modified by megamenu) --%>
<c:set var="containerTypes" value="area" scope="request" /> <%-- Standard container types (can be modified by megamenu) --%>

<apollo:megamenu test="isTemplateRequest">
    <c:set var="titleprefix"><cms:property name="apollo.title.prefix" file="search" default="" /></c:set>
    <c:set var="titlesuffix"><cms:property name="apollo.title.suffix" file="search" default="" /></c:set>

    <meta charset="${cms.requestContext.encoding}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<cms:property name="Description" file="search" default="" />">
    <meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />">
    <meta name="robots" content="index, follow">
    <meta name="revisit-after" content="7 days">

    <title>${titleprefix}${not empty titleprefix ? ' ':''}${cms.title}${not empty titlesuffix ? ' ':''}${titlesuffix}</title>

    <c:set var="faviconPath">${cms.subSitePath}favicon.png</c:set>
    <c:if test="${not cms.vfs.existsResource[faviconPath]}">
    <c:set var="faviconPath">/system/modules/org.opencms.apollo.theme/resources/img/favicon_120.png</c:set>
    </c:if>

    <link rel="apple-touch-icon" href="<cms:link>${faviconPath}</cms:link>" />
    <link rel="icon" href="<cms:link>${faviconPath}</cms:link>" type="image/png" />

    <cms:enable-ade />
    <cms:headincludes type="css" />

    <c:set var="theme"><cms:property name="apollo.theme" file="search" default="red" /></c:set>
    <c:choose>
      <c:when test="${fn:endsWith(theme, 'ap-includes.jsp')}">
          <cms:include file="${theme}" />
      </c:when>
      <c:otherwise>
          <c:if test="${not fn:startsWith(theme, '/')}">
             <c:set var="theme">/system/modules/org.opencms.apollo.theme/resources/css/style-${theme}.min.css</c:set>
          </c:if>
            <link rel="stylesheet" href="<cms:link>${theme}</cms:link>" />
      </c:otherwise>
    </c:choose>

    <c:set var="extraHead"><cms:property name="apollo.template.head" file="search" default="" /></c:set>
    <c:if test="${not empty extraHead}"><cms:include file="${extraHead}" /></c:if>

    <c:out value="</head>" escapeXml="false" />
    <c:out value="<body>" escapeXml="false" />
</apollo:megamenu>

<c:if test="${cms.isEditMode}">
    <!--=== Placeholder for OpenCms toolbar in edit mode ===-->
    <div id="toolbar-placeholder"></div>
</c:if>

<apollo:megamenu>
    <%-- Values containerName and containerTypes are defined by the mega menu tag --%>
    <cms:container
        name="${requestScope.containerName}"
        type="${requestScope.containerTypes}"
        width="1200"
        maxElements="50"
        editableby="ROLE.DEVELOPER">

        <cms:bundle basename="org.opencms.apollo.template.core.messages">
            <c:set var="message"><fmt:message key="apollo.page.text.emptycontainer" /></c:set>
        </cms:bundle>

        <apollo:container-box
            label="${message}"
            boxType="container-box"
            type="area"
            role="ROLE.DEVELOPER"
        />
    </cms:container>
</apollo:megamenu>

<apollo:megamenu test="isTemplateRequest">
    <%-- Page information transfers OpenCms state information to JavaScript --%>
    <apollo:pageinfo />

    <%-- JavaScript files placed at the end of the document so the pages load faster --%>
    <cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/org.opencms.apollo.theme/resources/js/scripts-all.min.js:0fc90357-5155-11e5-abeb-0242ac11002b)" />
    <script type="text/javascript">
        jQuery(document).ready(function() {
          Apollo.init();
        });
    </script>

    <c:set var="afoot"><cms:property name="apollo.template.foot" file="search" default="" /></c:set>
    <c:if test="${not empty afoot}">
        <cms:include file="${afoot}" />
    </c:if>
</apollo:megamenu>

</body>
</html>
