<%@ tag
    display-name="pageinfo"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Generates a DIV with runtime information that can be used from JavaScipt." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%-- Google Maps API key --%>
<c:set var="googleMapKey"><cms:property name="google.apikey" file="search" default="" /></c:set>

<%-- Google Analytics ID --%>
<c:set var="googleAnalyticsId"><cms:property name="google.analytics" file="search" default="" /></c:set>

<%-- OpenCms project --%>
<c:set var ="project" value="${cms.isOnlineProject ? 'online' : 'offline'}" />

<div id="apollo-info" data-info='{<%--
    --%><c:if test="${not empty googleMapKey}">"googleMapKey":"${googleMapKey}",</c:if><%--
    --%><c:if test="${not empty googleAnalyticsId}">"googleAnalyticsId":"${googleAnalyticsId}",</c:if><%--
    --%>"project":"${project}",<%--
    --%>"locale":"${cms.locale}"<%--
--%>}'><%--

--%><div id="apollo-grid-info" class="apollo-grid-info"></div><%--

--%></div>

