<%@ tag
    display-name="nav-breadcrump"
    trimDirectiveWhitespaces="true"
    description="Generates the navigation breadcrumps." %>

<%@ attribute name="startlevel" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The start level of the navigation."%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="slevel" value="${startlevel.toInteger < 1 ? 1 : startlevel.toInteger}" />

<cms:navigation type="breadCrumb" startLevel="${slevel}" endLevel="-1" var="nav" param="true" />

<ul class="pull-right breadcrumb">
    <c:forEach items="${nav.items}" var="navElem" varStatus="status">
        <c:set var="navText">${navElem.navText}</c:set>
        <c:if test="${empty navText or fn:contains(navText, '??? NavText')}">
            <c:set var="navText">${navElem.title}</c:set>
        </c:if>
        <c:if test="${!empty navText}">
            <li><a href="<cms:link>${navElem.resourceName}</cms:link>">${navText}</a></li>
        </c:if>
    </c:forEach>
</ul>