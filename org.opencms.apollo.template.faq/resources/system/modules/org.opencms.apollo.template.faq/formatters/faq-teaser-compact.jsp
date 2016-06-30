<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">

<cms:formatter var="content" val="value">
	<div class="row mb-5">
		<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
		<c:set var="teaserLength" value="${cms.element.settings.teaserlength}" />
		<c:set var="buttonColor" value="${cms.element.settings.buttoncolor}" />
		<div class="col-xs-12">
			<h3 class="mb-5">
				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Question}</a>
			</h3>
			<c:choose>
				<c:when test="${teaserLength > 0}">
					<p class="mb-5">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
				</c:when>
				<c:otherwise>
					<p class="mb-5">${paragraph.value.Text}</p>
				</c:otherwise>
			</c:choose>
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>" class="btn ap-btn-xs ap-btn-${buttonColor}">
				<fmt:message key="apollo.list.message.readmore" /> 
			</a>
		</div>
	</div>
</cms:formatter>

</cms:bundle> 