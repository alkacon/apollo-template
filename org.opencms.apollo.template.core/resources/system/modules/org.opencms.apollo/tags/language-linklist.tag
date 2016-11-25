<%@ tag 
    display-name="language-linklist"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
	import="java.lang.String, java.util.Locale"
    description="Builds an unordered list of language links to choose between different locales of a site." %>
	

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:set var="langlinks" value="" />
<c:forEach var="locentry" items="${cms.localeResource}">
	<c:set var="tempLocale" scope="request">${locentry.key}</c:set>
	<c:set var="localeName">
		<% 
			String tempLocale = (String)request.getAttribute("tempLocale");
			Locale locale = new Locale(tempLocale);
			String localeName = locale.getDisplayLanguage(locale);
		%>
		<%= localeName %>
	</c:set>
	<c:choose>
		<c:when test="${empty locentry.value}">
			<c:set var="subsiteLink">${cms.vfs.localeResource[cms.subSitePath][locentry.key].link}</c:set>
			<c:set var="langlinks">${langlinks}<li><a href="<cms:link>${subsiteLink}</cms:link>">${localeName}</a></li></c:set>   
		</c:when>
		<c:when test="${locentry.key == cms.locale}">
			<c:set var="langlinks">${langlinks}<li class="active"><a href="#">${localeName}${' '}<i class="fa fa-check"></i></a></li></c:set>    
		</c:when>
		<c:otherwise>
			<c:set var="langlinks">${langlinks}<li><a href="<cms:link>${locentry.value.link}</cms:link>">${localeName}</a></li></c:set>   
		</c:otherwise>
	</c:choose>
</c:forEach>
<ul class="languages hoverSelectorBlock">
	<c:out value="${langlinks}" escapeXml="false" />
</ul>
