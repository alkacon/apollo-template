<%@ tag
    display-name="nav-items"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Loads navigation items based on a XML content configuration." %>


<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true"
    description="The navigation XML content configuration."%>

<%@ attribute name="currentPageUri" type="java.lang.String" required="true"
    description="The requested page URI."%>

<%@ attribute name="currentPageFolder" type="java.lang.String" required="true"
    description="The requested page folder URI."%>

<%@ attribute name="type" type="java.lang.String" required="true"
    description="The type of navigation to create. Valid values are 'forSite', 'forFolder' and 'breadCrumb'"%>

<%@ attribute name="var" type="java.lang.String" required="true"
    description="The variable name to store the result items in."%>


<%@ variable name-given="navStartLevel" declare="true"
    description="The start fodler level for the navigation." %>

<%@ variable name-given="navDepth" declare="true"
    description="The depth of the navigation." %>

<%@ variable name-given="navStartFolder" declare="true"
    description="The start folder of the navigation." %>

<%@ variable name-given="nav" declare="true"
    description="The calulated nagivation items." %>

<%@ variable name-given="nl" declare="true"
    description="A new line for output using c:out." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="nl" value="
" />

<c:set var="navStartLevel" value="${content.value.NavStartLevel.toInteger < 0 ? 0 : content.value.NavStartLevel.toInteger}" />
<c:set var="navDepth" value="${content.value.NavDepth.isSet ? (content.value.NavDepth.toInteger < 0 ? 0 : content.value.NavDepth.toInteger) : 3}" />
<c:set var="endLevel" value="${navStartLevel + navDepth - 1}" />
<c:if test="${type eq 'breadCrumb'}">
    <c:set var="endLevel" value="-1" />
    <c:set var="navStartLevel" value="${navStartLevel + 1}" />
</c:if>

<c:set var="navStartFolder" value="/" />
<c:if test="${content.value.NavFolder.isSet}" >
    <c:choose>
    <c:when test="${fn:endsWith(content.value.NavFolder.toString.concat('X'), '/X')}">
        <c:set var="navStartFolder" value="${content.value.NavFolder.toString}" />
    </c:when>
    <c:otherwise>
        <c:set var="navStartFolder" value="INVALID" />
    </c:otherwise>
    </c:choose>
</c:if>

<c:if test="${navStartFolder ne 'INVALID'}">

    <c:choose>
        <c:when test="${type eq 'forSite'}">
            <c:set var="pathparts" value="${fn:split(currentPageFolder, '/')}" />
            <c:forEach var="folderName" items="${pathparts}" varStatus="status">
                <c:if test="${status.count <= navStartLevel}">
                    <c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
                </c:if>
            </c:forEach>
        </c:when>
        <c:when test="${type eq 'breadCrumb'}">
            <c:set var="navStartFolder" value="${currentPageFolder}" />
        </c:when>
    </c:choose>

    <cms:navigation
        type="${type}"
        resource="${navStartFolder}"
        startLevel="${navStartLevel}"
        endLevel="${endLevel}"
        locale="${cms.locale}"
        param="true"
        var="nav" />
</c:if>

<c:choose>

<c:when test="${(navStartFolder ne 'INVALID') and fn:length(nav.items) > 0}">
<%-- Only output the tag body in case we have found some navigation items --%>
<jsp:doBody/>
</c:when>

<c:otherwise>
<%-- Output HTML debug comment --%>
<!--
No navigation items found in selected folder!

type="${type}"
currentPageFolder="${currentPageFolder}"
currentPageUri="${currentPageUri}"
content.value.NavFolder="${content.value.NavFolder}"
navStartFolder="${navStartFolder}"
navStartLevel="${navStartLevel}"
endLevel="${endLevel}"
navDepth="${navDepth}"
locale="${cms.locale}"
 -->
</c:otherwise>

</c:choose>

