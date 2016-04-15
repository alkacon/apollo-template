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
</c:if>

<div class="oc-container-${variant} ${(empty cms.container.type) ? 'mh-20' : ''}">
  <h1>
    <c:choose>
      <c:when test="${boxType == 'detail-placeholder'}">
        <fmt:message key="apollo.row.detailcontainer"/>
        <div class="oc-label-special"><fmt:message key="apollo.row.blocked"/></div>
        <div class="oc-label-detailonly"><fmt:message key="apollo.row.detailonly"/></div>
      </c:when>
      <c:otherwise>
        <fmt:message key="apollo.row.headline.emptycontainer"/>
        <div class="oc-label-${fn:toLowerCase(role)}">${fn:toUpperCase(role)}</div>
        <c:choose>
          <c:when test="${detailView == 'true'}">
            <div class="oc-label-detail"><fmt:message key="apollo.row.detailview"/></div>
          </c:when>
          <c:when test="${cms.detailRequest && (cms.element.setting.detail == 'only')}">
            <div class="oc-label-detail"><fmt:message key="apollo.row.detailonly"/></div>
          </c:when>
        </c:choose>
      </c:otherwise>
    </c:choose>
  </h1>
  <p class="fc-grey-dark lh-12">
    ${label}<br>
    <c:if test="${not empty cms.container.type}">
      <small>
        <fmt:message key="apollo.row.in"/>
        ${fn:toUpperCase(fn:substring(cms.container.type, 0, 1))}${fn:substring(cms.container.type, 1, -1)}
        -
        <fmt:message key="apollo.row.for"/>
        ${fn:toUpperCase(fn:substring(type, 0, 1))}${fn:substring(type, 1, -1)}
    </small>
    </c:if>
    <c:if test="${empty cms.container.type}">
      <small>
        <fmt:message key="apollo.row.for"/>
        ${fn:toUpperCase(fn:substring(type, 0, 1))}${fn:substring(type, 1, -1)}
      </small>
    </c:if>
  </p>
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
