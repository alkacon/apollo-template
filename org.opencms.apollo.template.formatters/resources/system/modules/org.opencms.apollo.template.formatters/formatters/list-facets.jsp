<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<div id="listoption_box-${cms.element.id}" class="listoptionbox btn-group-${cms.element.settings.buttoncolor} btn-group-select-${cms.element.settings.selectioncolor}" 
						data-id="${cms.element.id}" data-facets="${cms.element.settings.showfacets}">
			${cms.reloadMarker}
			<c:if test="${cms.isEditMode}">
				<div class="editMessage-${cms.element.id} alert alert-warning">
					<h3>
						<fmt:message key="apollo.list.message.facets" />&nbsp;${value.Headline}
					</h3>
					<fmt:message key="apollo.list.message.facetsusage" />
				</div>
			</c:if>
			
		</div>
		
	</cms:formatter>

</cms:bundle>