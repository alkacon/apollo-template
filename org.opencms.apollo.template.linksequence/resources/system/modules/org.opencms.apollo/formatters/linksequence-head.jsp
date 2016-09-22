<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.linksequence">

<cms:formatter var="content" val="value" rdfa="rdfa">
    <div class="ap-linksequence-hf ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">

        <%-- ####### Init messages wrapper ################################## --%>
        <c:set var="textnew"><fmt:message key="apollo.linksequence.message.new" /></c:set>
        <apollo:init-messages textnew="${textnew}" textedit="">

        <div class="container">
            <div class="links">
                <ul class="pull-${cms.element.setting.linkalign}">

               <c:if test="${fn:contains(cms.container.type, 'head') or fn:contains(cms.container.type, 'navigation') or fn:contains(cms.container.type, 'segment')}">
	                <c:set var="langlinks" value="" />
	                <c:set var="showlang" value="false" />
	                <c:forEach var="locentry" items="${cms.localeResource}">
	                    <c:choose>
	                        <c:when test="${empty locentry.value}"></c:when>
	                        <c:when test="${locentry.key == cms.locale}">
	                            <c:set var="langlinks">${langlinks}<li class="active"><a href="#">${locentry.key}${' '}<i class="fa fa-check"></i></a></li></c:set>    
	                        </c:when>
	                        <c:otherwise>
	                            <c:set var="showlang" value="true" />
	                            <c:set var="langlinks">${langlinks}<li><a href="<cms:link>${locentry.value.link}</cms:link>">${locentry.key}</a></li></c:set>   
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	                <c:if test="${showlang}">
	                    <li class="hoverSelector">
	                        <i class="fa fa-globe"></i>
	                        <a><fmt:message key="apollo.linksequence.message.languages" /></a>
	                        <ul class="languages hoverSelectorBlock">
	                            <c:out value="${langlinks}" escapeXml="false" />
	                        </ul>
	                    </li>
	                    <li class="divider"></li>
	                </c:if>
                </c:if>

                <c:forEach var="link" items="${content.valueList.LinkEntry}" varStatus="status">
                    <li><apollo:link link="${link}">${link.value.Text}</apollo:link></li>
                    <c:if test="${not status.last}">
                        <li class="divider"></li>
                    </c:if>
                </c:forEach>
                </ul>
            </div>
        </div>

        </apollo:init-messages>
    </div>  
</cms:formatter>

</cms:bundle>