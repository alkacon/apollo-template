<%@tag display-name="container-box" body-content="empty"
       description="Generates box HTML for layout rows"%>

<%@attribute name="label" type="java.lang.String" required="true" %>
<%@attribute name="boxType" type="java.lang.String" required="true" %>

<%@attribute name="role" type="java.lang.String" required="false" %>
<%@attribute name="type" type="java.lang.String" required="false" %>
<%@attribute name="detailView" type="java.lang.String" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.row">

<c:choose>
<c:when test="${cms.isOnlineProject}">
<%-- Never generate any of output in online project --%>
</c:when>
<c:when test="${(boxType == 'container-box') || (boxType == 'detail-placeholder')}">
<%-- Use case 1: Create container or detail container placeholder box --%>

<c:set var="parent_role" value="${cms.container.param}" />

<c:choose>
  <c:when test="${(role == 'ROLE.DEVELOPER') or (parent_role == 'ROLE.DEVELOPER')}">
    <c:set var="myrole" value="developer" />
  </c:when>
  <c:when test="${(role == 'ROLE.EDITOR') or (parent_role == 'ROLE.EDITOR')}">
    <c:set var="myrole" value="editor" />
  </c:when>
  <c:otherwise>
    <c:set var="myrole" value="author" />
  </c:otherwise>
</c:choose>

<c:choose>
  <c:when test="${boxType == 'detail-placeholder'}">
    <c:set var="variant" value="detailonly" />
  </c:when>
  <c:when test="${type == 'mainsection' || type == 'grid'}">
    <c:set var="variant" value="jsp" />
  </c:when>
  <c:when test="${not fn:containsIgnoreCase(type, 'default')}">
    <c:set var="variant" value="template" />
  </c:when>  <c:otherwise>
    <c:set var="variant" value="layout" />
  </c:otherwise>
</c:choose>

<div class="oc-container-${variant}">
  <h1>
    <c:choose>
      <c:when test="${boxType == 'detail-placeholder'}">
        Detail container <div class="oc-label-special">BLOCKED</div>
        <div class="oc-label-detailonly">Only for detail pages</div>
      </c:when>
      <c:otherwise>
        <fmt:message key="apollo.row.headline.emptycontainer"/>
        <div class="oc-label-${myrole}">${fn:toUpperCase(myrole)}</div>
        <c:choose>
          <c:when test="${detailView == 'true'}">
            <div class="oc-label-detail">DETAIL VIEW</div>
          </c:when>
          <c:when test="${cms.detailRequest && (cms.element.setting.detail == 'only')}">
            <div class="oc-label-detail">Only for detail pages</div>
          </c:when>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </h1>
  <p>${label} - In: ${cms.container.type} For: ${type}</p>
</div>

<%-- End of use case 1: Create container box --%>
</c:when>
<c:when test="${(boxType == 'model-start') && cms.modelGroupElement }">
<%-- Use case 2: Model box start --%>

<c:set var="modelTitle">${label}</c:set>
<c:if test="${not empty cms.element.setting.model_group_title}">
  <c:set var="modelTitle">${cms.element.setting.model_group_title}</c:set>
</c:if>

<div class="oc-modelinfo">

  <div class="row">
    <div class="col-xs-12">
      <div class="alert alert-info" role="alert">
        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <strong>Model:</strong> <em>${modelTitle}</em><br>
        <strong>Description:</strong> ${cms.element.setting.model_group_description}
      </div>
    </div>
  </div>
  <%-- Last div is deliberately not closed --%>

<%-- End of use case 2: Model box start --%>
</c:when>
<c:when test="${(boxType == 'model-end') && cms.modelGroupElement }">
<%-- Use case 3: Model box end --%>

</div>

<%-- End of use case 3: Model box end --%>
</c:when>
</c:choose>

</cms:bundle>
