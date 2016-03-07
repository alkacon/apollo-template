<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.i18n.CmsEncoder"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" val="value" rdfa="rdfa">
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
					<c:set var="compactForm">${cms.element.settings.compactform}</c:set>
					<c:set var="itemsPerPage">
						<c:out value="${con.value.ItemsPerPage}" default="100" />
					</c:set>
					<c:set var="additionalFilterQueries">${con.value.FilterQueries}</c:set>
					<c:set var="innerPageDivId">${cms.element.id}-inner</c:set>
					<c:choose>
						<c:when test="${cms.element.settings.usepagination == 'true' }">
							<c:set var="linkInnerPage">
								%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-inner.jsp:5ca5be42-5cff-11e5-96ab-0242ac11002b)
							</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="linkInnerPage">
								%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list-dynamic-inner.jsp:bc2fedfd-76f9-11e5-904d-15b01ffdc6a6)
							</c:set>
						</c:otherwise>
					</c:choose>

					<c:set var="params">cssID=${innerPageDivId}</c:set>
					<c:set var="params">${params}&categoryFacetField=${categoryFacetField}</c:set>
					<c:set var="params">${params}&typesToCollect=${con.value.TypesToCollect}</c:set>
					<c:if test="${con.value.Category.isSet}">
						<c:set var="params">${params}&categoriesToCollect=${con.value.Category}</c:set>
					</c:if>
                    <c:choose>
                        <c:when test="${value.Folder.isSet}">
                            <c:set var="folder">${value.Folder}</c:set>
                            <c:if test="${not fn:startsWith(folder, '/shared/')}"><c:set var="folder">${cms.requestContext.siteRoot}${folder}</c:set></c:if>
                            <c:set var="params">${params}&pathes=${folder}</c:set>
                        </c:when>
                        <c:otherwise>
                            <c:set var="params">${params}&pathes=${cms.requestContext.siteRoot}${cms.subSitePath}</c:set>
                        </c:otherwise>
                    </c:choose>
					<c:set var="params">${params}&showDate=${cms.element.settings.showdate}</c:set>
					<c:set var="params">${params}&showSort=${cms.element.settings.showsort}</c:set>
					<c:set var="params">${params}&showCategoryFilter=${cms.element.settings.showcategoryfiler}</c:set>
					<c:set var="params">${params}&itemsPerPage=${itemsPerPage}</c:set>
					<c:set var="params">${params}&buttonColor=${buttonColor}</c:set>
					<c:set var="params">${params}&compactForm=${compactForm}</c:set>
					<c:set var="params">${params}&teaserLength=${teaserLength}</c:set>
					<c:set var="params">${params}&extraQueries=${value.FilterQueries}</c:set>
					<c:set var="params">${params}&__locale=${cms.locale}</c:set>
					<c:set var="params">${params}&sortOrder=${con.value.SortOrder}</c:set>
					<c:set var="params">${params}&pageUri=${cms.requestContext.uri}</c:set>
					<c:set var="params">${params}&listConfig=${cms.element.sitePath}</c:set>

					<div class="posts lists">
						<cms:include file="${linkInnerPage}">
							<c:forTokens items="${params}" delims="&" var="p">
								<cms:param name="${fn:split(p,'=')[0]}">${fn:split(p,'=')[1]}</cms:param>
							</c:forTokens>
						</cms:include>
					</div>

					<c:set var="linkInnerPage"><cms:link>${linkInnerPage}</cms:link>?${params}</c:set>
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
