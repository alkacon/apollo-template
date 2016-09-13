<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo"%>

<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />

<cms:formatter var="content" val="value">
	<cms:bundle basename="org.opencms.apollo.template.job.messages">
		<c:set var="inMemoryMessage"><fmt:message key="apollo.job.message.inmemory" /></c:set>
	</cms:bundle>
	<apollo:init-messages textnew="${inMemoryMessage}">

		<div class="row ap-sec ap-event">
			<c:set var="paragraph" value="${content.valueList.Introduction['0']}" />
			<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
			<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
            <c:set var="showDate" value="${cms.element.settings.showdate}" />

			<%-- ####### Render Teaser-Text and optional image, if set accordingly ######## --%>
			<div class="col-xs-12">

				<c:set var="href"><cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link></c:set>
				<c:set var="text">${content.value.Teaser}</c:set>
				<c:if test="${empty text}"><c:set var="text">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</c:set></c:if>

				<cms:bundle basename="org.opencms.apollo.template.formatters.list">
                    <apollo:teaserbody
                        text="${text}" 
                        textlength="${teaserLength}"
                        title="${content.value.Title}"
                        href="${href}" 
                        date="${content.value.Date}"
                        showdate="${showDate}"
                        color="${buttonColor}"
                    />
				</cms:bundle>

			</div>

		</div>
	</apollo:init-messages>		
</cms:formatter>
