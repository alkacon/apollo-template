<%@ tag
    display-name="list-messages"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays the 'empty' list message and other messages used for the list." %>


<%@ attribute name="type" type="java.lang.String" required="true"
    description="The resoure type to create using the cms:edit tag." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${not cms.isOnlineProject}">

<fmt:setLocale value="${cms.workplaceLocale}" />
<cms:bundle basename="org.opencms.apollo.template.list.messages">

<cms:edit createType="${type}" create="true" >
    <div id="ap-edit-info" class="box-new">
    <%-- div class="alert alert-warning fade in">  --%>
        <div class="head">
            <fmt:message key="apollo.list.message.empty" />
        </div>
        <div class="text">
            <fmt:message key="apollo.list.message.newentry">
                <fmt:param>
                    <apollo:label locale="${cms.workplaceLocale}" key="fileicon.${type}" />
                </fmt:param>
            </fmt:message>
        </div>
    </div>
</cms:edit>

</cms:bundle>
</c:if>