<%@ tag 
    display-name="linksequence"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a link sequence" %>

<%@ attribute name="wrapperclass" type="java.lang.String" required="false" description="CSS class added to the div tag surrounding the link sequence." %>
<%@ attribute name="linkclass" type="java.lang.String" required="false" description="CSS class added to the ul tag surrounding the link entries." %>
<%@ attribute name="title" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" description="The title of the link sequence." %>
<%@ attribute name="links" type="java.util.List" required="true" description="The link entries as list. The list can contain objects of the type CmsJspContentAccessValueWrapper or CmsJspNavElement." %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>  
	

<div class="ap-linksequence <c:out value="${wrapperclass} ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : ''}" />">

    <c:if test="${cms.element.settings.hideTitle ne 'true'}">
        <apollo:headline headline="${title}" />
    </c:if>

    <c:if test="${value.Text.isSet}">
        <div ${rdfa.Text}>${value.Text}</div>
    </c:if> 

    <ul <c:if test="${(not empty linkclass) && (not cms.element.setting.iconclass.isSet)}">class="${linkclass}"</c:if>>
        <c:set var="listtype" value="xml" />
		<c:forEach var="link" items="${links}" varStatus="status">
			<c:if test="${status.first}">
				<c:if test="${fn:contains(link.getClass().name, 'CmsJspNavElement')}">
					<c:set var="listtype" value="nav" />
				</c:if>
			</c:if>
            <li>
				<c:choose>
					<c:when test="${listtype == 'nav'}">
						<a href="<cms:link>${link.resourceName}</cms:link>">
							<c:if test="${cms.element.setting.iconclass.isSet}">
								<span class="fa fa-${cms.element.setting.iconclass}"></span>
							</c:if>
							${link.navText}
						</a>
					</c:when>
					<c:otherwise>
						<apollo:link link="${link}">
							<c:if test="${cms.element.setting.iconclass.isSet}">
								<span class="fa fa-${cms.element.setting.iconclass}"></span>
							</c:if>
							${link.value.Text}
						</apollo:link>
					</c:otherwise>
				</c:choose>
                
            </li>
        </c:forEach>
    </ul>

</div>	