<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.i18n.CmsEncoder"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" rdfa="rdfa">
		<c:set var="categoryFacetField">category_exact</c:set>

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
								<c:out value="${con.value.Headline}" escapeXml="false" />
							</h2>
						</div>
					</c:if>
					<c:set var="teaserLength">${cms.element.settings.teaserlength}</c:set>
					<c:set var="buttonColor">${cms.element.settings.buttoncolor}</c:set>
					<c:set var="itemsPerPage">
						<c:out value="${con.value.ItemsPerPage}" default="100" />
					</c:set>
					<c:set var="additionalFilterQueries">${con.value.FilterQueries}</c:set>
					<c:set var="innerPageDivId">${cms.element.id}-inner</c:set>
					<c:choose>
						<c:when test="${cms.element.settings.usepagination == 'true' }">
							<c:set var="linkInnerPage">
								<cms:link>%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-inner.jsp:5ca5be42-5cff-11e5-96ab-0242ac11002b)</cms:link>
							</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="linkInnerPage">

								<cms:link>%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-dynamic-inner.jsp:bc2fedfd-76f9-11e5-904d-15b01ffdc6a6)</cms:link>
							</c:set>
						</c:otherwise>
					</c:choose>
					<div class="posts lists blog-item">
						<cms:include file="${linkInnerPage}">
							<cms:param name="cssID">${innerPageDivId}</cms:param>
							<cms:param name="categoryFacetField">${categoryFacetField}</cms:param>
							<cms:param name="typesToCollect">${con.value.TypesToCollect}</cms:param>
							<cms:param name="pathes">${cms.requestContext.siteRoot}${cms.subSitePath}</cms:param>
							<cms:param name="showSort">${cms.element.settings.showsort}</cms:param>
							<cms:param name="showCategoryFilter">${cms.element.settings.showcategoryfiler}</cms:param>
							<cms:param name="itemsPerPage">${itemsPerPage}</cms:param>
							<cms:param name="buttonColor">${buttonColor}</cms:param>
							<cms:param name="teaserLength">${teaserLength}</cms:param>
							<cms:param name="extraQueries">${con.value.FilterQueries}</cms:param>
							<cms:param name="__locale">${cms.locale}</cms:param>
							<cms:param name="sortOrder">${con.value.SortOrder}</cms:param>
							<cms:param name="pageUri">${cms.requestContext.uri}</cms:param>

						</cms:include>
					</div>

					<c:set var="linkInnerPage">${linkInnerPage}?cssID=${innerPageDivId}&typesToCollect=${con.value.TypesToCollect}&pathes=/sites/default${cms.subSitePath}&itemsPerPage=${itemsPerPage}&teaserLength=${teaserLength}</c:set>
					<c:set var="linkInnerPage">${linkInnerPage}&showSort=${cms.element.settings.showsort}&showCategoryFilter=${cms.element.settings.showcategoryfiler}</c:set>
					<c:set var="linkInnerPage">${linkInnerPage}&extraQueries=<%=CmsEncoder.encode((String) pageContext.getAttribute("additionalFilterQueries"))%>&__locale=${cms.locale}&sortOrder=${con.value.SortOrder}&pageUri=${cms.requestContext.uri}&buttonColor=${buttonColor}&teaserLength=${teaserLength}</c:set>
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
										scrollTop : $(".list-entry:first")
												.offset().top - 100
									}, 1000);
						}

						function appendInnerList(searchStateParameters) {
							if (!lock) {
								lock = true;
								$('.spinner').show();
								$.get("${linkInnerPage}&hideOptions=true&"
										.concat(searchStateParameters),
										function(resultList) {
											$('#loadMore').parent().remove();
											$(resultList).appendTo(
													'#${innerPageDivId}').find(
													'.list-entry');

											;
											lock = false;
											$('.spinner').hide();

										});
							}
						}
					</script>
					<c:choose>
						<c:when test="${cms.element.settings.usepagination != 'true' }">
							<script>
								function initList() {
									$(window)
											.scroll(
													function(event) {
														if ($(".pagination").length
																&& $(
																		".pagination")
																		.visible(
																				true)) {
															appendInnerList($(
																	'#loadMore')
																	.attr(
																			'data-load'));
														}
													});
								}
							</script>
						</c:when>
						<c:otherwise>
							<script>
								function initList() {
									//Nothing has to initialized in case of a static list.
								}
							</script>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
	</cms:formatter>

</cms:bundle>