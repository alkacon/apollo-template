<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.file.types.CmsResourceTypeFolderSubSitemap, org.opencms.file.CmsResource"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.sitemap">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<div class="sitemap">
			<c:if test="${cms.element.settings.hideTitle ne 'true'}">
				<div class="headline">
					<h2 ${rdfa.Title}>${value.Title}</h2>
				</div>
			</c:if>
			<c:if test="${cms.element.settings.hideText ne 'true'}">
				<div ${rdfa.Text}>${value.Text}</div>
			</c:if>
			<c:choose>
				<c:when test="${cms.edited}">
					<div class="alert danger">
						<div class="alert">
							<h3>
								<fmt:message key="apollo.sitemap.message.edited" />
							</h3>
						</div>
						${cms.enableReload}
					</div>
				</c:when>
				<c:otherwise>
					<c:set var="startLevel">0</c:set>
					<c:set var="maxDepth">100</c:set>
					<c:if test="${value.MaximumDepth.isSet}">
						<c:set var="maxDepth">${value.MaximumDepth}</c:set>
					</c:if>
					<c:set var="firstLevel">0</c:set>
					<c:set var="colCount">0</c:set>
					<c:set var="ulCount">0</c:set>
					<c:set var="oldLevel" value="0" />
					<c:set var="hideItem">false</c:set>
					<c:set var="isSubsiteMap">false</c:set>
					<c:set var="subsiteMapLevel">0</c:set>

					<cms:navigation type="forSite" startLevel="${startLevel}"
						endLevel="${startLevel + maxDepth}" var="nav"
						resource="${value.ShowFrom.isSet and not empty value.ShowFrom? value.ShowFrom:cms.subSitePath}" />
					<ul class="row">
						<%--begin loop over all --%>
						<c:forEach items="${nav.items}" var="item" varStatus="status">
							<c:if test="${status.first }">
								<c:set var="firstLevel">${item.navTreeLevel}</c:set>
							</c:if>
							<c:if test="${item.navTreeLevel < maxDepth}">
								<c:set var="currentLevel"
									value="${item.navTreeLevel-firstLevel}" />
								<%--close opened ul tags --%>
								<c:if test="${currentLevel < oldLevel}">
									<c:forEach begin="${currentLevel+1}" end="${oldLevel}">
											</ul>
									</c:forEach>
									<c:set var="ulCount">${ulCount-currentLevel}</c:set>
									<c:if test="${currentLevel==0}">
										</ul>
									</c:if>
								</c:if>
								<%-- begin test if subsitemaps should be shown --%>
								<c:if test="${isSubsiteMap eq 'false'}">
									<c:set var="resource" value="${item.resource}" />
									<% pageContext.setAttribute("isSubsiteMap", CmsResourceTypeFolderSubSitemap.isSubSitemap((CmsResource)pageContext.getAttribute("resource")));%>
									<c:if test="${isSubsiteMap}">
										<c:set var="subsiteMapLevel">${currentLevel}</c:set>
									</c:if>
								</c:if>
								<c:choose>
									<c:when
										test="${value.IncludeSubSiteMaps == 'false' and isSubsiteMap eq 'true'  and hideItem eq 'false'}">
										<c:set var="hideItem">true</c:set>
									</c:when>
									<c:when
										test="${hideItem == 'true' and currentLevel == subsiteMapLevel}">
										<c:set var="isSubsiteMap">false</c:set>
										<c:set var="hideItem">false</c:set>
									</c:when>
								</c:choose>
								<%-- end test if subsitemaps should be shown --%>
								<c:if test="${hideItem == 'false'}">
									<c:choose>
										<%-- Special markup for top level --%>
										<c:when test="${currentLevel == 0}">
											<%-- close previous top level item --%>
											<c:if test="${not status.first and oldLevel == 0}">
												</ul>
											</c:if>
											<%-- Create new bootstrap in case of enough columns --%>
											<c:if
												test="${colCount > (not empty cms.element.settings.cols?((12/cms.element.settings.cols)-1):2)}">
			
												<c:set var="colCount">0</c:set>
												</ul>
												<ul class="row">
											</c:if>
											<c:set var="colCount">${colCount +1}</c:set>
											<c:set var="ulCount">${ulCount+1}</c:set>
											<ul
												class="col-xs-12 col-md-${not empty cms.element.settings.cols?cms.element.settings.cols: '4'}">
										</c:when>
										<%-- open new sublist in case of subitems --%>
										<c:when test="${currentLevel > oldLevel}">
											<c:set var="ulCount">${ulCount+1}</c:set>
											<ul
												${(value.SubFoldersOpenedPerDefault == 'true' or  (currentLevel == 1 and value.SitemapOpenedPerDefault == 'true'))?'':'style="display: none;"'}>
										</c:when>
									</c:choose>
									<%-- test if item includes subitems --%>
									<c:set var="parentItem">false</c:set>
									<c:forEach items="${nav.items}" var="nextItem"
										varStatus="nextstatus">
										<c:if
											test="${(nextstatus.index eq (status.index + 1) and (nextItem.navTreeLevel-firstLevel) > currentLevel) and nextItem.navTreeLevel < maxDepth}">
											<c:set var="parentItem">true</c:set>
										</c:if>
									</c:forEach>
									<%-- begin show of the item depending on type (parent or not) --%>
									<c:choose>
										<c:when test="${parentItem eq 'true'}">
											<li class="parent clearfix"><span>${item.navText}</span><i
												class="fa fa-chevron-down ${(value.SitemapOpenedPerDefault eq 'true' and currentLevel == 0) or (value.SubFoldersOpenedPerDefault eq 'true')?'open':'' }"></i>
											</li>
										</c:when>
										<c:otherwise>
											<li><a href="<cms:link>${item.resourceName}</cms:link>">${item.navText}</a>
											</li>
										</c:otherwise>
									</c:choose>
									<%-- end show of the item depending on type (parent or not) --%>
									<c:set var="oldLevel">${currentLevel}</c:set>
								</c:if>
							</c:if>
						</c:forEach>
						<%-- close opened sublists --%>
						<c:if test="${ulCount>0}">
							<c:forEach begin="0" end="${ulCount}">
								</ul>
							</c:forEach>
						</c:if>
						<%--end loop over all --%>
						</ul>
				</c:otherwise>
			</c:choose>
		</div>
		<script>
			function sitemap() {
				$('li').click(function() {
					$(this).next('ul').slideToggle();
					$(this).find('i').toggleClass('open');
				});
			}
		</script>
	</cms:formatter>
</cms:bundle>