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

<c:set var="search" value="${searchresult}" />

<c:if test="${facets != 'none'}">
	<div class="listOptions row mb-20" style="min-height: 36px;">
		<div class="col-xs-12">
			<section class="btn-group pull-right">
            
				<%-- ####### Category filter ######## --%>
				<c:if test="${empty facets || fn:contains(facets, 'category')}">
					<c:set var="buttonLabel"><fmt:message key="facet.category.label" /></c:set>
					<c:set var="noSelection"><fmt:message key="facet.category.none" /></c:set>
					<apollo:list-facetbutton field="category_exact" label="${buttonLabel}" deselect="${noSelection}" searchresult="${search}" color="${color}" />
				</c:if>

				<%-- ####### Sort by date ######## --%>
				<c:if test="${empty facets || fn:contains(facets, 'sort_date')}">
					<c:set var="buttonLabel"><fmt:message key="sort.options.date.label" /></c:set>
					<apollo:list-sortbutton searchresult="${search}" color="${color}"  label="${buttonLabel}" params="asc+desc" />
				</c:if>

                <%-- ####### Sort by order ######## --%>
				<c:if test="${empty facets || fn:contains(facets, 'sort_order')}">
					<c:set var="buttonLabel"><fmt:message key="sort.options.order.label" /></c:set>
					<apollo:list-sortbutton searchresult="${search}" color="${color}"  label="${buttonLabel}" params="order_a+order_d" />
				</c:if>    
                
				<%-- ####### Sort by title ######## --%>
				<c:if test="${empty facets || fn:contains(facets, 'sort_title')}">
					<c:set var="buttonLabel"><fmt:message key="sort.options.title.label" /></c:set>
					<apollo:list-sortbutton searchresult="${search}" color="${color}"  label="${buttonLabel}" params="title_a+title_d" />
				</c:if>

			</section>
		</div>
	</div>
</c:if>