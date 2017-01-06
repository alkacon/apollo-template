<%@ tag 
    display-name="categorylist"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Displays a list of categories from the given content." %>


<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="true" 
    description="The categories to be listed." %>

<%@ attribute name="showbigicon" type="java.lang.Boolean" required="true" 
    description="If true, a big icon is shown in front of the row, small otherwise." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:if test="${not categories.isEmpty}">

    <c:if test="${showbigicon}">
        <c:out value='<div class="row">' escapeXml='false' /> 
        <div class="col-xs-1 col-sm-2">
            <i class="detail-icon fa fa-tag"></i>                                
        </div>
        <c:out value='<div class="col-xs-11 col-sm-10">' escapeXml='false' /> 
    </c:if>

    <ul class="list-unstyled list-inline detail-category">
        <li>
            <c:forEach var="category" items="${categories.leafItems}" varStatus="status">
                <span class="badge badge-grey-light mv-2">
                    <i class="fa fa-tag"></i>
                    ${category.title}
                </span>
            </c:forEach>
        </li>
    </ul>

    <c:if test="${showbigicon}">
        <c:out value='</div>' escapeXml='false' /> 
        <c:out value='</div>' escapeXml='false' /> 
    </c:if>
</c:if>