<%@ tag
    display-name="linksequence"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays a link sequence, also used for folder navigation." %>


<%@ attribute name="wrapperclass" type="java.lang.String" required="true"
    description="CSS class added to the 'div' tag surrounding the link sequence." %>

<%@ attribute name="ulwrapper" type="java.lang.String" required="false"
    description="CSS class added to the 'ul' tag surrounding the link sequence." %>

<%@ attribute name="liwrapper" type="java.lang.String" required="false"
    description="CSS class added to each 'li' tag in the link sequence." %>

<%@ attribute name="iconclass" type="java.lang.String" required="true"
    description="String class used to select the icon type." %>

<%@ attribute name="title" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The title of the link sequence." %>

<%@ attribute name="links" type="java.util.List" required="true"
    description="The link entries as list. The list can contain objects of the type CmsJspContentAccessValueWrapper or CmsJspNavElement." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<div class="${wrapperclass}">

    <c:if test="${cms.element.settings.hideTitle ne 'true'}">
        <apollo:headline headline="${title}" />
    </c:if>

    <c:if test="${value.Text.isSet}">
        <div ${rdfa.Text}>${value.Text}</div>
    </c:if>

    <c:if test="${not empty ulwrapper}">
        <c:set var="ulwrapper">class="${ulwrapper}"</c:set>
    </c:if>

    <c:if test="${not empty liwrapper}">
        <c:set var="liwrapper">class="${liwrapper}"</c:set>
    </c:if>

    <ul ${ulwrapper}>
        <c:set var="isNavElement" value="false" />

        <c:forEach var="link" items="${links}" varStatus="status">

            <c:if test="${status.first}">
                <c:if test="${fn:contains(link.getClass().name, 'CmsJspNavElement')}">
                    <c:set var="isNavElement" value="true" />
                </c:if>
            </c:if>

            <li ${liwrapper}>
                <c:choose>
                    <c:when test="${isNavElement}">
                        <a href="<cms:link>${link.resourceName}</cms:link>">
                            <apollo:icon-prefix fragments="icon" icon="${iconclass}" /><%--
                        --%>${link.navText}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <apollo:link link="${link}">
                            <apollo:icon-prefix fragments="icon" icon="${iconclass}" /><%--
                        --%>${link.value.Text}
                        </apollo:link>
                    </c:otherwise>
                </c:choose>

            </li>
        </c:forEach>
    </ul>

</div>