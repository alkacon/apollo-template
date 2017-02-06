<%@ tag
    display-name="map"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays a Google map." %>


<%@ attribute name="id" type="java.lang.String" required="true"
    description="The id the map should use." %>

<%@ attribute name="useGeocoding" type="java.lang.Boolean" required="true"
    description="If true, use Google geocoding API to find addresses for markers that have no address set in content.
    Will also lookup the address if only centerLat/centerLng is used with no markers." %>

<%@ attribute name="showMarkers" type="java.lang.Boolean" required="true"
    description="If true, show markers with info windows on the map." %>

<%@ attribute name="showRoute" type="java.lang.Boolean" required="false"
    description="If true, show route option for each marker in info window." %>

<%@ attribute name="width" type="java.lang.String" required="false"
    description="The display width of the map, must be a valid CSS unit. If not set, will use '100%' as default." %>

<%@ attribute name="height" type="java.lang.String" required="false"
    description="The display height of the map, must be a valid CSS unit. If not set, will use '400px' as default." %>

<%@ attribute name="zoom" type="java.lang.String" required="false"
    description="The initial map zoom factor. If not set, will use '14' as default." %>

<%@ attribute name="type" type="java.lang.String" required="false"
    description="The map type. If not set, will use 'ROADMAP' as default." %>

<%@ attribute name="centerLat" type="java.lang.String" required="false"
    description="The center latitude of the map." %>

<%@ attribute name="centerLng" type="java.lang.String" required="false"
    description="The center longitude of the map." %>

<%@ attribute name="markers" type="java.util.List" required="false"
    description="A list of map marker points from the Location picker widget." %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<%-- Set map window height / width --%>
<c:set var="mapStyle" value="height:400px" />
<c:if test="${not empty height}">
    <c:set var="mapStyle">height:${height}</c:set>
</c:if>
<c:if test="${(not empty width) and (width != '100%')}">
    <c:set var="mapStyle">${mapStyle};width:${width};</c:set>
</c:if>

<%-- Set map starting point --%>
<c:if test="${not empty markers}">
    <jsp:useBean id="locBean" class="org.opencms.widgets.CmsLocationPickerWidgetValue" />
    <jsp:setProperty name="locBean" property="wrappedValue" value="${markers[0].value.Coord}" />
    <c:set var="centerLat" value="${empty centerLat ? locBean.lat : centerLat}" />
    <c:set var="centerLng" value="${empty centerLng ? locBean.lng : centerLng}" />
</c:if>
<%-- Default location is the Brandenburg Gate in Berlin --%>
<c:if test="${empty centerLat or (centerLat == '0.0')}">
    <c:set var="centerLat" value="52.515823" />
</c:if>
<c:if test="${empty centerLng or (centerLng == '0.0')}">
    <c:set var="centerLng" value="13.3750586" />
</c:if>

<%-- Set other variable defaults --%>
<c:if test="${empty zoom}">
    <c:set var="zoom" value="14" />
</c:if>
<c:if test="${empty type}">
    <c:set var="type" value="ROADMAP" />
</c:if>

<%-- Collects all map marker groups found, this is a Map since we can not add elements to lists in EL --%>
<jsp:useBean id="markerGroups" class="java.util.HashMap" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.map.messages">

<div
    id="${id}"
    class="mapwindow"
    style="${mapStyle}"
    data-map='{<%--
    --%>"zoom":"${zoom}", <%--
    --%>"type":"${type}", <%--
    --%>"geocoding":"${useGeocoding}", <%--
    --%>"centerLat":"${centerLat}", <%--
    --%>"centerLng":"${centerLng}"<c:if test="${not empty markers and showMarkers}">,</c:if>
        <c:if test="${not empty markers and showMarkers}">
           <jsp:useBean id="coordBean" class="org.opencms.widgets.CmsLocationPickerWidgetValue" /><%--
        --%> "markers":[<%--
        --%><c:forEach var="marker" items="${markers}" varStatus="status">
                <jsp:setProperty name="coordBean" property="wrappedValue" value="${marker.value.Coord.stringValue}" />

                <c:set var="markerLat" value="${coordBean.lat}" />
                <c:set var="markerLng" value="${coordBean.lng}" />
                <c:set var="markerTitle" value="${marker.value.Caption.isEmptyOrWhitespaceOnly ? '' : fn:trim(marker.value.Caption)}" />
                <c:set var="markerGroup" value="${marker.value.MarkerGroup.isEmptyOrWhitespaceOnly ? 'default' : fn:trim(marker.value.MarkerGroup)}" />
                <c:set target="${markerGroups}" property="${markerGroup}" value="used"/>
                <c:set var="markerNeedsGeoCode" value="false" />
                <c:set var="markerAddress" value="" />
                <c:choose>
                    <c:when test="${not marker.value.Address.isEmptyOrWhitespaceOnly}">
                         <c:set var="markerAddress" value="${cms:escapeHtml(fn:trim(marker.value.Address))}" />
                    </c:when>
                    <c:when test="${useGeocoding}">
                         <c:set var="markerNeedsGeoCode" value="true" />
                         <c:set var="markerAddress" value="apolloAddr" />
                    </c:when>
                </c:choose>

                <c:if test="${showRoute}">
                    <c:set var="markerRoute">
                        <div class="route">
                            <div class="head"><fmt:message key="apollo.map.message.route" /></div>
                            <div class="message"><fmt:message key="apollo.map.message.start" /></div>
                            <form action="https://maps.google.com/maps" method="get" target="_blank">
                                <input type="text" class="form-control" size="15" maxlength="60" name="saddr" value="" />
                                <input value="<fmt:message key="apollo.map.message.route.button" />" type="submit" class="btn btn-xs">
                                <input type="hidden" name="daddr" value="${coordBean.lat},${coordBean.lng}"/>
                            </form>
                        </div>
                    </c:set>
                 </c:if>

                <c:set var="markerInfo">
                    <c:if test="${not empty markerTitle}"><h2>${markerTitle}</h2></c:if>
                    ${markerAddress}
                    ${markerRoute}
                </c:set><%--
            --%>{<%--
                --%>"lat":"${markerLat}", <%--
                --%>"lng":"${markerLng}", <%--
                --%>"geocode":"${markerNeedsGeoCode}", <%--
                --%>"title":"${cms:encode(markerTitle)}", <%--
                --%>"group":"${cms:encode(markerGroup)}", <%--
                --%>"info":"${cms:encode(markerInfo)}"<%--
            --%>}<c:if test="${not status.last}">, </c:if>
            </c:forEach><%--
        --%>]<%--
    --%></c:if><%--
--%> }'>
</div>

<c:if test="${showMarkers and fn:length(markerGroups) > 1}">
    <div class="mapbuttons">
        <button class="btn btn-sm" onclick="ApolloMap.showMarkers('${id}','showall');">
            <fmt:message key="apollo.map.message.button.showmarkers" />
        </button><%--
     --%><c:forEach var="markerGroup" items="${markerGroups}">
            <button class="btn btn-sm" onclick="ApolloMap.showMarkers('${id}', '${cms:encode(markerGroup.key)}');">
                <fmt:message key="apollo.map.message.button.show">
                    <fmt:param><c:out value="${markerGroup.key}" /></fmt:param>
                </fmt:message>
            </button><%--
     --%></c:forEach>
        <button class="btn btn-sm" onclick="ApolloMap.showMarkers('${id}', 'hideall');">
            <fmt:message key="apollo.map.message.button.hidemarkers" />
        </button>
    </div>
</c:if>

</cms:bundle>

