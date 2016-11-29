<%@ tag 
    display-name="init-messages"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Shows the standard message boxes when a new element is used." %>

<%@ attribute name="textnew" type="java.lang.String" required="true" 
		description="The text that is shown when a new element is created on a page." %>
<%@ attribute name="textedit" type="java.lang.String" required="false" 
		description="The text that is shown when an element was edited. Can be left blank to not have the element reload after edit." %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:choose>
    <c:when test="${cms.element.inMemoryOnly}">
        <div class="alert alert-info mv-10">
            <h3>
                ${textnew}
            </h3>
        </div>
    </c:when>
    <c:when test="${not empty textedit and cms.edited}">
        <div class="alert alert-info mv-10">
            ${cms.reloadMarker}
            <h3>
                ${textedit}
            </h3>
        </div>
    </c:when>
    <c:otherwise>
        <%-- ####### JSP body inserted here ######## --%>
        <jsp:doBody/>
        <%-- ####### /JSP body inserted here ######## --%>
    </c:otherwise>
</c:choose>