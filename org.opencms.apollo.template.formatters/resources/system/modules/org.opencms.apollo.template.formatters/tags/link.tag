<%@ tag 
    display-name="link"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Shows the link for the generic Apollo nested link content." %>

<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %> 
<%@ attribute name="linkclass" type="java.lang.String" required="false" %>
<%@ attribute name="linktext" type="java.lang.String" required="false" %>
<%@ attribute name="style" type="java.lang.String" required="false" %>
<%@ attribute name="settitle" type="java.lang.Boolean" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:doBody var="bodyVal" />

<c:choose>
    <c:when test="${link.isSet}">
        <a href="<cms:link>${link.value.URI}</cms:link>"
                <c:if test="${not empty linkclass}">${' '}class="${linkclass}"</c:if>
                <c:if test="${not empty style}">${' '}style="${style}"</c:if>
                <c:if test="${not empty settitle and settitle and link.value.Text.isSet}">${' '}title="${link.value.Text}"</c:if>
                <c:if test="${link.value.NewWindow.isSet and link.value.NewWindow == 'true'}">${' '}target="_blank"</c:if>
                <c:if test="${empty bodyVal and link.value.Text.isSet}">${' '}${link.rdfa.Text}</c:if>
        >
            <c:choose>
                <c:when test="${empty bodyVal and link.value.Text.isSet}">
                    ${link.value.Text}
                </c:when>
                <c:when test="${empty bodyVal}">
                    <c:if test="${empty linktext}">
                        <fmt:setLocale value="${cms.locale}" />
                        <cms:bundle basename="org.opencms.apollo.template.formatters.messages">
                            <c:set var="linktext">"><fmt:message key="apollo.link.frontend.more" /></c:set>
                        </cms:bundle>
                    </c:if>
                    ${linktext}
                </c:when>
                <c:otherwise>
                    ${bodyVal}
                </c:otherwise>
            </c:choose>
        </a>
    </c:when>
    <c:otherwise>
        ${bodyVal}
    </c:otherwise>
</c:choose>