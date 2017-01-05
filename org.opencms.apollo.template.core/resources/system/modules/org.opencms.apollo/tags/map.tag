<%@ tag 
    display-name="map"
    trimDirectiveWhitespaces="true" 
    description="Displays a Google map" %>

<%@ attribute name="id" type="java.lang.String" required="true" 
    description="The id the map should use, usually the UID of the element." %>

<%@ attribute name="width" type="java.lang.String" required="false" 
    description="The display width of the map, must be a valid CSS unit. If not set, will use '100%' as default." %>

<%@ attribute name="height" type="java.lang.String" required="false"
    description="The display height of the map, must be a valid CSS unit. If not set, will use '400px' as default." %>

<%@ attribute name="zoom" type="java.lang.String" required="false" 
    description="The initial map zoom factor. If not set, will use '14' as default." %>

<%@ attribute name="type" type="java.lang.String" required="false" 
    description="The map type. If not set, will use 'ROADMAP' as default." %>

<%@ attribute name="centerLat" type="java.lang.String" required="false" 
    description="The center latitude of the map. If not set, will use some point in Germany default." %>

<%@ attribute name="centerLng" type="java.lang.String" required="false" 
    description="The center longitude of the map. If not set, will use some point in Germany default." %>

<%@ attribute name="coordinates" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" 
    description="This can be a map coordinate point from the Location picker widget." %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- Set map window height / width --%>
<c:set var="mapStyle" value="height:400px" />
<c:if test="${not empty height}">
    <c:set var="mapStyle">height:${height}</c:set>
</c:if>
<c:if test="${(not empty width) and (width != '100%')}">
    <c:set var="mapStyle">${mapStyle};width:${width};</c:set>
</c:if>

<%-- Set map coordinates --%>
<c:if test="${not empty coordinates}">
    <jsp:useBean id="locBean" class="org.opencms.widgets.CmsLocationPickerWidgetValue" />
    <jsp:setProperty name="locBean" property="wrappedValue" value="${coordinates}" />
    <c:set var="centerLat" value="${locBean.lat}" />
    <c:set var="centerLng" value="${locBean.lng}" />
</c:if>
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

<div 
    id="map_${id}" 
    data-map='{
        "id":"${id}",
        "zoom":"${zoom}",
        "type":"${type}",
        "centerLat":"${centerLat}",
        "centerLng":"${centerLng}"
    }'
    class="mapwindow" 
    style="${mapStyle}">
</div>