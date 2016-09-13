<%@ tag 
    display-name="linksequence"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a link sequence" %>

<%@ attribute name="wrapperclass" type="java.lang.String" required="false" %>
<%@ attribute name="linkclass" type="java.lang.String" required="false" %>
<%@ attribute name="title" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="links" type="java.util.List" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>  
	

<div class="ap-linksequence <c:out value="${wrapperclass} ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : 'mb-20'}" />">

    <c:if test="${cms.element.settings.hideTitle ne 'true'}">
        <apollo:headline headline="${title}" />
    </c:if>

    <c:if test="${value.Text.isSet}">
        <div ${rdfa.Text}>${value.Text}</div>
    </c:if> 

    <ul <c:if test="${(not empty linkclass) && (not cms.element.setting.iconclass.isSet)}">class="${linkclass}"</c:if>>
        <c:forEach var="link" items="${links}">
            <li>
                <apollo:link link="${link}">
                    <c:if test="${cms.element.setting.iconclass.isSet}">
                        <span class="fa fa-${cms.element.setting.iconclass}"></span>
                    </c:if>
                    ${link.value.Text}
                </apollo:link>
            </li>
        </c:forEach>
    </ul>

</div>	