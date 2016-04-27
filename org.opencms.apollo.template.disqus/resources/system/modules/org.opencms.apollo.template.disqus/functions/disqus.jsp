<%@page buffer="none" session="false" import="org.opencms.file.*, org.opencms.main.*" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.disqus">
	<div class="a-disqus ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : 'mb-20' }">
		<c:choose>
			<c:when test="${not empty cms.element.settings.disqus}">
				<c:set var="disqusSite">${cms.element.settings.disqus}</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="disqusSite"><cms:property name="apollo.disqus" file="search" default=""/></c:set>
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when test="${empty disqusSite}">
				<div class="alert alert-danger"><fmt:message key="apollo.disqus.message.notset" /></div>
			</c:when>
			<c:when test="${cms.edited}">
				<div>${cms.enableReload}</div>
				<div class="alert alert-warning"><fmt:message key="apollo.disqus.message.edited" /></div>
			</c:when>
			<c:otherwise>

				<c:set var="cmsObject" value="${cms.vfs.cmsObject}"/>
				<c:choose>
					<c:when test="${cms.detailRequest}">
						<c:set var="fileName">${cms.detailContentSitePath}</c:set>
						<c:set var="pageId">${cms.detailContentId}</c:set>
					</c:when>
					<c:otherwise>
						<c:set var="fileName">${cms.requestContext.uri}</c:set>
						<c:set var="pageId">${content.vfs.readResource[fileName].structureId}</c:set>
					</c:otherwise>
				</c:choose>

				<div id="disqus_thread"></div>
				<script>

					var disqus_config = function () {
						this.page.url = '<%= OpenCms.getLinkManager().getOnlineLink((CmsObject)pageContext.getAttribute("cmsObject"),(String)pageContext.getAttribute("fileName")) %>';  
						this.page.identifier = '${pageId}';
					};

					(function() {  // DON'T EDIT BELOW THIS LINE
						var d = document, s = d.createElement('script');
						s.src = '//${disqusSite}.disqus.com/embed.js';
						s.setAttribute('data-timestamp', +new Date());
						(d.head || d.body).appendChild(s);
					})();
				</script>
				<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
			</c:otherwise>
		</c:choose>
	</div>
</cms:bundle>