<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<cms:formatter var="content" val="value">

	<div class="row ap-sec ap-event">
		<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
		<c:set var="calendarColor" value="${cms.element.settings.calendarcolor}" />
		<c:set var="compactForm" value="${cms.element.settings.compactform}" />
		<c:set var="showImageBig" value="${paragraph.value.Image.exists && (compactForm == 'big')}" />
		<c:set var="showImageSmall" value="${paragraph.value.Image.exists && (compactForm == 'small')}" />
		<c:set var="isCompactForm" value="${cms.element.settings.compactform != 'false' && !showImageSmall}" />

		<%-- ####### Show calendar or image if not compact form ######## --%>
		<c:if test="${!isCompactForm}">
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
				<div class="col-sm-3 col-lg-2 hidden-xs">
				<c:choose>
				<%-- ####### Show calendar ######## --%>
				<c:when test="${!showImageSmall}">
					<div class="date-${calendarColor} ap-event-cal">
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
				</c:when>
				<%-- ####### Show small image in place of calendar ######## --%>
				<c:when test="${showImageSmall}">
					<c:set var="copyright">${paragraph.value.Image.value.Copyright}</c:set>
					<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)" %>

					<c:out value="${imgDivStart}" escapeXml="false" />

					<cms:img src="${paragraph.value.Image.value.Image}"
						width="300" cssclass="img-responsive" scaleColor="transparent" scaleType="0" noDim="true"
						alt="${paragraph.value.Image.value.Title}${' '}${copyright}"
						title="${paragraph.value.Image.value.Title}${' '}${copyright}" />
				</c:when>
				</c:choose>
				</div>
			</a>
		</c:if>
		
		<%-- ####### Render Teaser-Text and optional image, if set accordingly ######## --%>
		<div class="col-xs-12 col-sm-${isCompactForm ? '12' : '9'} col-lg-${isCompactForm ? '12' : '10'}">

			<c:if test="${showImageBig}">
				<c:set var="copyright">${paragraph.value.Image.value.Copyright}</c:set>
				<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)" %>

				<c:out value="${imgDivStart}" escapeXml="false" />

				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
					<cms:img src="${paragraph.value.Image.value.Image}"
						width="800" cssclass="img-responsive" scaleColor="transparent" scaleType="0" noDim="true"
						alt="${paragraph.value.Image.value.Title}${' '}${copyright}"
						title="${paragraph.value.Image.value.Title}${' '}${copyright}" />
				</a>
			</c:if>

			<h2>
				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
			</h2>

			<c:set var="showdate"><c:out value="${cms.element.settings.showDate}" default="true" /></c:set>
			<c:if test="${showdate}">
				<p>
					<i>
						<fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
						<c:if test="${content.value.EndDate.exists}">
								-&nbsp;
								<fmt:formatDate value="${cms:convertDate(content.value.EndDate)}" dateStyle="LONG" timeStyle="SHORT" type="both" />
						</c:if>
					</i>
				</p>
			</c:if>

			<c:choose>
				<c:when test="${content.value.Teaser.isSet and not empty fn:trim(content.value.Teaser)}">
					<p>${content.value.Teaser}</p>
				</c:when>
				<c:otherwise>
					<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
				</c:otherwise>
			</c:choose>

			<div class="margin-bottom-10"></div>
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>" class="btn ap-btn-${buttonColor}">
				<fmt:message key="apollo.list.message.readmore" />
			</a>
		</div>

</div>
</cms:formatter>
</cms:bundle>
