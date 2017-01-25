<%@ tag
    display-name="icon-prefix"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Displays a text label with optional icon based on the Font-Awesome library." %>


<%@ attribute name="icon" type="java.lang.String" required="true"
    description="The icon to show. Taken from the Font-Awesome library." %>

<%@ attribute name="text" required="false" fragment="true"
    description="The text label to show." %>

<%@ attribute name="icontitle" required="false" fragment="true"
    description="The title attribute to add to the icon. Uses the value of 'text' if not set." %>

<%@ attribute name="fragments" type="java.lang.String" required="true"
    description="The label fragments to show.
    Possible values are [
    icon: Show the icon.
    text: Show the text.
    ]" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<c:if test="${((not empty icon) and ('none' ne icon)) or (not empty text)}">

<c:set var="iconlabel"><jsp:invoke fragment='icontitle' /></c:set>
<c:if test="empty iconlabel">
    <c:set var="iconlabel"><jsp:invoke fragment='text' /></c:set>
</c:if>
<span class="ap-icon-label"><%--
--%><c:if test="${fn:contains(fragments, 'icon')}">
        <i class="fa fa-${icon}" title="${iconlabel}"></i><%--
--%></c:if>
    <c:if test="${fn:contains(fragments, 'text')}">
        <jsp:invoke fragment='text' /><%--
--%></c:if>
</span><%--

--%></c:if>