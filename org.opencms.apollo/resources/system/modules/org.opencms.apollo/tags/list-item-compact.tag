<%@ tag 
    display-name="list-item-compact"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a compact list item from the given content" %>

<%@ attribute name="date" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="datetype" type="java.lang.String" required="false" %>
<%@ attribute name="enddate" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="filename" type="java.lang.String" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="location" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="teaser" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="text" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="trimteaser" type="java.lang.Boolean" required="false" %>
<%@ attribute name="btntext" type="java.lang.String" required="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:if test="${empty datetype}"><c:set var="datetype" value="both" /></c:if>
<c:if test="${empty trimteaser}"><c:set var="trimteaser" value="false" /></c:if>
<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<div class="row mb-5">
    <div class="col-xs-12">
        <h3 class="mb-5">
            <a href="<cms:link baseUri="${cms.element.settings.pageUri}">${filename}</cms:link>">${headline}</a>
        </h3>
        <c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
        <c:if test="${showdate and not empty date}">
            <div class="entry-date">
                <i><fmt:formatDate value="${cms:convertDate(date)}" dateStyle="LONG" timeStyle="SHORT" type="${datetype}" />
                    <c:if test="${not empty enddate and enddate.isSet}">
                        - <fmt:formatDate value="${cms:convertDate(enddate)}" dateStyle="LONG" timeStyle="SHORT" type="${datetype}" />
                    </c:if>
                    <c:if test="${not empty location and location.isSet}">
						- <span class="entry-location">${location}</span>
					</c:if>
                </i>
            </div>
        </c:if>

        <c:if test="${not empty teaser or not empty text}">
            <p class="entry-teaser mb-5">
                <c:choose>
                    <c:when test="${teaser.isSet and not empty fn:trim(teaser)}">
                        <c:choose>
                            <c:when test="${trimteaser}">
                                ${cms:trimToSize(cms:stripHtml(teaser), teaserLength)}
                            </c:when>
                            <c:otherwise>
                                ${teaser}
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        ${cms:trimToSize(cms:stripHtml(text), teaserLength)}
                    </c:otherwise>
                </c:choose>
            </p>
        </c:if>

        <a href="<cms:link baseUri="${cms.element.settings.pageUri}">${filename}</cms:link>" class="btn ap-btn-xs ap-btn-${buttonColor}">
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
</div>
 
</cms:bundle>