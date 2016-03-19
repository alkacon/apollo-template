<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content" val="value">

<c:choose>
<c:when test="${!content.value.Container.isSet
	|| (content.value.Container.isSet
	&& (fn:containsIgnoreCase(cms.container.type, content.value.Container)
		  || ((cms.container.type == 'locked') && !cms.dragMode)))}">
<%-- Element matches the configured parent container --%>

	<%-- Insert HTML for model group start (if required) --%>
	<apollo:container-box label="${content.value.Title}" boxType="model-start" />

	<c:if test="${content.value.PreMarkup.isSet}">
		<%-- Expand macros in markup --%>
		<c:set var="preMarkup" value="${fn:replace(content.value.PreMarkup, '$(param)', cms.element.setting.param.value)}" />
		<c:set var="link" value="" />
		<c:if test="${cms.element.setting.link.isSet}">
			<c:set var="link"><cms:link>${cms.element.setting.link}</cms:link></c:set>
		</c:if>
		${fn:replace(preMarkup, '$(link)', link)}
	</c:if>

	<c:set var="detailOnly" value="${(cms.element.setting.detail == 'only') ? 'true' : 'false' }" />
	<c:set var="showDetailOnly" value="${(cms.isEditMode) and (detailOnly == 'true') and (not cms.detailRequest)}" />
	<c:set var="grid" value="${cms.element.setting.grid.value}" />

	<c:forEach var="column" items="${content.valueList.Column}" varStatus="loop">

		<c:set var="detailView" value="${((loop.count == 1) and (cms.element.setting.detail == 'view')) ? 'true' : 'false' }" />

		<c:if test="${column.value.PreMarkup.isSet}">${column.value.PreMarkup}</c:if>

		<c:choose>
			<c:when test="${showDetailOnly}">

				<%--
					If the container is shown only on detail pages, the container tag later would
					not generate any output on a page that is not a detail page.
					Therefore we insert a placeholder in this case.
				--%>
				<div class="${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}">
					<apollo:container-box label="${content.value.Title}${column.value.Name.isSet ? ' - ' += column.value.Name : ''}"  boxType="detail-placeholder" />
				</div>

			</c:when>
			<c:when test="${column.value.Count.stringValue != '0'}">

				<%--
					Generate the container tag.
				--%>
                
				<c:set var="role" value="${column.value.Editors.isSet ? column.value.Editors : (content.value.Defaults.isSet ? content.value.Defaults.value.Editors : 'ROLE.DEVELOPER')}" />
                <c:set var="parent_role" value="${cms.container.param}" />
                <c:choose>
                  <c:when test="${(role == 'ROLE.DEVELOPER') or (parent_role == 'ROLE.DEVELOPER')}">
                    <c:set var="role" value="ROLE.DEVELOPER" />
                    <c:set var="myrole" value="DEVELOPER" />
                  </c:when>
                  <c:when test="${(role == 'ROLE.EDITOR') or (parent_role == 'ROLE.EDITOR')}">
                    <c:set var="role" value="ROLE.EDITOR" />
                    <c:set var="myrole" value="EDITOR" />
                  </c:when>
                  <c:otherwise>
                    <c:set var="role" value="ROLE.ELEMENT_AUTHOR" />
                    <c:set var="myrole" value="AUTHOR" />
                  </c:otherwise>
                </c:choose>
                
				<c:set var="typeName" value="${column.value.Type.isSet ? column.value.Type : (content.value.Defaults.isSet ? content.value.Defaults.value.Type : 'unknown')}" />
				<c:if test="${grid.charAt(loop.count - 1) == '1'.charAt(0)}">
					<c:set var="typeName" value="container" />
				</c:if>
				<c:if test="${grid.charAt(loop.count - 1) == 'X'.charAt(0)}">
					<c:set var="typeName" value="locked" />
				</c:if>
				<c:set var="cssClass">${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}</c:set>
				<cms:container

					name="${column.value.Name}"
					type="${typeName}"
					tagClass="${cssClass}"
					maxElements="${column.value.Count.isSet ? column.value.Count : (content.value.Defaults.isSet ? content.value.Defaults.value.Count : '50')}"
					detailview="${detailView}"
					detailonly="${detailOnly}"
					editableby="${role}"
					param="${role}">

					<apollo:container-box
						label="${content.value.Title}${column.value.Name.isSet ? ' - ' += column.value.Name : ''}"
						boxType="container-box"
						role="${myrole}"
						type="${typeName}"
						detailView="${detailView}"  />

				</cms:container>

			</c:when>
			<c:otherwise>

				<%--
					The number of elements this container accepts is zero.
					No container is generated, but the layout grid DIV element is written.
					This can be required for layout purposes, e.g. empty placeholders.
				--%>
				<div class="${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}"></div>

			</c:otherwise>
		</c:choose>

		<c:if test="${column.value.PostMarkup.isSet}">${column.value.PostMarkup}</c:if>

	</c:forEach>

	<c:if test="${content.value.PostMarkup.isSet}">
		${content.value.PostMarkup}
	</c:if>

	<%-- Insert HTML for model group end (if required) --%>
	<apollo:container-box label="${content.value.Title}" boxType="model-end" />

</c:when>
<c:otherwise>
<%-- Element does not match parent container, don't generate output --%>
</c:otherwise>
</c:choose>

</cms:formatter>
