<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.event">

<cms:formatter var="content" val="value">
	<c:set var="inMemoryMessage"><fmt:message key="apollo.event.message.edit" /></c:set>
	<apollo:init-messages textnew="${inMemoryMessage}">

		<div class="row ap-sec ap-event">
			<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
			<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
			<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
			<c:set var="calendarColor" value="${cms.element.settings.calendarcolor}" />
			<c:set var="displayOption" value="${cms.element.settings.compactform}" />
            <c:set var="showDate" value="${cms.element.settings.showdate}" />
			<c:set var="showImageBig" value="${paragraph.value.Image.exists && (displayOption == 'big')}" />
			<c:set var="showImageSmall" value="${paragraph.value.Image.exists && (displayOption == 'small')}" />
			<c:set var="isCompactForm" value="${displayOption != 'false' && !showImageSmall}" />

			<%-- ####### Show calendar or image if not compact form ######## --%>
			<c:if test="${!isCompactForm}">
				<a href="<cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link>">
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
						<c:out value="${imgDivStart}" escapeXml="false" />
						<apollo:image-simple onlyimage="true" image="${paragraph.value.Image}" />
					</c:when>
					</c:choose>
					</div>
				</a>
			</c:if>

			<%-- ####### Render Teaser-Text and optional image, if set accordingly ######## --%>
			<div class="col-xs-12 col-sm-${isCompactForm ? '12' : '9'} col-lg-${isCompactForm ? '12' : '10'}">

				<c:if test="${showImageBig}">
					<c:out value="${imgDivStart}" escapeXml="false" />
					<c:set var="imgLink"><cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link></c:set>
					<a href="${imgLink}"><apollo:image-simple onlyimage="true" image="${paragraph.value.Image}" /></a>
				</c:if>

				<c:set var="text">${content.value.Teaser}</c:set>
				<c:if test="${empty text}"><c:set var="text">${paragraph.value.Text}</c:set></c:if>
				<c:set var="href"><cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link></c:set>

				<c:set var="buttonText"><fmt:message key="apollo.event.message.readmore" /></c:set>
				<apollo:teaserbody 
                    text="${text}"
                    textlength="${teaserLength}"
                    title="${content.value.Title}"
                    href="${href}" 
                    date="${content.value.Date}" 
                    enddate="${content.value.EndDate}"
                    showdate="${showDate}"
                    color="${buttonColor}"
                    btntext="${buttonText}"
                />

			</div>

		</div>
	</apollo:init-messages>
</cms:formatter>
</cms:bundle>
