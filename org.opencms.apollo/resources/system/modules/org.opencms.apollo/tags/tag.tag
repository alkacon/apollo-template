<%@ tag 
    display-name="tag"
    trimDirectiveWhitespaces="true" 
    description="Outputs the body content as a HTML tag. Can be used to avoid paser errores in IDEs." %>

<%@ attribute name="test" type="java.lang.String" required="false"
    description="Can be used to defer the decision to actually create the markup around the body to the calling element.
    If not set or 'true', the markup from this tag is generated around the body of the tag.
    Otherwise no output is generated. "%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${empty test or test}">
    <%-- ####### JSP body inserted here ######## --%>
    <<jsp:doBody/>>
    <%-- ####### /JSP body inserted here ######## --%>
</c:if>
