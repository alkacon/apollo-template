<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

    <c:set var="exprStart" value="?(link)##" />
    <c:set var="exprEnd" value="##" />
    <c:if test="${fn:contains(preMarkup, exprStart)}">
        <c:set var="preSplit" value="${fn:substringBefore(preMarkup, exprStart)}" />
        <c:set var="checkSplit" value="${fn:substringAfter(preMarkup, exprStart)}" />
        <c:set var="expressionSplit" value="${fn:substringBefore(checkSplit, exprEnd)}" />
        <c:set var="postSplit" value="${fn:substringAfter(checkSplit, exprEnd)}" />
        <c:choose>
            <c:when test="${cms.element.setting.link.isSet}">
                <c:set var="preMarkup" value="${preSplit}${expressionSplit}${postSplit}" />
            </c:when>
            <c:otherwise>
                <c:set var="preMarkup" value="${preSplit}${postSplit}" />
            </c:otherwise>
        </c:choose>
    </c:if>

    <c:set var="link" value="" />
    <c:set var="anchor" value="" />
    <c:if test="${cms.element.setting.link.isSet}">
        <c:choose>
          <c:when test="${fn:startsWith(cms.element.setting.link, '#')}">
            <c:set var="anchor"><a id="${fn:substringAfter(cms.element.setting.link, '#')}" class="anchor"></a></c:set>
          </c:when>
          <c:otherwise>
            <c:set var="link"><cms:link>${cms.element.setting.link}</cms:link></c:set>
          </c:otherwise>
        </c:choose>
    </c:if>
    ${fn:replace(preMarkup, '$(link)', link)}${anchor}
  </c:if>

  <c:set var="detailOnly" value="${(cms.element.setting.detail == 'only') ? 'true' : 'false' }" />
  <c:set var="showDetailOnly" value="${(cms.isEditMode) and (detailOnly == 'true') and (not cms.detailRequest)}" />
  <c:set var="grid" value="${cms.element.setting.grid.value}" />

  <%-- check for grid setting --%>
  <c:if test="${(not empty grid)}">
    <c:set var="gridParts" value="${fn:split(grid, ':')}" />
  </c:if>
  <c:forEach var="column" items="${content.valueList.Column}" varStatus="loop">

    <c:set var="detailView" value="${((loop.count == 1) and (cms.element.setting.detail == 'view')) ? 'true' : 'false' }" />
    <c:set var="typeName" value="${column.value.Type.isSet ? column.value.Type : (content.value.Defaults.isSet ? content.value.Defaults.value.Type : 'unknown')}" />
    <c:set var="preMarkup"  value="${column.value.PreMarkup.isSet  ? column.value.PreMarkup  : (content.value.Defaults.isSet ? content.value.Defaults.value.PreMarkup  : '')}" />
    <c:set var="postMarkup" value="${column.value.PostMarkup.isSet ? column.value.PostMarkup : (content.value.Defaults.isSet ? content.value.Defaults.value.PostMarkup : '')}" />
    <c:set var="tagElement" value="${column.value.TagElement.isSet ? column.value.TagElement : (content.value.Defaults.isSet ? content.value.Defaults.value.TagElement : 'div')}" />
    <c:if test="${not empty gridParts[loop.count -1]}">
      <c:set var="typeName" value="${fn:toLowerCase(gridParts[loop.count -1])}" />
    </c:if>

    <c:if test="${not empty preMarkup}">${preMarkup}</c:if>

    <c:choose>

      <c:when test="${showDetailOnly}">
        <%--
          If the container is shown only on detail pages, the container tag later would
          not generate any output on a page that is not a detail page.
          Therefore we insert a placeholder in this case.
        --%>
        <div class="${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}">
          <apollo:container-box
            label="${content.value.Title}${column.value.Name.isSet ? ' - '.concat(column.value.Name) : ''}"
            boxType="detail-placeholder"
            type="${typeName}" />
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
          </c:when>
          <c:when test="${(role == 'ROLE.EDITOR') or (parent_role == 'ROLE.EDITOR')}">
            <c:set var="role" value="ROLE.EDITOR" />
          </c:when>
          <c:otherwise>
            <c:set var="role" value="ROLE.ELEMENT_AUTHOR" />
          </c:otherwise>
        </c:choose>

        <c:set var="cssClass">${column.value.Grid.isSet ? column.value.Grid : (content.value.Defaults.isSet ? content.value.Defaults.value.Grid : '')}</c:set>
        <c:if test="${(not content.value.PreMarkup.isSet) and cms.element.setting.param.isSet}">
            <c:set var="cssClass">${cssClass}${' '}${cms.element.setting.param.value}</c:set>
        </c:if>
        <cms:container

          name="${column.value.Name}"
          type="${typeName}"
          tag="${tagElement}"
          tagClass="${cssClass}"
          maxElements="${column.value.Count.isSet ? column.value.Count : (content.value.Defaults.isSet ? content.value.Defaults.value.Count : '50')}"
          detailview="${detailView}"
          detailonly="${detailOnly}"
          editableby="${role}"
          param="${role}">

          <apollo:container-box
            label="${content.value.Title}${column.value.Name.isSet ? ' - '.concat(column.value.Name) : ''}"
            boxType="container-box"
            role="${role}"
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

    <c:if test="${not empty postMarkup}">${postMarkup}</c:if>

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
