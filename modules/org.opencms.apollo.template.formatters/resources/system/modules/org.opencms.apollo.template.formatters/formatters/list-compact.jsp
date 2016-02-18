<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="
	org.opencms.file.*,
	org.opencms.jsp.*,
	org.opencms.relations.*"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<div>
			${cms.reloadMarker}
			<c:choose>
				<c:when test="${cms.element.inMemoryOnly}">
					<div class="alert">
						<h3>
							<fmt:message key="apollo.list.message.new" />
						</h3>
					</div>
				</c:when>
				<c:when test="${cms.edited}">
					<div class="alert">
						<h3>
							<fmt:message key="apollo.list.message.edit" />
						</h3>
					</div>
				</c:when>
				<c:otherwise>
					<c:if test="${not cms.element.settings.hidetitle}">
						<div class="headline headline-md">
							<h2 ${rdfa.Headline}>
								<c:out value="${value.Headline}" escapeXml="false" />
							</h2>
						</div>
					</c:if>

					<c:set var="resType">${fn:substringBefore(value.TypesToCollect.stringValue, ':')}</c:set>
					<c:set var="itemsPerPage"><c:out value="${value.ItemsPerPage}" default="5" /></c:set>

					<c:set var="solrParamCats"></c:set>
					<c:if test="${value.Category.isSet}">
						<c:set var="firstCat" value="true" />
						<c:forTokens items="${value.Category.stringValue}" delims="," var="catPath">
							<c:if test="${not firstCat}"><c:set var="catFilter">${catFilter} OR </c:set></c:if>
							<%
								CmsJspActionElement jsp = new CmsJspActionElement(pageContext, request, response);
								CmsObject cms = jsp.getCmsObject();
								String cPath = (String)pageContext.getAttribute("catPath");
								CmsCategory cat = CmsCategoryService.getInstance().getCategory(cms, cms.getRequestContext().addSiteRoot(cPath));
					            pageContext.setAttribute("catPath", cat.getPath());
							%>
							<c:set var="catFilter">${catFilter} "${catPath}"</c:set>
							<c:set var="firstCat" value="false" />
						</c:forTokens>
						<c:set var="solrParamCats">&fq=category:(${catFilter})</c:set>
					</c:if>
					<c:set var="extraSolrParams">fq=type:${resType}&fq=parent-folders:"${cms.requestContext.siteRoot}${cms.subSitePath}"${solrParamCats}&sort=newsdate_${cms.locale}_dt ${value.SortOrder}${value.FilterQueries}</c:set>
					<c:set var="searchConfig">
						{	"ignorequery" : true, 
							"pagesize" : ${itemsPerPage},
							"extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}"
						}
					</c:set>
					<cms:search configString="${searchConfig}" var="search"	addContentInfo="true" />

					<div class="posts lists">
						<c:forEach var="result" items="${search.searchResults}">
							<div class="row mb-20">
								<c:set var="teaserLength">${cms.element.settings.teaserlength}</c:set>
								<cms:display value="${result.xmlContent.filename}" displayFormatters="${value.TypesToCollect}" editable="true" create="true">
									<cms:param name="teaserLength">${teaserLength}</cms:param>
									<cms:param name="buttonColor">${cms.element.settings.buttoncolor}</cms:param>
									<cms:param name="showDate">${cms.element.settings.showdate}</cms:param>
									<cms:param name="compactForm">${cms.element.settings.compactform}</cms:param>
								</cms:display>
							</div>
						</c:forEach>	
					</div>
					
					<c:if test="${value.Link.exists}">
        				<p ${rdfa.Link}><a class="btn btn-u u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
        			</c:if>
        				
				</c:otherwise>
			</c:choose>
		</div>
	</cms:formatter>

</cms:bundle>