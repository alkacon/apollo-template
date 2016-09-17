<%@ tag 
    display-name="icon-prefix"
    trimDirectiveWhitespaces="true" 
    description="Formats contact information from the given content in hCard microformat" %>

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

<%@ attribute name="attributes" required="false" fragment="true"
    description="Optional attributes to add to the generated SPAN element." %>

<%@ attribute name="test" type="java.lang.String" required="false"
    description="Can be used to defer the decision to actually create the markup around the body to the calling element.
    If not set or 'true', the markup from this tag is generated around the body of the tag.
    Otherwise everything is ignored and just the body of the tag is returned. "%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="iconlabel"><jsp:invoke fragment='icontitle' /></c:set>
<c:if test="empty iconlabel">
    <c:set var="iconlabel"><jsp:invoke fragment='text' /></c:set>
</c:if>
<span class="ap-icon-label">
    <c:if test="${fn:contains(fragments, 'icon')}">
        <i class="fa fa-${icon}" title="${iconlabel}"></i>
    </c:if>
    <c:if test="${fn:contains(fragments, 'text')}">
        <jsp:invoke fragment='text' />
    </c:if>
</span>