<%@tag display-name="container-box"
  body-content="empty"
  trimDirectiveWhitespaces="true"
  description="Displays the placehoder boxes for containers and model groups." %>


<%@attribute name="label" type="java.lang.String" required="true"
        description="Usually the name of the element or the group."%>

<%@attribute name="boxType" type="java.lang.String" required="true"
        description="Determines to type of box to render.
        Possible values are [
        container-box: Render a standard container placeholder.
        detail-placeholder: Render a detailpage specific placeholder.
        model-start: Renders the opening part of a model placeholder box.
        model-end: Renders the closing part of a model placeholder box.
        ]"%>

<%@attribute name="role" type="java.lang.String" required="false"
        description="The role of the user. Used for displaying in the box." %>

<%@attribute name="type" type="java.lang.String" required="false"
        description="The type of elements the container takes." %>

<%@attribute name="detailView" type="java.lang.String" required="false"
        description="A boolean that indicates if this is a detail container." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<fmt:setLocale value="${cms.workplaceLocale}" />
<cms:bundle basename="org.opencms.apollo.template.layoutrow.messages">

<c:choose>
<c:when test="${cms.isOnlineProject or not cms.isEditMode}">
<%-- Never generate any output in the online project --%>
</c:when>
<c:when test="${(boxType == 'container-box') || (boxType == 'detail-placeholder')}">
<%-- Use case 1: Create container or detail container placeholder box --%>

<c:choose>
  <c:when test="${fn:containsIgnoreCase(type, 'area')}">
    <c:set var="variant" value="area" />
  </c:when>
  <c:when test="${fn:containsIgnoreCase(type, 'segment')}">
    <c:set var="variant" value="segment" />
  </c:when>
  <c:when test="${fn:containsIgnoreCase(type, 'grid')}">
    <c:set var="variant" value="grid" />
  </c:when>
  <c:when test="${fn:containsIgnoreCase(type, 'row')}">
    <c:set var="variant" value="row" />
  </c:when>
  <c:when test="${fn:containsIgnoreCase(type, 'element')}">
    <c:set var="variant" value="element" />
  </c:when>
  <c:otherwise>
    <c:set var="variant" value="special" />
  </c:otherwise>
</c:choose>

<c:if test="${not empty role}">
  <c:set var="role" value="${fn:substringAfter(role, '.')}" />
  <c:if test="${fn:startsWith(role, 'ELEMENT_')}">
      <c:set var="role" value="${fn:substringAfter(role, '_')}" />
  </c:if>
  <c:set var="role" value="${fn:toLowerCase(role)}" />
</c:if>

<c:set var="parentType" value="Template Container" />
<c:if test="${not empty cms.container.parentInstanceId}">
    <c:set var="parentType" value="${cms.parentContainers[cms.container.parentInstanceId].type}" />
</c:if>

<div id="ap-container" class="box-${variant}${(empty cms.container.type) ? ' mh-20' : ''}">
  <div class="head">
    <c:choose>
      <c:when test="${boxType == 'detail-placeholder'}">
        <fmt:message key="apollo.row.detailcontainer"/>
        <div class="ap-label-special"><fmt:message key="apollo.row.blocked"/></div>
        <div class="ap-label-detailonly"><fmt:message key="apollo.row.detailonly"/></div>
      </c:when>
      <c:otherwise>
        <fmt:message key="apollo.row.headline.emptycontainer"/>
        <div class="ap-label-${fn:toLowerCase(role)}"><fmt:message key="apollo.row.role.${role}"/></div>
        <c:choose>
          <c:when test="${detailView == 'true'}">
            <div class="ap-label-detail"><fmt:message key="apollo.row.detailview"/></div>
          </c:when>
          <c:when test="${cms.detailRequest && (cms.element.setting.detail == 'only')}">
            <div class="ap-label-detail"><fmt:message key="apollo.row.detailonly"/></div>
          </c:when>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </div>
  <div class="text capital">
    <div class="main">${label}</div>
    <c:if test="${not empty cms.container.type}">
      <div class="small">
        <fmt:message key="apollo.row.in"/>
        <c:out value=" ${parentType} - " />
        <fmt:message key="apollo.row.for"/>
        <c:out value=" ${type}" />
    </div>
    </c:if>
    <c:if test="${empty cms.container.type}">
      <div class="small">
        <fmt:message key="apollo.row.for"/>
        <c:out value=" ${type}" />
      </div>
    </c:if>
  </div>
</div>

<%-- End of use case 1: Create container box --%>
</c:when>

<c:when test="${(boxType == 'model-start') && cms.modelGroupElement }">
<%-- Use case 2: Model box start --%>

<c:out value='<div id="ap-modelinfo-border">' escapeXml='false' />
  <div id="ap-modelinfo">
        <div class="head">
            <cms:property name="Title" />
            <c:choose>
                <c:when test="${cms.element.setting.use_as_copy_model == 'true'}">
                    <div class="ap-label-copygroup"><fmt:message key="apollo.row.modelinfo.copygroup"/></div>
                </c:when>
                <c:otherwise>
                    <div class="ap-label-reusegroup"><fmt:message key="apollo.row.modelinfo.reusegroup"/></div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="text"><cms:property name="Description" /></div>
  </div>
  <%-- Last div is deliberately not closed, it has to be closed by using "model-end" (see below) --%>

<%-- End of use case 2: Model box start --%>
</c:when>

<c:when test="${(boxType == 'model-end') && cms.modelGroupElement }">
<%-- Use case 3: Model box end --%>

<c:out value='</div>' escapeXml='false' />

<%-- End of use case 3: Model box end --%>
</c:when>
</c:choose>

</cms:bundle>
