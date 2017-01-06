<%@ tag 
    display-name="language-linklist"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    import="java.lang.String, java.util.Locale"
    description="Displays a list of language links to choose between different locales of a page." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<c:set var="langlinks" value="" />
<c:set var="showlinks" value="false" />
<c:forEach var="locentry" items="${cms.localeResource}">
    <c:set var="lockey" scope="request" value="${cms:convertLocale(locentry.key)}" />
    <c:set var="localeName">
        <%
            Locale locale = (Locale)request.getAttribute("lockey");
            // there seems to be no JSTL / EL option to get the 'native' language name from a locale 
            String nativeLanguageName = locale.getDisplayLanguage(locale);
        %>
        <%= nativeLanguageName %>
    </c:set>
    <c:choose>
        <c:when test="${empty locentry.value}">
            <c:set var="subsiteLink">${cms.vfs.localeResource[cms.subSitePath][locentry.key].link}</c:set>
            <c:set var="langlinks">${langlinks}<li><a href="${subsiteLink}">${localeName}</a></li></c:set>
            <c:if test="${not empty subsiteLink}">
                <c:set var="showlinks" value="true" />
            </c:if>
            
        </c:when>
        <c:when test="${locentry.key == cms.locale}">
            <c:set var="langlinks">${langlinks}<li class="active"><a href="#">${localeName}${' '}<i class="fa fa-check"></i></a></li></c:set>    
        </c:when>
        <c:otherwise>
            <c:set var="showlinks" value="true" />
            <c:set var="langlinks">${langlinks}<li><a href="${locentry.value.link}">${localeName}</a></li></c:set>   
        </c:otherwise>
    </c:choose>
</c:forEach>

<c:if test="${showlinks}">
    <ul class="languages hoverSelectorBlock">
        <c:out value="${langlinks}" escapeXml="false" />
    </ul>
</c:if>
