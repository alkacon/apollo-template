<%@ tag 
    display-name="init-messages"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Shows the standard message boxes when a new element is adde to a page,
    or an element was edited and the page requires a reload." %>

<%@ attribute name="textnew" type="java.lang.String" required="false" 
    description="The text that is shown when a new element is created on a page." %>

<%@ attribute name="textedit" type="java.lang.String" required="false" 
    description="The text that is shown when an element was edited. C
    an be left blank to not have the element reload after edit." %>

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
            <div class="ap-edit-info-new">
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
    <c:when test="${not empty textedit and cms.edited}">
        <div class="ap-edit-info-reload">
            ${cms.reloadMarker}
            <h3>
                ${textedit}
            </h3>
        </div>
    </c:when>
    <c:when test="${reload and cms.edited}">
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.core.messages">
        <cms:formatter var="content" val="value">
            <div class="ap-edit-info-reload">
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
