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

		<div class="col-md-12">
			<h3 class="mb-5">
				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
			</h3>
            <div>
                <i><fmt:formatDate
                        value="${cms:convertDate(content.value.Date)}" dateStyle="LONG"
                        timeStyle="SHORT" type="both" /> <c:if
                        test="${content.value.EndDate.exists}">
                                        -&nbsp;<fmt:formatDate
                            value="${cms:convertDate(content.value.EndDate)}"
                            dateStyle="LONG" timeStyle="SHORT" type="both" />
                    </c:if> </i>
            </div>
        
            <c:choose>
				<c:when
					test="${content.value.Teaser.isSet and not empty fn:trim(content.value.Teaser)}">
					<p class="mb-5">${content.value.Teaser}</p>
				</c:when>
				<c:otherwise>
					<p class="mb-5">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
				</c:otherwise>
			</c:choose>
			<a
				href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>"
				class="btn-u btn-u-xs btn-u-${buttonColor}"><fmt:message
					key="apollo.list.message.readmore" /></a>
		</div>
	</cms:formatter>
</div>
</cms:bundle>