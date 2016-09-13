<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>	

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.tabs">
<cms:formatter var="content" val="value" rdfa="rdfa">

	<c:set var="textnew"><fmt:message key="apollo.tabs.message.new" /></c:set>
	<apollo:init-messages textnew="${textnew}">

		<div class="ap-tab-section ${cms.element.setting.wrapperclass}">

			<c:if test="${not cms.element.settings.hidetitle}">
				<div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
			</c:if>

			<div class="ap-tab">
				<ul class="nav nav-tabs">
					<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
						<li ${status.first ? ' class="active"' : ''}><a href="#collapse-${cms.element.instanceId}-${status.count}" data-toggle="tab">${label}</a></li>
					</c:forEach>
				</ul>

				<div class="tab-content">
					<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">

						<div 
							id="collapse-${cms.element.instanceId}-${status.count}"
							class="tab-pane ap-tab-pane fade ${status.first? 'active in':''}" >
						<cms:container
							name="tab-container${status.count}"
							type="row"
							maxElements="10">
								<c:set var="msg"><fmt:message key="apollo.tabs.emptycontainer.text"/></c:set>
								<apollo:container-box
									label="${msg}"
									boxType="container-box"
									role="author"
									type="row" />
							</cms:container>
						</div>

					</c:forEach>
				</div>
			</div>

		</div>
		
	</apollo:init-messages>

</cms:formatter>
</cms:bundle>
