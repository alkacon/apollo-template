<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="org.opencms.i18n.CmsEncoder,org.opencms.file.*"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<apollo:list-archive-search content="${content}" usepagesize="true"/>
		<div>
			<div class="ap-list-filters">
				<c:if test="${cms.element.settings.showsearch}">
					<div class="ap-list-filterbox ap-list-filterbox-search ap-list-filterbox-${cms.element.settings.filtercolor}">
						<form role="form" class="form-inline" action="<cms:link>${cms.requestContext.uri}</cms:link>">
							<div class="input-group">
								<c:set var="escapedQuery">${fn:replace(search.controller.common.state.query,'"','&quot;')}</c:set>
								<input type="hidden" name="${search.controller.common.config.lastQueryParam}" value="${escapedQuery}" />
								<input type="hidden" name="${search.controller.common.config.reloadedParam}" />
								<span class="input-group-addon"><span class="icon-magnifier"></span></span>
								<input name="${search.controller.common.config.queryParam}" class="form-control" type="text" value="${escapedQuery}" placeholder="<fmt:message key="apollo.list.message.search" />">
							</div>
						</form>
					</div>
				</c:if>

				<c:if test="${cms.element.settings.showlabels and not empty fieldFacetResult and cms:getListSize(fieldFacetResult.values) > 0}">
					<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
					<%
					    CmsObject cmsObject = (CmsObject)pageContext.getAttribute("cmsObject");
					%>
					<div class="ap-list-filterbox ap-list-filterbox-labels ap-list-filterbox-${cms.element.settings.filtercolor}">
						<button type="button" class="btn-block btn ap-btn-${cms.element.settings.filtercolor} ap-list-filterbtn-labels" onclick="toggleApListFilter('labels');this.blur();">
							<span class="pull-left pr-10"><span class="fa fa-tag"></span></span>
							<span class="pull-left"><fmt:message key="apollo.list.message.labels" /></span>
							<span id="aplistlabels_toggle" class="fa fa-chevron-down pull-right"></span>
						</button>

						<div id="aplistlabels" class="ap-list-filter-labels-wrapper">
							<hr>
							<ul class="ap-list-filter-labels">
								<c:forEach var="value" items="${fieldFacetResult.values}">
									<c:set var="selected">${fieldFacetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>
									<c:set var="itemName">${value.name}</c:set>
									<% pageContext.setAttribute("currCat", org.opencms.relations.CmsCategoryService.getInstance().readCategory(
                                            cmsObject,
                                            (String)pageContext.getAttribute("itemName"),
                                            cmsObject.getRequestContext().getUri())); %>
									<c:set var="showLabel" value="false" />
									<c:choose>
										<c:when test="${content.value.Category.isSet}">
											<c:forTokens var="testCat" items="${categoryPaths}" delims=",">
												<c:if test="${fn:startsWith(currCat.path, testCat)}">
													<c:set var="showLabel" value="true" />
												</c:if>	
											</c:forTokens>
										</c:when>
										<c:otherwise>
											<c:set var="showLabel" value="true" />	
										</c:otherwise>
									</c:choose>
									
									<c:if test="${showLabel}">
										<li ${selected}>
											<a href="<cms:link>${cms.requestContext.uri}?${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[categoryFacetField][value.name]}</cms:link>">${currCat.title}	(${value.count})</a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
					</div>
				</c:if>

				<c:if test="${cms.element.settings.showarchive and not empty rangeFacet and cms:getListSize(rangeFacet.counts) > 0}">
					<div class="ap-list-filterbox ap-list-filterbox-archive ap-list-filterbox-${cms.element.settings.filtercolor}">
						<button type="button" class="btn-block btn ap-btn-${cms.element.settings.filtercolor} ap-list-filterbtn-archive" onclick="toggleApListFilter('archive');this.blur();">
							<span class="pull-left pr-10"><span class="fa fa-archive"></span></span>
							<span class="pull-left"><fmt:message key="apollo.list.message.archive" /></span>
							<span id="aplistarchive_toggle" class="fa fa-chevron-down pull-right"></span>
						</button>

						<div id="aplistarchive" class="ap-list-filter-archive">

							<c:set var="archiveHtml" value="" />
							<c:set var="yearHtml" value="" />
							<c:set var="prevYear" value="-1" />
							<c:forEach var="facetItem" items="${rangeFacet.counts}" varStatus="status">
								<c:set var="selected">${rangeFacetController.state.isChecked[facetItem.value] ? ' class="active"' : ""}</c:set>
								<fmt:parseDate var="fDate" pattern="yyyy-MM-dd'T'HH:mm:ss'Z'" value="${facetItem.value}"/>
								<c:set var="currYear"><fmt:formatDate value="${fDate}" pattern="yyyy" /></c:set>

								<c:if test="${prevYear != currYear}">
									<%-- another year, generate year toggle button --%>
									<c:if test="${not status.first}">
										<%-- close month list of previous year --%>
										<c:set var="yearHtml">${yearHtml}</ul></c:set>
									</c:if>
									<c:set var="archiveHtml">${yearHtml}${archiveHtml}</c:set>
									<c:set var="yearHtml">
										<button type="button" class="btn-block btn ap-btn-${cms.element.settings.yearcolor} btn-xs ap-list-filterbtn-year" onclick="toggleApListFilter('year${currYear}');this.blur();">
											<span class="pull-left">${currYear}</span>
											<i id="aplistyear${currYear}_toggle" class="fa fa-chevron-down pull-right"></i>
										</button>
										<ul class="ap-list-filter-year" id="aplistyear${currYear}" style="display:none;">
									</c:set>
								</c:if>
								<%-- add month list entry to current year --%>
								<c:set var="yearHtml">${yearHtml}<li ${selected}><a href="<cms:link>${cms.requestContext.uri}?${search.stateParameters.resetAllFacetStates.newQuery[''].checkFacetItem[rangeFacetField][facetItem.value]}</cms:link>" title="${facetItem.count}"><fmt:formatDate value="${fDate}" pattern="MMM" /></a></li></c:set>
								<c:set var="prevYear" value="${currYear}" />
							</c:forEach>
							<%-- close month list of last year, remove style attribute, replace chevron and add it to archive HTML --%>
							<c:set var="yearHtml">${fn:replace(yearHtml, 'style="display:none;"', '')}</c:set>
							<c:set var="yearHtml">${fn:replace(yearHtml, 'fa-chevron-down', 'fa-chevron-up')}</c:set>
							<c:set var="archiveHtml">${yearHtml}</ul>${archiveHtml}</c:set>
							
							${archiveHtml}
						</div> <%-- /ap-list-filter-archive --%>

					</div> <%-- /ap-list-filterbox-archive --%>
				</c:if>

			</div> <%-- /ap-list-filters --%>
			
			<script type="text/javascript">
				function toggleApListFilter(fType) {
					$("#aplist" + fType + "_toggle").toggleClass("fa-chevron-down");
					$("#aplist" + fType + "_toggle").toggleClass("fa-chevron-up");
					$("#aplist" + fType + "").slideToggle();
				}
			</script>

		</div>
	</cms:formatter>

</cms:bundle>
