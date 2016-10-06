<%@ tag
  display-name="list-main"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Searches for resources and displays a variable amount." %>

<%@ attribute name="source" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="count" type="java.lang.Integer" required="true" %>
<%@ attribute name="formatterSettings" type="java.util.Map" required="true" %>
<%@ attribute name="locale" type="java.lang.String" required="true" %>

<%@ attribute name="sort" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="false" %>
<%@ attribute name="listid" type="java.lang.String" required="false" %>

<%@ attribute name="showfacets" type="java.lang.String" required="false" %>
<%@ attribute name="pageUri" type="java.lang.String" required="false" %>

<%@ attribute name="ajaxCall" type="java.lang.Boolean" required="false" %>

<%@ variable name-given="search" scope="AT_END" declare="true" variable-class="org.opencms.jsp.search.result.I_CmsSearchResultWrapper" %>
<%@ variable name-given="searchConfig" scope="AT_END" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${locale}" />

<%-- ####### Search items ################ --%>

<apollo:list-search
    source="${source}"
    types="${types}"
    sort="${sort}"
    count="${count}"
    categories="${categories}"
    showexpired="${formatterSettings.showExpired}"
/>

<c:if test="${search.numFound > 0}">

    <%-- ####### The facet filters ######## --%>
    <c:if test="not empty showfacets">
        <apollo:list-facetrow 
            searchresult="${search}" 
            color="${color}" 
            facets="${showfacets}"
        />
    </c:if>

    <%-- ####### Elements of the list ######## --%>
    <c:forEach var="result" items="${search.searchResults}" varStatus="status">
        <%-- ###### MUST add one DIV here, otherwise OpenCms edit points won't load in Ajax lists ! ###### --%>
        <c:if test="${ajaxCall}"><c:out value='<div class="list-entry">' escapeXml="false" /></c:if>
            <cms:display 
                value="${result.xmlContent.filename}"
                displayFormatters="${types}"
                editable="true"
                create="true"
                delete="true"
                >

                <c:forEach var="parameter" items="${formatterSettings}">
                     <cms:param name="${parameter.key}" value="${parameter.value}" />
                </c:forEach>

                <cms:param name="listid">${listid}</cms:param>
                <cms:param name="index">${status.index}</cms:param>
                <cms:param name="last">${status.last}</cms:param>
                <cms:param name="pageUri">${pageUri}</cms:param>
            </cms:display>
        <c:if test="${ajaxCall}"><c:out value='</div>' escapeXml="false" /></c:if>
    </c:forEach>

</c:if>