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
		<c:set var="paragraph" value="${content.valueList.Introduction['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
		
		<%-- ####### Render Teaser-Text and optional image, if set accordingly ######## --%>
		<div class="col-xs-12">
			<h2>
				<a href="<cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
			</h2>

            <c:if test="${(cms.element.setting.showdate.exists and cms.element.settings.showdate) or cms.element.setting.showdate.isEmpty}">
			<p>
				<i>
					<fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" />
					<c:if test="${content.value.Location.isSet}">
						- ${content.value.Location}
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
			<a href="<cms:link baseUri="${cms.element.settings.pageUri}">${content.filename}</cms:link>" class="btn ap-btn-${buttonColor}">
				<fmt:message key="apollo.list.message.readmore" />
			</a>
		</div>

</div>
</cms:formatter>
</cms:bundle>
