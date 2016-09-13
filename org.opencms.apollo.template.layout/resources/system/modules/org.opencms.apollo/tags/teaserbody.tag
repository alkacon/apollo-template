<%@ tag display-name="teaserbody"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Displays the main content of a teaser element."%>

<%@ attribute name="title" type="java.lang.String" required="true" %>
<%@ attribute name="text" type="java.lang.String" required="true" %>
<%@ attribute name="href" type="java.lang.String" required="true" %>
<%@ attribute name="color" type="java.lang.String" required="true" %>

<%@ attribute name="btntext" type="java.lang.String" required="false" %>
<%@ attribute name="date" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="enddate" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="showdate" type="java.lang.Boolean" required="false" %>
<%@ attribute name="textlength" type="java.lang.Integer" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<h2>
	<a href="<cms:link>${href}</cms:link>">${title}</a>
</h2>

<c:set var="showdate"><c:out value="${showdate}" default="true" /></c:set>
<c:if test="${not empty date && showdate}">
	<p>
		<i>
			<fmt:formatDate value="${cms:convertDate(date)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
			<c:if test="${not empty enddate && enddate.exists}">
				-&nbsp;
				<fmt:formatDate value="${cms:convertDate(enddate)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
			</c:if>
		</i>
	</p>
</c:if>

<c:if test="${empty textlength}"><c:set var="textlength" value="-1" /></c:if>
<p class="mb-10">
    <c:choose>
        <c:when test="${textlength > 0}">
            ${cms:trimToSize(cms:stripHtml(text), textlength)}
        </c:when>
        <c:otherwise>
            ${text}
        </c:otherwise>
    </c:choose>
</p>
	

<a href="<cms:link>${href}</cms:link>" class="btn ap-btn-${color}">
	<c:choose>
	<c:when test="${not empty btntext}">
		${btntext}
	</c:when>
	<c:otherwise>
		<fmt:message key="apollo.list.message.readmore" />
	</c:otherwise>
	</c:choose>
</a>