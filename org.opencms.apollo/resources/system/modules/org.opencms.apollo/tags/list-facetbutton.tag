<%@ tag display-name="list-facetbutton"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Generates a facet button for use with AJAX forms."%>

<%@ attribute name="field" type="java.lang.String" required="true" %>
<%@ attribute name="label" type="java.lang.String" required="false" %>
<%@ attribute name="color" type="java.lang.String" required="false" %>
<%@ attribute name="deselect" type="java.lang.String" required="false" %>
<%@ attribute name="searchconfig" type="java.lang.String" required="false" %>
<%@ attribute name="searchresult" type="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" required="false" %>
<%@ attribute name="render" type="java.lang.Boolean" required="false" %>

<%@ variable name-given="listItems" scope="AT_END" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%-- ########################################### --%>
<%-- ####### Set needed variables       ######## --%>
<%-- ########################################### --%>


<%-- ####### Acquire search var ######## --%>
<c:choose>
<c:when test="${not empty searchresult}">
	<c:set var="search" value="${searchresult}" />
</c:when>
<c:when test="${not empty searchconfig}">
	<cms:search configString="${searchconfig}" var="search" addContentInfo="true" />
</c:when>
<c:otherwise>
	<%-- If no search results or config given, set error flag --%>
	<c:set var="error" value="true" />
</c:otherwise>
</c:choose>

<%-- ####### Set label for button ######## --%>
<c:set var="buttonLabel" value="${facetController.config.label}" />
<c:if test="${not empty label}">
	<c:set var="buttonLabel" value="${label}" />
</c:if>

<%-- ####### Set label for deselection item ######## --%>
<c:set var="deselectLabel" value="Show all" />
<c:if test="${not empty deselect}">
	<c:set var="deselectLabel" value="${deselect}" />
</c:if>

<c:set var="buttonColor" value="red" />
<c:if test="${not empty color}">
	<c:set var="buttonColor" value="${color}" />
</c:if>

<%-- ########################################### --%>
<%-- ####### Start processing button    ######## --%>
<%-- ########################################### --%>

<c:if test="${not error}">

	<c:set var="categoryFacetField" value="${field}" />
	<c:set var="facetController" value="${search.controller.fieldFacets.fieldFacetController[categoryFacetField]}" />
	<c:set var="facetResult" value="${search.fieldFacet[categoryFacetField]}" />
	<c:if test="${not empty facetResult and cms:getListSize(facetResult.values) > 0 || field == 'sort' }">
	
		<%-- ################################################################################################################# HEAD ######## --%>
		<c:set var="head">
			<c:out value='<div class="btn-group hidden-xs">' escapeXml='false' />
				<button type="button" class="dropdown-toggle btn ap-btn-${buttonColor}" data-toggle="dropdown" 
								aria-haspopup="true" aria-expanded="false" id="dropdownMenu1" aria-expanded="true">
					${buttonLabel} &nbsp; <span class="va-middle fa fs-8 fa-chevron-down"></span>
				</button>
				
				<c:out value='<ul class="dropdown-menu dropdown-${buttonColor}">' escapeXml='false' />
		</c:set>	

		<c:set var="delimiter" value="|" />
		
		<%-- ################################################################################################################# ITEMS ####### --%>
		<c:set var="items">
				
			<%-- ##### Default option ##### --%>
			<li ${cms:getListSize(facetController.state.checkedEntries) == 0?'class="active"' : ""}>
				<a href="javascript:void(0)" onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField]}', 
																								$('#ap-list-content-' + $(this).parents().filter('.listoptionbox').data('id')))">
					${deselectLabel}</a>
			</li>${delimiter}
			
			<li role="separator" class="divider"></li>${delimiter}

			<%-- ####### Render category labels ######## --%>
			
			<c:forEach var="value" items="${facetResult.values}" varStatus="outerStatus">
				<c:set var="selected">${facetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>
				
				<%-- BEGIN: Calculate category label --%>
				<c:set var="label"></c:set>
				<c:forEach var="category" items="${cms.readPathCategories[value.name]}" varStatus="status">
					<c:set var="label">${label}${category.title}</c:set>
					<c:if test="${not status.last}"><c:set var="label">${label}&nbsp;/&nbsp;</c:set></c:if>
				</c:forEach>
				<%-- END: Calculate category label --%>
				
				<li ${selected}>
					<a href="javascript:void(0)"
					onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField].checkFacetItem[categoryFacetField][value.name]}', 
																								$('#ap-list-content-' + $(this).parents().filter('.listoptionbox').data('id')))">
						${label} (${value.count})
					</a>
				</li>${delimiter}
			</c:forEach>
					
		</c:set>
					
		<%-- ################################################################################################################# FOOT ######## --%>
		<c:set var="foot">
				<c:out value='</ul>' escapeXml='false' />

			<c:out value='</div>' escapeXml='false' />	
		</c:set>
	</c:if>
	
	<%-- ####### build list of list-items ######## --%>
	<c:set var="listItems" value="${items}" />

	<c:if test="${render != 'false'}">
		${head}
		<c:forTokens items="${items}" delims="|" var="item">
			${item}
		</c:forTokens>
		${foot}
	</c:if>

</c:if>
