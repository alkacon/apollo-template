<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
    <div <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
        <div ${rdfa.Text}>${value.Text}</div>
        <c:if test="${value.Link.exists}">
            <p ${rdfa.Link}><a class="btn btn-u u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
        </c:if>
    </div>
</cms:formatter>