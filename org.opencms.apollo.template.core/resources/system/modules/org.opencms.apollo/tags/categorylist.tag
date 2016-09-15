<%@ tag 
    display-name="categorylist"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats categories of the content as unordered list" %>

<%@ attribute name="categories" type="org.opencms.jsp.util.CmsJspCategoryAccessBean" required="true" %>
<%@ attribute name="showbigicon" type="java.lang.Boolean" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not categories.isEmpty}">
    <c:if test="${showbigicon}">
    <c:out value='<div class="row">' escapeXml='false' /> 
        <div class="col-xs-1 col-sm-2">
            <i class="icon-custom icon-sm icon-color-u fa fa-tag"></i>                                
        </div>
        <c:out value='<div class="col-xs-11 col-sm-10">' escapeXml='false' /> 
    </c:if>
            <ul class="list-unstyled list-inline blog-tags">
                <li>
                    <c:if test="${not showbigicon}"><i class="fa fa-tag"></i>${' '}</c:if>
                    <c:forEach var="category" items="${categories.leafItems}" varStatus="status">
                        <span class="label rounded label-light">
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