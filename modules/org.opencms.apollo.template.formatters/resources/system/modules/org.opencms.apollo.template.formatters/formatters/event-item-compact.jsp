<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
<div>
	<cms:formatter var="content" val="value">
		<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserLength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttonColor}" />
		<c:set var="compactForm" value="${cms.element.settings.compactForm}" />

		<c:if test="${not compactForm}">
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
	
				<div class="date-dark col-sm-2 hidden-xs">
					<div class="day">
						<fmt:formatDate value="${cms:convertDate(content.value.Date)}"
							pattern="EEEE" type="date" />
					</div>
					<h3>
						<fmt:formatDate value="${cms:convertDate(content.value.Date)}"
							pattern="dd" type="date" />
					</h3>
					<div class="monthYear">
						<fmt:formatDate value="${cms:convertDate(content.value.Date)}"
							pattern="MMM yyyy" type="date" />
					</div>
				</div>
			</a>
		</c:if>
		<div class="col-sm-${compactForm ? '12' : '10'}">
			<h2>
				<a
					href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
			</h2>
			<c:set var="showdate"><c:out value="${cms.element.settings.showDate}" default="true" /></c:set>
			<c:if test="${showdate}">
				<p>
					<i><fmt:formatDate
							value="${cms:convertDate(content.value.Date)}" dateStyle="LONG"
							timeStyle="SHORT" type="both" /> <c:if
							test="${content.value.EndDate.exists}">
										 	-&nbsp;<fmt:formatDate
								value="${cms:convertDate(content.value.EndDate)}"
								dateStyle="LONG" timeStyle="SHORT" type="both" />
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
	</cms:formatter>
</div>
</cms:bundle>