<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.linksequence">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="ap-linklist ap-linklist-boxed ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "" }">

		<%-- ####### Init messages wrapper ################################## --%>
		<c:set var="textnew"><fmt:message key="apollo.linksequence.message.new" /></c:set>
		<apollo:init-messages textnew="${textnew}" textedit="">
        
        <c:if test="${cms.element.settings.hideTitle ne 'true'}">
            <apollo:headline setting="${cms.element.setting}" headline="${content.value.Title}" />
        </c:if>
        
        <c:if test="${value.Text.isSet}">
            <div ${rdfa.Text}>${value.Text}</div>
        </c:if> 
		
        <ul>
            <c:forEach var="link" items="${content.valueList.LinkEntry}">
                <li><apollo:link link="${link}"><c:if test="${cms.element.setting.iconclass.isSet}"><span class="fa fa-${cms.element.setting.iconclass}"></span></c:if>${link.value.Text}</apollo:link></li>
            </c:forEach>
        </ul>
        
		</apollo:init-messages>
	</div>	
</cms:formatter>

</cms:bundle>