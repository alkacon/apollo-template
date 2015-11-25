<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<a
	href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
	<cms:include
		page="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)">
		<cms:param name="copyright">${paragraph.value.Image.value.Copyright}</cms:param>
	</cms:include> <c:if test="${paragraph.value.Image.exists}">
		<div class="col-md-4 search-img">
			<cms:img src="${paragraph.value.Image.value.Image}" width="800"
				cssclass="img-responsive" scaleColor="transparent" scaleType="0"
				noDim="true" alt="${paragraph.value.Image.value.Title} ${copyright}"
				title="${paragraph.value.Image.value.Title}  ${copyright}" />
		</div>
	</c:if>
</a>

<div class="col-md-8">
	<h2>
		<a
			href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
	</h2>
	<c:set var="showdate">
		<c:out value="${param.showDate}" default="true" />
	</c:set>
	<c:if test="${showdate}">
		<p>
			<i><fmt:formatDate value="${cms:convertDate(content.value.Date)}"
					dateStyle="LONG" timeStyle="SHORT" type="both" /> <c:if
					test="${content.value.EndDate.exists}">
											 	-&nbsp;<fmt:formatDate
						value="${cms:convertDate(content.value.EndDate)}" dateStyle="LONG"
						timeStyle="SHORT" type="both" />
				</c:if> </i>
		</p>
	</c:if>
	<c:choose>
		<c:when
			test="${content.value.Teaser.isSet and not empty fn:trim(content.value.Teaser)}">
			<p>${content.value.Teaser}</p>
		</c:when>
		<c:otherwise>
			<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
		</c:otherwise>
	</c:choose>
	<div class="margin-bottom-10"></div>
	<a
		href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>"
		class="btn-u btn-u-${buttonColor}"><fmt:message
			key="apollo.list.message.readmore" /></a>
</div>