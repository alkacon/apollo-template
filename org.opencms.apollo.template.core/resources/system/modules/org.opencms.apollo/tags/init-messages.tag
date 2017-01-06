<%@ tag 
    display-name="init-messages"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Displays the standard 'new element' or 'reload required' message boxes." %>


<%@ attribute name="reload" type="java.lang.Boolean" required="false" 
    description="Indicates if the page must be reloaded after the element was changed in the form editor." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:choose>
    <c:when test="${cms.element.inMemoryOnly}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.core.messages">
            <div id="ap-edit-info" class="box-new">
                <div class="head">
                    <fmt:message key="apollo.core.editor.new">
                        <fmt:param><cms:label>fileicon.${cms.element.resourceTypeName}</cms:label></fmt:param>
                    </fmt:message>
                </div>
                <div class="text">
                    <cms:label>desc.${cms.element.resourceTypeName}</cms:label><br>
                    <div class="small"><fmt:message key="apollo.core.editor.new.info" /></div>
                </div>
            </div>
        </cms:bundle>
    </c:when>
    <c:when test="${reload and cms.edited}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.core.messages">
        <cms:formatter var="content" val="value">
            <div id="ap-edit-info" class="box-reload">
                ${cms.reloadMarker}
                <div class="head">
                    <fmt:message key="apollo.core.editor.reload" />
                </div>
                <div class="text">
                    <fmt:message key="apollo.core.editor.reload.info1">
                        <fmt:param><cms:label>fileicon.${cms.element.resourceTypeName}</cms:label></fmt:param>
                    </fmt:message>
                    <br>
                    <div class="small"><fmt:message key="apollo.core.editor.reload.info2" /></div>
                </div>
            </div>
        </cms:formatter>
        </cms:bundle>
    </c:when>
    <c:otherwise>
        <%-- ####### JSP body inserted here ######## --%>
        <jsp:doBody/>
        <%-- ####### /JSP body inserted here ######## --%>
    </c:otherwise>
</c:choose>
