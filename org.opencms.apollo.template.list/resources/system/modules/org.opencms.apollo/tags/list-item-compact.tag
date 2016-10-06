<%@ tag 
    display-name="list-item-compact"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a compact list item from the given content" %>

<%@ attribute name="filename" type="java.lang.String" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="text" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="teaser" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>

<%@ attribute name="date" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="enddate" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="datetype" type="java.lang.String" required="false" %>

<%@ attribute name="location" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="trimteaser" type="java.lang.Boolean" required="false" %>
<%@ attribute name="btntext" type="java.lang.String" required="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${empty datetype}"><c:set var="datetype" value="both" /></c:if>
<c:set var="teaserLength" value="${cms.element.settings.teaserLength}" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<div class="ap-compact ap-teaser ${cms.element.settings.cssWrapper}">

    <h3 class="teaser-head">
        <a href="<cms:link baseUri="${cms.element.settings.pageUri}">${filename}</cms:link>">${headline}</a>
    </h3>

    <c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
    <c:if test="${showdate and not empty date}">
        <div class="teaser-date">
            <fmt:formatDate value="${cms:convertDate(date)}" dateStyle="LONG" timeStyle="SHORT" type="${datetype}" />
            <c:if test="${not empty enddate and enddate.isSet}">
                - <fmt:formatDate value="${cms:convertDate(enddate)}" dateStyle="LONG" timeStyle="SHORT" type="${datetype}" />
            </c:if>
            <c:if test="${not empty location and location.isSet}">
                - <span class="teaser-location">${location}</span>
            </c:if>
        </div>
    </c:if>

    <c:if test="${not empty teaser or not empty text}">
        <c:set var="teaserText" value="${not empty teaser.toString ? teaser.toString : text.toString}" />
        <c:if test="${teaserLength > 0}">
            <c:set var="teaserText">${cms:trimToSize(cms:stripHtml(teaserText), teaserLength)}</c:set>
        </c:if>
        <div class="teaser-text">
            ${teaserText}
        </div>
    </c:if>

    <a href="<cms:link baseUri="${cms.element.settings.pageUri}">${filename}</cms:link>" class="btn teaser-btn">
        <c:choose>
            <c:when test="${not empty btntext}">
                ${btntext}
            </c:when>
            <c:otherwise>
                <fmt:message key="apollo.list.message.readmore" />
            </c:otherwise>
        </c:choose>
    </a>

</div>
 
</cms:bundle>