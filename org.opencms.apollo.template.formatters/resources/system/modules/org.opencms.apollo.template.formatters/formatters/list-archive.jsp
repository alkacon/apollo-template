<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<div>
			
			${cms.reloadMarker}
			<c:choose>
				<c:when test="${cms.element.inMemoryOnly}">
					<div class="alert">
						<h3>
							<fmt:message key="apollo.list.message.new" />
						</h3>
					</div>
				</c:when>
				<c:when test="${cms.edited}">
					<div class="alert">
						<h3>
							<fmt:message key="apollo.list.message.edit" />
						</h3>
					</div>
				</c:when>
				<c:otherwise>
					<c:if test="${not cms.element.settings.hidetitle}">
						<div class="headline headline-md">
							<h2 ${rdfa.Headline}>
								<c:out value="${value.Headline}" escapeXml="false" />
							</h2>
						</div>
					</c:if>

					<c:set var="innerPageDivId">${cms.element.id}-inner</c:set>
					<c:set var="params">cssID=${innerPageDivId}</c:set>
					<c:set var="params">${params}&showDate=${cms.element.settings.showdate}</c:set>
					<c:set var="params">${params}&showExpired=${cms.element.settings.showexpired}</c:set>
					<c:set var="params">${params}&buttonColor=${cms.element.settings.buttoncolor}</c:set>
					<c:set var="params">${params}&compactForm=false</c:set>
					<c:set var="params">${params}&teaserLength=${cms.element.settings.teaserlength}</c:set>
					<c:set var="params">${params}&__locale=${cms.locale}</c:set>
					<c:set var="params">${params}&pageUri=${cms.requestContext.uri}</c:set>
					<c:set var="params">${params}&listConfig=${cms.element.sitePath}</c:set>
		
					<div class="posts lists">
						<cms:include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-archive-inner.jsp:70f48d7c-0c79-11e6-8fbd-0242ac11002b)">
							<c:forTokens items="${params}" delims="&" var="p">
								<cms:param name="${fn:split(p,'=')[0]}">${fn:split(p,'=')[1]}</cms:param>
							</c:forTokens>
						</cms:include>
					</div>

					<c:if test="${value.Link.exists}">
						<div class="mv-10"><a class="btn-u btn-u-${cms.element.settings.buttoncolor} btn-u-sm" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></div>
					</c:if>

					<c:set var="linkInnerPage"><cms:link>%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-archive-inner.jsp:70f48d7c-0c79-11e6-8fbd-0242ac11002b)</cms:link>?${params}</c:set>
					<script type="text/javascript">
						var lock = false;
						function reloadInnerList(searchStateParameters) {
							$('.spinner').show();
							$("#${innerPageDivId}").hide();
							$.get("${linkInnerPage}&"
									.concat(searchStateParameters), function(
									resultList) {
								$('.posts').html(resultList);
								$('.spinner')
										.css('animated infinite bounceOut');
							});
							$('html, body').animate(
									{
										scrollTop : $(".list-entry:first").offset().top - 100
									}, 1000);
						}
					</script>
				</c:otherwise>
			</c:choose>

		</div>
	</cms:formatter>

</cms:bundle>
