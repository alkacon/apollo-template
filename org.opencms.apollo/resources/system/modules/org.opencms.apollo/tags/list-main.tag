<%@ tag display-name="list-main"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Searches for resources and displays a variable amount." %>

<%@ attribute name="source" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="sort" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="false" %>
<%@ attribute name="showfacets" type="java.lang.String" required="false" %>
<%@ attribute name="showdate" type="java.lang.String" required="false" %>
<%@ attribute name="count" type="java.lang.Integer" required="false" %>
<%@ attribute name="showexpired" type="java.lang.Boolean" required="false" %>
<%@ attribute name="color" type="java.lang.String" required="false" %>
<%@ attribute name="selectcolor" type="java.lang.String" required="false" %>
<%@ attribute name="teaserlength" type="java.lang.Integer" required="false" %>
<%@ attribute name="path" type="java.lang.String" required="false" %>
<%@ attribute name="listid" type="java.lang.String" required="false" %>
<%@ attribute name="wrapitem" type="java.lang.Boolean" required="false" %>
<%@ attribute name="locale" type="java.lang.String" required="false" %>

<%@ variable name-given="search" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" %>
<%@ variable name-given="searchConfig" scope="AT_END" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${locale}" />

<c:if test="${empty wrapitem}"><c:set var="wrapitem" value="true"/></c:if> 

<%-- ####### Search items ################ --%>

<apollo:list-search source="${source}" types="${types}" count="${count}" showexpired="${showexpired}" categories="${categories}" sort="${sort}" />

<c:if test="${search.numFound > 0}">

<%-- ####### The facet filters ######## --%>

	<apollo:list-facetrow searchresult="${search}" color="${color}" facets="${showfacets}" />

<%-- ####### Elements of the list ######## --%>

	<c:forEach var="result" items="${search.searchResults}" varStatus="status">
		<c:if test="${wrapitem}"><c:out value='<div class="list-entry">' escapeXml='false' /></c:if> 
			<cms:display value="${result.xmlContent.filename}" displayFormatters="${types}" editable="true" create="true" delete="true">
				<cms:param name="teaserlength" value="${teaserlength}" />
				<cms:param name="buttoncolor">${color}</cms:param>
				<cms:param name="calendarcolor">${color}</cms:param>
				<cms:param name="showexpired">${showexpired}</cms:param>
				<cms:param name="index">${status.index}</cms:param>
				<cms:param name="last">${status.last}</cms:param>
				<cms:param name="pageUri">${path}</cms:param>
				<cms:param name="showdate">${showdate}</cms:param>
				<cms:param name="listid">${listid}</cms:param>
			</cms:display>
		<c:if test="${wrapitem}"><c:out value='</div>' escapeXml='false' /></c:if> 
	</c:forEach>
	
</c:if>