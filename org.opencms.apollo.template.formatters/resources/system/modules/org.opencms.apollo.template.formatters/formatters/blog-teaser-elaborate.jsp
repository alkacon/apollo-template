<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<cms:formatter var="content" val="value">

	<div class="row ap-sec">
		<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
		<c:set var="compactForm" value="${cms.element.settings.compactform}" />
		<c:set var="showImage" value="${paragraph.value.Image.exists && (compactForm != 'true')}" />

		<c:choose>
			<c:when test="${paragraph.value.Image.exists && (compactForm == 'false')}">
				<c:set var="imgDivStart"><div class="col-md-4 search-img"></c:set>
				<c:set var="imgDivCenter"></div><div class="col-md-8"></c:set>
				<c:set var="imgDivEnd"></div></c:set>
			</c:when>
			<c:when test="${paragraph.value.Image.exists && (compactForm == 'big')}">
				<c:set var="imgDivStart"><div class="col-xs-12"><div class="search-img"></c:set>
				<c:set var="imgDivCenter"></div><div></c:set>
				<c:set var="imgDivEnd"></div></div></c:set>
			</c:when>
			<c:otherwise>
				<c:set var="imgDivStart"></c:set>
				<c:set var="imgDivCenter"><div class="col-xs-12"></c:set>
				<c:set var="imgDivEnd"></div></c:set>
			</c:otherwise>
		</c:choose>

		<c:if test="${showImage}">
			<apollo:copyright text="${paragraph.value.Image.value.Copyright}" />

			<c:out value="${imgDivStart}" escapeXml="false" />

			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
				<cms:img src="${paragraph.value.Image.value.Image}"
					width="800" cssclass="img-responsive" scaleColor="transparent" scaleType="0" noDim="true"
					alt="${paragraph.value.Image.value.Title}${' '}${copyright}"
					title="${paragraph.value.Image.value.Title}${' '}${copyright}" />
			</a>
		</c:if>

		<c:out value="${imgDivCenter}" escapeXml="false" />

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
					<p class="mb-10">${content.value.Teaser}</p>
				</c:when>
				<c:otherwise>
					<p class="mb-10">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
				</c:otherwise>
			</c:choose>

			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>" class="btn ap-btn-${buttonColor}">
				<fmt:message key="apollo.list.message.readmore" />
			</a>

		<c:out value="${imgDivEnd}" escapeXml="false" />

	</div>

</cms:formatter>
</cms:bundle>
