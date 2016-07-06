<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<cms:formatter var="content" val="value">
	<div class="row mb-10">
		<c:set var="intro" value="${content.value.Introduction.value.Text}" />
		<c:set var="paragraph" value="${content.valueList.Text['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
		<div class="col-xs-12">

			<h3 class="mb-5">
				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
			</h3>
			<div>
				<i>
					<fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" />
					<c:if test="${content.value.Location.isSet}">
						- ${content.value.Location}
					</c:if>
				</i>
			</div>

			<c:choose>
				<c:when test="${content.value.Introduction.isSet and not empty fn:trim(intro)}">
					<p class="mb-5">${cms:trimToSize(cms:stripHtml(intro), teaserLength)}</p>
				</c:when>
				<c:otherwise>
					<p class="mb-5">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
				</c:otherwise>
			</c:choose>
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>" class="btn ap-btn-xs ap-btn-${buttonColor}">
				<fmt:message key="apollo.list.message.readmore" />
			</a>
		</div>
	</div>
</cms:formatter>
</cms:bundle>
