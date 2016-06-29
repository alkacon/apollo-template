<%@ tag display-name="list-facetrow"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Generates facet and sorting buttons for use with AJAX forms."%>

<%@ attribute name="searchresult" type="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" required="true" %>
<%@ attribute name="facets" type="java.lang.String" required="false" %>
<%@ attribute name="color" type="java.lang.String" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="buttonColor" value="red" />
<c:if test="${not empty color}">
	<c:set var="buttonColor" value="${color}" />
</c:if>

<c:set var="search" value="${searchresult}" />

<div id="listOptions" class="row mb-20">
	<section class="btn-group pull-right">
		<%-- ####### Category filter ######## --%>
		<c:if test="${empty facets || fn:contains(facets, 'category')}">
			<c:set var="buttonLabel"><fmt:message key="facet.category.label" /></c:set>
			<c:set var="noSelection"><fmt:message key="facet.category.none" /></c:set>
			<apollo:list-facetbutton field="category_exact" label="${buttonLabel}" deselect="${noSelection}" searchresult="${search}" color="${buttonColor}" />
		</c:if>

		<%-- ####### Sort options ######## --%>
		<c:if test="${empty facets || fn:contains(facets, 'sort')}">
			<apollo:list-sortbutton searchresult="${search}" color="${buttonColor}" />
		</c:if>
	</section>
</div>