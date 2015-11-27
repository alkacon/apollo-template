<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:set var="cssID">${param.cssID}</c:set>
	<c:set var="categoryFacetField">category_exact</c:set>
	<div>
		<c:set var="searchConfig">
			<%@include
				file="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/list/search-options.jsp:914d991e-8a1b-11e5-a24e-0242ac11002b)"%>
		</c:set>
		<cms:search configString="${searchConfig}" var="search"
			addContentInfo="true" />
		<c:if test="${empty param.page or search.numPages>=param.page}">
			<c:choose>
				<c:when test="${search.numFound > 0}">
					<c:choose>
						<c:when test="${empty param.hideOptions}">
							<div id="list_large_pages">
								<cms:include
									page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/options.jsp:50e6b434-7700-11e5-904d-15b01ffdc6a6)">
									<cms:param name="searchConfig">${searchConfig}</cms:param>
									<cms:param name="showCategoryFilter">${param.showCategoryFilter}</cms:param>
									<cms:param name="showSort">${param.showSort}</cms:param>
									<cms:param name="buttonColor">${param.buttonColor}</cms:param>
									<cms:param name="categoryFacetField">${categoryFacetField}</cms:param>
								</cms:include>
							</div>
							<div id="${cssID}">
								<cms:include
									page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/items.jsp:b3767e91-7704-11e5-904d-15b01ffdc6a6)">
									<cms:param name="searchConfig">${searchConfig}</cms:param>
									<cms:param name="teaserLength">${param.teaserLength}</cms:param>									
									<cms:param name="buttonColor">${param.buttonColor}</cms:param>
								</cms:include>
							</div>
							<div class="spinner mv-20" style="opacity: 0">
								<i class="fa fa-spinner"></i>
							</div>
						</c:when>
						<c:otherwise>
							<cms:include
								page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/items.jsp:b3767e91-7704-11e5-904d-15b01ffdc6a6)">
								<cms:param name="searchConfig">${searchConfig}</cms:param>
								<cms:param name="teaserLength">${param.teaserLength}</cms:param>
							</cms:include>
						</c:otherwise>
					</c:choose>
					<c:set var="pagination" value="${search.controller.pagination}" />
					<!-- show pagination if it should be given and if it's really necessary -->
					<c:if test="${not empty pagination && search.numPages > 1}">
						<c:set var="next">${ pagination.state.currentPage + 1}</c:set>
						<c:if test="${search.numPages+1 != next}">
							<div class="pagination col-xs-12">
								<c:set var="pages">${search.numPages}</c:set>
								<button
									class="btn-u btn-primary col-xs-12 mt-5 mb-20 ${pagination.state.currentPage >= search.numPages ? ' disabled' : ''}"
									aria-label='<fmt:message key="pagination.next.title"/>'
									id="loadMore"
									data-load="${search.stateParameters.setPage[next]}"
									onclick="appendInnerList($(this).attr('data-load'));">
									<span aria-hidden="true"><fmt:message
											key="pagination.next" /></span>
								</button>
							</div>
						</c:if>
					</c:if>
				</c:when>
				<c:otherwise>
					<%@include
						file="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/list/new.jsp:0aeecb5b-8a1b-11e5-a24e-0242ac11002b)"%>
				</c:otherwise>
			</c:choose>
		</c:if>

	</div>
</cms:bundle>