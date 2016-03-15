<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="filterQuery">
{
    "ignorequery" : true,
    "extrasolrparams" : 'fq=parent-folders:"${cms.requestContext.siteRoot}${cms.subSitePath}"&fq=type:alkacon-v8-feed'
}
</c:set>

<cms:search configString="${filterQuery}" var="search" addContentInfo="true"/>

<c:forEach var="result" items="${search.searchResults}">
    <c:set var="rssTitle"><cms:property name="Title" file="${result.xmlContent.filename}" default="RSS - ${result.xmlContent.filename}" /></c:set>
    <link rel="alternate" type="application/rss+xml" href="<cms:link>${result.xmlContent.filename}</cms:link>" title="${rssTitle}">
</c:forEach>