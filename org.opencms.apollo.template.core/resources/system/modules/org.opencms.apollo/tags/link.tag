<%@ tag
    display-name="link"
    body-content="scriptless"
    trimDirectiveWhitespaces="true"
    description="Displays a link from the generic Apollo nested link content.
    Perfroms all checks to make sure the link is correctly set.
    Also honors the 'open in new window' flag." %>


<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The link to format. Must be a generic Apollo nested link content."%>

<%@ attribute name="linktext" type="java.lang.String" required="false"
    description="Text shown in the link if body of tag is empty."%>

<%@ attribute name="settitle" type="java.lang.Boolean" required="false"
    description="If 'true' then a title attribute is added to the generated link with the given linktext."%>

<%@ attribute name="cssclass" type="java.lang.String" required="false"
    description="CSS class added to the generated link tag"%>

<%@ attribute name="style" type="java.lang.String" required="false"
    description="CSS inline styles added to the generated link tag"%>

<%@ attribute name="attr" type="java.lang.String" required="false"
    description="Attribute added directly to the generated link tag."%>

<%@ attribute name="test" type="java.lang.String" required="false"
    description="Can be used to defer the decision to actually create the markup around the body to the calling element.
    If not set or 'true', the markup from this tag is generated around the body of the tag.
    Otherwise everything is ignored and just the body of the tag is returned. "%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%-- ####### Assign JSP body to a variable, we need to check if this is empty ######## --%>
<jsp:doBody var="bodyVal" />

<c:choose>
    <c:when test="${link.isSet and link.value.URI.isSet and (empty test or test)}">
        <a href="<cms:link>${link.value.URI}</cms:link>"
            <c:if test="${not empty cssclass}">${' '}class="${cssclass}"</c:if>
            <c:if test="${not empty style}">${' '}style="${style}"</c:if>
            <c:if test="${not empty attr}">${' '}${attr}"</c:if>
            <c:if test="${not empty settitle and settitle and link.value.Text.isSet}">${' '}title="${link.value.Text}"</c:if>
            <c:if test="${link.value.NewWindow.isSet and link.value.NewWindow == 'true'}">${' '}target="_blank"</c:if>
            <c:if test="${empty bodyVal and link.value.Text.isSet}">${' '}${link.rdfa.Text}</c:if>
        ><%--
        --%><c:choose>
                <c:when test="${empty bodyVal and link.value.Text.isSet}">
                    ${link.value.Text}<%--
            --%></c:when>
                <c:when test="${empty bodyVal}">
                    <c:if test="${empty linktext}">
                        <fmt:setLocale value="${cms.locale}" />
                        <cms:bundle basename="org.opencms.apollo.template.core.messages">
                            <c:set var="linktext"><fmt:message key="apollo.link.frontend.more" /></c:set>
                        </cms:bundle>
                    </c:if>
                    ${linktext}<%--
            --%></c:when>

                <%-- ####### JSP body inserted here ######## --%>
                <c:otherwise>${bodyVal}</c:otherwise>
                <%-- ####### /JSP body inserted here ######## --%>
            </c:choose>
        </a>
    </c:when>

    <%-- ####### JSP body inserted here ######## --%>
    <c:otherwise>${bodyVal}</c:otherwise>
    <%-- ####### /JSP body inserted here ######## --%>

</c:choose>