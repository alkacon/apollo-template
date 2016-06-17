<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" val="value" rdfa="rdfa">
	
	
		<div>
			${cms.reloadMarker}
			<c:choose>
			
			
				<%-- ########################################### --%>
				<%-- ####### Standard messages (tag?)   ######## --%>
				<%-- ########################################### --%>
			
			
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
				
				<%-- ########################################################################################################### Headline ############################## --%>
				
					<c:if test="${not cms.element.settings.hidetitle}">
						<div class="headline headline-md">
							<h2 ${rdfa.Headline}>
								<c:out value="${value.Headline}" escapeXml="false" />
							</h2>
						</div>
					</c:if>
					
					
					
				<%-- ########################################################################################################### PARAMETERS ############################ --%>
					
					<c:set var="categoryFacetField">category_exact</c:set>
					<c:set var="itemsPerPage">
						<c:out value="${value.ItemsPerPage}" default="100" />
					</c:set>
				
					<%-- ################################################################################################################# Search items ######## --%>
					
					<c:set var="categoryFacetField">category_exact</c:set>
					<c:set var="itemsPerPage" value="100" />
					<c:if test="${value.ItemsPerPage.isSet}">
						<c:set var="itemsPerPage" value="${value.ItemsPerPage}" />
					</c:if>
					
					
					<c:set var="searchConfig">
					
								<%-- ################################################################################################################################################### --%>
								<%-- ###################################################################################################### Content of attribute for search tag ######## --%>
								<%-- ###################################################################################################### which needs JSON                    ######## --%>
								<%-- ################################################################################################################################################### --%>

								<c:set var="resType">${fn:substringBefore(value.TypesToCollect, ":")}</c:set>

								<c:set var="solrParamType">fq=type:${resType}</c:set>

								<c:set var="categories"></c:set>
								<c:forEach var="category" items="${con.readCategories.allItems}" varStatus="status">
									<c:set var="categories">${categories}${category.path}</c:set>
									<c:if test="${not status.last}"><c:set var="categories">${categories},</c:set></c:if>
								</c:forEach>
								
								<c:set var="solrParamCats"></c:set>
								<c:if test="${not empty categories}">
									<c:forTokens items="${categories}" delims="," var="catPath" varStatus="status">
										<c:if test="${not status.first}"><c:set var="catFilter">${catFilter} OR </c:set></c:if>
										<c:set var="catFilter">${catFilter} "${catPath}"</c:set>
									</c:forTokens>
									<c:set var="solrParamCats">&fq=category:(${catFilter})</c:set>
								</c:if>

								
								<c:choose>
									<c:when test="${value.Folder.isSet}">
										<c:set var="folder">${value.Folder}</c:set>
										<c:if test="${not fn:startsWith(folder, '/shared/')}"><c:set var="folder">${cms.requestContext.siteRoot}${folder}</c:set></c:if>
										<c:set var="pathes">${folder}</c:set>
									</c:when>
									<c:otherwise>
										<c:set var="pathes">${cms.requestContext.siteRoot}${cms.subSitePath}</c:set>
									</c:otherwise>
								</c:choose>
								

								<c:set var="solrParamDirs">&fq=parent-folders:"${pathes}"</c:set>
								<c:set var="solrFilterQue">${value.FilterQueries}</c:set>
								<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}${solrParamCats}${solrFilterQue}</c:set>


								<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
								<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>



								<%-- ##################################################################################################################################### --%>
								<%-- ################################################################################################################# JSON START ######## --%>
								<%-- ##################################################################################################################################### --%>

								{ "test": "${solrFilterQue}",
									"ignorequery" : true,
									<c:if test="${cms.element.settings.showexpired == 'true'}">
										"ignoreExpirationDate" : true,
										"ignoreReleaseDate" : true,
									</c:if>
									"extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
									"pagesize" : ${itemsPerPage}, 
									"sortoptions" : [
								<c:choose>
									<c:when test='${value.SortOrder eq "asc"}'>	
												${sortOptionAsc},	  		
												${sortOptionDesc}
											</c:when>
									<c:otherwise>
												${sortOptionDesc},
												${sortOptionAsc}
											</c:otherwise>
								</c:choose>
								],"fieldfacets" : [ { "field" : "${categoryFacetField}", "label" :
								"facet.category.label", "order" : "index", "mincount" : 1 } ],
								pagenavlength: 5 }${pathes}
					
					</c:set>
					
					
					
					<cms:search configString="${searchConfig}" var="search"	addContentInfo="true" />
					
					
					<%-- ################################################################################################# Elements of the list ############### --%>
				
					<c:choose>
					<c:when test="${search.numFound > 0}">
						<div id="${cssID}">
							<cms:include
								page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/items.jsp:b3767e91-7704-11e5-904d-15b01ffdc6a6)">
								<cms:param name="searchConfig">${searchConfig}</cms:param>
								<cms:param name="teaserLength">${cms.element.settings.teaserlength}</cms:param>
								<cms:param name="buttonColor">${cms.element.settings.buttoncolor}</cms:param>
								<cms:param name="listConfig">${cms.element.sitePath}</cms:param>
								<cms:param name="showDate">${cms.element.settings.showdate}</cms:param>
								<cms:param name="compactForm">${cms.element.settings.compactform}</cms:param>
							</cms:include>
						</div>
					</c:when>
					<c:otherwise>
						<cms:include page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/new.jsp:0aeecb5b-8a1b-11e5-a24e-0242ac11002b)">
							<cms:param name="listConfig">${cms.element.sitePath}</cms:param>
						</cms:include>
					</c:otherwise>
					</c:choose>
					
					
					
				<%-- ################################################################################################################################################### --%>
				<%-- ################################################################################################### Just a link from content ###################### --%>
				<%-- ################################################################################################################################################### --%>

					<c:if test="${value.Link.exists}">
						<div class="mv-10"><a class="btn ap-btn-${cms.element.settings.buttoncolor} ap-btn-sm" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></div>
					</c:if>	
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
				<%-- ####################################################################################################### Javascript ############################### --%>
				
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
					
				<%-- ####################################################################################################### INIT SCRIPT ############################### --%>
					
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
					
					
				</c:otherwise>
			</c:choose>
		</div>
		
		
	</cms:formatter>

</cms:bundle>
