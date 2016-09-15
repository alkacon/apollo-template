<%@ tag display-name="list-sortbutton"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Generates a facet button for use with AJAX forms."%>

<%@ attribute name="label" type="java.lang.String" required="false" %>
<%@ attribute name="params" type="java.lang.String" required="false" %>
<%@ attribute name="color" type="java.lang.String" required="false" %>
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

<c:set var="buttonColor" value="red" />
<c:if test="${not empty color}">
	<c:set var="buttonColor" value="${color}" />
</c:if>

<%-- ########################################### --%>
<%-- ####### Start processing button    ######## --%>
<%-- ########################################### --%>

<c:if test="${not error}">
	<c:set var="sortController" value="${search.controller.sorting}" />
	<c:if test="${not empty sortController and not empty sortController.config.sortOptions}">
		<c:set var="sortOption" value="${sortController.config.sortOptions[0]}" />
		<c:set var="sortIndex" value="1" />
		<c:if test="${sortController.state.checkSelected[sortOption] != true}">
			<c:set var="sortOption" value="${sortController.config.sortOptions[1]}" />
			<c:set var="sortIndex" value="0" />
		</c:if>
	</c:if>
	
		<%-- ################################################################################################################# HEAD ######## --%>
		<c:set var="head">
			<c:out value='<div class="btn-group hidden-xs">' escapeXml='false' />
				<button type="button" class="dropdown-toggle btn ap-btn-${buttonColor}" data-toggle="dropdown" 
								aria-haspopup="true" aria-expanded="false" id="dropdownMenu1" aria-expanded="true">
					${label}&nbsp;<span class="va-middle fa fs-8 fa-chevron-down"></span>
				</button>
				
				<c:out value='<ul class="dropdown-menu dropdown-${buttonColor}">' escapeXml='false' />	 
		</c:set>	

		<c:set var="delimiter" value="|" />
		
		<%-- ################################################################################################################# ITEMS ####### --%>
		<c:set var="items">
		
			<c:forEach var="sortOption" items="${sortController.config.sortOptions}" varStatus="status">
				<c:if test="${empty params || fn:contains(params, sortOption.paramValue)}">
					<c:set var="selected">${sortController.state.checkSelected[sortOption] ? ' class="active"' : ""}</c:set>
					<li ${selected}>
						<a href="javascript:void(0)" onclick="reloadInnerList('${search.stateParameters.setSortOption[sortOption.paramValue]}',
																									$('#ap-list-content-' + $(this).parents().filter('.listoptionbox').data('id')))">
							<fmt:message key="${sortOption.label}" />
						</a>
					</li>
				</c:if>
			</c:forEach>
				
		</c:set>
					
		<%-- ################################################################################################################# FOOT ######## --%>
		<c:set var="foot">
				<c:out value='</ul>' escapeXml='false' />				
			<c:out value='</div>' escapeXml='false' />	 
		</c:set>
		
	
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
