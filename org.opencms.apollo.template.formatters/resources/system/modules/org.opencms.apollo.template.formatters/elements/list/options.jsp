<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<c:if test="${not empty param.searchConfig}">
		<c:set var="categoryFacetField">${param.categoryFacetField}	</c:set>
		<c:set var="showCategoryFilter">${param.showCategoryFilter}	</c:set>
		<c:set var="showSort">${param.showSort}	</c:set>
		<c:set var="buttonColor" value="${param.buttonColor}" />

		<cms:search configString="${param.searchConfig}" var="search"
			addContentInfo="true" />

		<div class="row mb-20">
			<section id="listOptions" class="btn-group pull-right">
				<%--Category filter --%>
				<c:if test="${showCategoryFilter eq 'true' }">
					<c:set var="facetController"
						value="${search.controller.fieldFacets.fieldFacetController[categoryFacetField]}" />
					<c:set var="facetResult"
						value="${search.fieldFacet[categoryFacetField]}" />
					<c:if
						test="${not empty facetResult and cms:getListSize(facetResult.values) > 0}">

						<div class="btn-group hidden-xs">
							<button type="button"
								class="dropdown-toggle btn ap-btn-${buttonColor}"
								data-toggle="dropdown" aria-haspopup="true"
								aria-expanded="false" id="dropdownMenu1" aria-expanded="true">
								<fmt:message key="${facetController.config.label}" />
								&nbsp; <span class="caret"></span>
							</button>
							<ul class="dropdown-menu dropdown-${buttonColor}">
								<li
									${cms:getListSize(facetController.state.checkedEntries) == 0?'class="active"' : ""}><a
									href="javascript:void(0)"
									onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField]}')"><fmt:message
											key="facet.category.none" /></a></li>
								<li role="separator" class="divider"></li>

								<c:forEach var="value" items="${facetResult.values}">
									<c:set var="selected">${facetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>
									<%-- BEGIN: Calculate category label --%>
									<c:set var="label"></c:set>
									<c:forEach var="category" items="${cms.readPathCategories[value.name]}" varStatus="status">
										<c:set var="label">${label}${category.title}</c:set>
										<c:if test="${not status.last}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
									</c:forEach>
									<%-- END: Calculate category label --%>
									<li ${selected}><a href="javascript:void(0)"
										onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField].checkFacetItem[categoryFacetField][value.name]}')">${label}
											(${value.count})</a>
								</c:forEach>
							</ul>
						</div>
					</c:if>
				</c:if>
				<%-- Sort options --%>
				<c:if test="${showSort eq 'true' }">
					<c:set var="sortController" value="${search.controller.sorting}" />
					<c:if
						test="${not empty sortController and not empty sortController.config.sortOptions}">
						<c:set var="sortOption"
							value="${sortController.config.sortOptions[0]}"></c:set>
						<c:set var="sortIndex" value="1" />
						<c:if
							test="${sortController.state.checkSelected[sortOption] != true}">
							<c:set var="sortOption"
								value="${sortController.config.sortOptions[1]}"></c:set>
							<c:set var="sortIndex" value="0" />
						</c:if>
					</c:if>

					<div class="btn-group hidden-xs">
						<button type="button"
							class="btn ap-btn-${buttonColor} dropdown-toggle"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
							id="dropdownMenu2" aria-expanded="true">
							<fmt:message key="sort.options.label" />
							&nbsp; <span class="caret"></span>
						</button>
						<ul class="dropdown-menu dropdown-${buttonColor}"
							aria-labelledby="dropdownMenu2">
							<c:forEach var="sortOption"
								items="${sortController.config.sortOptions}">
								<c:set var="selected">${sortController.state.checkSelected[sortOption] ? ' class="active"' : ""}</c:set>
								<li ${selected}><a href="javascript:void(0)"
									onclick="reloadInnerList('${search.stateParameters.setSortOption[sortOption.paramValue]}')"><fmt:message
											key="${sortOption.label}" /></a></li>
							</c:forEach>
						</ul>
					</div>
				</c:if>
			</section>
		</div>
		<c:if test="${showCategoryFilter eq 'true' }">
			<select
				class="form-control hidden-sm hidden-md hidden-lg col-xs-fluid"
				onchange="reloadInnerList(this.value)">
				<option
					value="${search.stateParameters.resetFacetState[categoryFacetField]}"
					${cms:getListSize(facetController.state.checkedEntries) == 0?' selected' : ""}>
					<fmt:message key="facet.category.none" /></option>
				<c:forEach var="value" items="${facetResult.values}">
					<c:set var="selected">${facetController.state.isChecked[value.name] ? ' selected' : ""}</c:set>
					<%-- BEGIN: Calculate category label --%>
					<c:set var="label"></c:set>
					<c:forEach var="category" items="${cms.readPathCategories[facetItem.name]}" varStatus="status">
						<c:set var="label">${label}${category.title}</c:set>
						<c:if test="${not status.last}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
					</c:forEach>
					<%-- END: Calculate category label --%>
					<option
						value="${search.stateParameters.resetFacetState[categoryFacetField].checkFacetItem[categoryFacetField][value.name]}"
						${selected}>${label}(${value.count})</option>
				</c:forEach>
			</select>
		</c:if>
		<c:if test="${showSort eq 'true' }">
			<select
				class="mv-10 form-control hidden-sm hidden-md hidden-lg col-xs-fluid"
				onchange="reloadInnerList(this.value)">
				<c:forEach var="sortOption"
					items="${sortController.config.sortOptions}">
					<c:set var="selected">${sortController.state.checkSelected[sortOption] ? ' selected' : ""}</c:set>
					<option
						value="'${search.stateParameters.setSortOption[sortOption.paramValue]}"
						${selected}><fmt:message key="sort.options.label" />&nbsp;
						<fmt:message key="${sortOption.label}" /></option>
				</c:forEach>
			</select>
		</c:if>
	</c:if>
</cms:bundle>