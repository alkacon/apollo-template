<%@ tag display-name="teaserbody"
  body-content="empty"
  trimDirectiveWhitespaces="true"
  description="Displays the main content of a teaser element."%>


<%@ attribute name="title" type="java.lang.String" required="true"
    description="The title of the teaser element." %>

<%@ attribute name="text" type="java.lang.String" required="true"
    description="The text of the teaser element." %>

<%@ attribute name="href" type="java.lang.String" required="true"
    description="The link used in the teaser element." %>


<%@ attribute name="btntext" type="java.lang.String" required="false"
    description="An optional button label used on the link button." %>

<%@ attribute name="date" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="The date shown in the teaser." %>

<%@ attribute name="enddate" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false"
    description="The enddate shown in the teaser." %>

<%@ attribute name="showdate" type="java.lang.Boolean" required="false"
    description="Determines if the date will be shown." %>

<%@ attribute name="textlength" type="java.lang.Integer" required="false"
    description="The maximum length of the teaser. If no length given, full text will be used." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2>
    <a class="teaser-head" href="${href}">${title}</a>
</h2>

<c:set var="showdate"><c:out value="${showdate}" default="true" /></c:set>
<c:if test="${not empty date && showdate}">
    <p class="teaser-date">
        <fmt:formatDate value="${cms:convertDate(date)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
        <c:if test="${not empty enddate && enddate.exists}">
            -&nbsp;
            <fmt:formatDate value="${cms:convertDate(enddate)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
        </c:if>
    </p>
</c:if>

<c:if test="${empty textlength}"><c:set var="textlength" value="-1" /></c:if>
<p class="teaser-text">
    <c:choose>
        <c:when test="${textlength > 0}">
            ${cms:trimToSize(cms:stripHtml(text), textlength)}
        </c:when>
        <c:otherwise>
            ${text}
        </c:otherwise>
    </c:choose>
</p>

<a href="${href}" class="btn">
    <c:choose>
        <c:when test="${not empty btntext}">
            ${btntext}
        </c:when>
        <c:when test="${not empty cms.element.settings.entryButtonText}">
            <c:out value="${cms.element.settings.entryButtonText}" />
        </c:when>
        <c:otherwise>
            <fmt:setLocale value="${cms.locale}" />
            <cms:bundle basename="org.opencms.apollo.template.list.messages">
                <fmt:message key="apollo.list.message.readmore" />
            </cms:bundle>
        </c:otherwise>
    </c:choose>
</a>