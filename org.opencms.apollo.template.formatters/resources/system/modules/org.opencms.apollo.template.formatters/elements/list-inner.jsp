<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:secureparams />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:set var="categoryFacetField">category_exact</c:set>
	<c:set var="buttonColor" scope="request">${param.buttonColor}</c:set>
	<c:if test="${empty fn:trim(buttonColor) }">
		<c:set var="buttonColor" scope="request">red</c:set>
	</c:if>
	<div>
		<c:set var="searchConfig">
			<%@include
				file="%(link.weak:/system/modules/org.opencms.apollo.template.formatters/elements/list/search-options.jsp:914d991e-8a1b-11e5-a24e-0242ac11002b)"%>
		</c:set>
		<cms:search configString="${searchConfig}" var="search"	addContentInfo="true" />
		<c:choose>
			<c:when test="${search.numFound > 0}">
				<div id="list_large_pages">
					<cms:include
						page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/options.jsp:50e6b434-7700-11e5-904d-15b01ffdc6a6)">
						<cms:param name="searchConfig">${searchConfig}</cms:param>
						<cms:param name="showCategoryFilter">${param.showCategoryFilter}</cms:param>
						<cms:param name="showSort">${param.showSort}</cms:param>
						<cms:param name="categoryFacetField">${categoryFacetField}</cms:param>
					</cms:include>
					<div id="list_large_page_1">
						<cms:include
							page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/items.jsp:b3767e91-7704-11e5-904d-15b01ffdc6a6)">
							<cms:param name="searchConfig">${searchConfig}</cms:param>
							<cms:param name="teaserLength">${param.teaserLength}</cms:param>
							<cms:param name="listConfig">${param.listConfig}</cms:param>
							<cms:param name="showDate">${param.showDate}</cms:param>
                            <cms:param name="compactForm">${param.compactForm}</cms:param>
						</cms:include>
					</div>
				</div>
				<c:if test="${param.compactForm == 'false'}">
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
                </c:if>
			</c:when>
			<c:otherwise>
				<cms:include
					page="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/new.jsp:0aeecb5b-8a1b-11e5-a24e-0242ac11002b)"></cms:include>

			</c:otherwise>
		</c:choose>
	</div>
</cms:bundle>