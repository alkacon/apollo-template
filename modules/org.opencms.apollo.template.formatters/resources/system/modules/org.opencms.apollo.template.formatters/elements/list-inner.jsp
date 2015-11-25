<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:include
		page="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/list/search-options.jsp:914d991e-8a1b-11e5-a24e-0242ac11002b)"></cms:include>

	<div>
		<cms:search configString="${searchConfig}" var="search"
			addContentInfo="true" />
		<c:set var="searchT" value="${search}" scope="request" />

		<c:choose>
			<c:when test="${search.numFound > 0}">
				<div id="list_large_pages">
					<cms:include
						page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/options.jsp:50e6b434-7700-11e5-904d-15b01ffdc6a6)">
					</cms:include>

					<div id="list_large_page_1">
						<cms:include
							page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/items.jsp:b3767e91-7704-11e5-904d-15b01ffdc6a6)"></cms:include>
					</div>
				</div>
				<c:set var="pagination" value="${search.controller.pagination}" />
				<!-- show pagination if it should be given and if it's really necessary -->
				<c:if test="${not empty pagination && search.numPages > 1}">
					<ul class="pagination">
						<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
							<a href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage['
							1']}")'
						   aria-label='<fmt:message key="pagination.first.title"/>'>
								<span aria-hidden="true"><fmt:message
										key="pagination.first" /></span>
						</a>
						</li>
						<c:set var="previousPage">${pagination.state.currentPage > 1 ? pagination.state.currentPage - 1 : 1}</c:set>
						<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
							<a href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[previousPage]}")'
							aria-label='<fmt:message key="pagination.previous.title"/>'>
								<span aria-hidden="true"><fmt:message
										key="pagination.previous" /></span>
						</a>
						</li>
						<c:forEach var="i" begin="${search.pageNavFirst}"
							end="${search.pageNavLast}">
							<c:set var="is">${i}</c:set>
							<li ${pagination.state.currentPage eq i ? "class='active'" : ""}>
								<a href="javascript:void(0)"
								onclick='reloadInnerList("${search.stateParameters.setPage[is]}")'>${is}</a>
							</li>
						</c:forEach>
						<c:set var="pages">${search.numPages}</c:set>
						<c:set var="next">${pagination.state.currentPage < search.numPages ? pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
						<li
							${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
							<a aria-label='<fmt:message key="pagination.next.title"/>'
							href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[next]}")'>
								<span aria-hidden="true"><fmt:message
										key="pagination.next" /></span>
						</a>
						</li>
						<li
							${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
							<a aria-label='<fmt:message key="pagination.last.title"/>'
							href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[pages]}")'>
								<span aria-hidden="true"><fmt:message
										key="pagination.last" /></span>
						</a>
						</li>
					</ul>
				</c:if>
			</c:when>
			<c:otherwise>
				<cms:include
					page="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/list/new.jsp:0aeecb5b-8a1b-11e5-a24e-0242ac11002b)"></cms:include>

			</c:otherwise>
		</c:choose>
	</div>
</cms:bundle>