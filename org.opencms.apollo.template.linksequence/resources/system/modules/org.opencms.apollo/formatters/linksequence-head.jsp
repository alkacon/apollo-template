<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="java.lang.String, java.util.Locale" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.linksequence.messages">

<cms:formatter var="content" val="value" rdfa="rdfa">
    <div class="ap-linksequence-hf ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">

        <%-- ####### Init messages wrapper ################################## --%>
        <c:set var="textnew"><fmt:message key="apollo.linksequence.message.new" /></c:set>
        <apollo:init-messages textnew="${textnew}" textedit="">
            <div class="links">
                <ul class="pull-${cms.element.setting.linkalign}">

                    <c:if test="${cms.element.settings.showLanguageLinks}">
                        <c:set var="langLinks">
                            <apollo:language-linklist />
                        </c:set>
                        <c:if test="${not empty langLinks}">
                            <li class="hoverSelector">
                                <i class="fa fa-globe"></i>
                                <a><fmt:message key="apollo.linksequence.message.languages" /></a>
                                ${langLinks}
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
        </apollo:init-messages>
    </div>  
</cms:formatter>

</cms:bundle>