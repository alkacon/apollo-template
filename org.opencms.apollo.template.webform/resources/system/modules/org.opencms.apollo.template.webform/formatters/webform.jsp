<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="org.opencms.apollo.template.webform.*" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="uri" value="${cms.element.sitePath}" />
<%
    CmsFormHandler form = null;
%>
<c:set var="locale" value="${cms:vfs(pageContext).context.locale}" />

<c:choose>
    <c:when test="${cms.element.inMemoryOnly}">
        <%
        // initialize the form handler
        form = CmsFormHandlerFactory.create(pageContext, request, response);
        %>
        <div>
            <h3><%= form.getMessages().key("webform.init.newAlkaconWebform") %></h3>
            <h4><%= form.getMessages().key("webform.init.pleaseEdit") %></h4>
        </div>
    </c:when>
    <c:otherwise>
        <%
        // initialize the form handler
        form = CmsFormHandlerFactory.create(pageContext, request, response, (String)pageContext.getAttribute("uri"));
        %>
    </c:otherwise>
</c:choose>

<cms:formatter var="content" val="value">
    <div class="OpenCmsApolloWebform ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : 'mb-20'}">
        <%
            form.createForm();
        %>
    </div>
</cms:formatter>
