<%@ tag 
    display-name="megamenu"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Wraps the body content for the mega menu editor (if required)." %>


<%@ attribute name="test" type="java.lang.String" required="false" 
    description="Tests if mega menu must be activated, possible value is 'isTemplateRequest' or 'none'."%>


<%@ variable name-given="containerName" scope="NESTED" declare="true" 
    description="The name of the main template container. This variable gets exported to requestScope." %>

<%@ variable name-given="containerTypes" scope="NESTED" declare="true"
    description="The types of the main template container. This variable gets exported to requestScope." %>

<%@ variable name-given="megamenuFilename" scope="NESTED" declare="true"
    description="The name of the megamenu file. This variable gets exported to requestScope." %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="templateContainerName" value="${requestScope.containerName}" />
<c:set var="templateContainerTypes" value="${requestScope.containerTypes}" />

<c:set var="megamenuFilename">mega.menu</c:set>
<c:set var="isMegaMenuRequest">${fn:endsWith(cms.requestContext.uri, megamenuFilename)}</c:set>
<c:set var="containerName">${templateContainerName}${isMegaMenuRequest ? "-megamenu" : ""}</c:set>
<c:set var="containerTypes">${templateContainerTypes}${isMegaMenuRequest ? ",row" : ""}</c:set>

<c:choose>

<c:when test="${(empty test) && !cms.isOnlineProject && isMegaMenuRequest && !param.ajaxreq}">
    <div id="megamenu-editor">
    <div class="container">
        <c:if test="${cms.isEditMode}"><c:set var="wrapContainer" value="true" />
            <div id="ap-megamenu-head">
                <div class="text">
                    Megamenu Editor
                </div>
                <div class="head">${cms.requestContext.folderUri}</div>
            </div>
        </c:if>
      <div class="ap-header">
        <div class="mega-menu">
          <ul class="nav navbar-nav">
           <li class="dropdown">
            <div class="dropdown-menu dropdown-megamenu">
                <jsp:doBody/>
            </div>
           </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</c:when>

<c:when test="${(empty test) || ((test == 'isTemplateRequest') && !param.ajaxreq)}">
    <jsp:doBody/>
</c:when>

</c:choose>

<c:set var="megamenuFilename" scope="request" >${megamenuFilename}</c:set>
<c:set var="containerName" scope="request" >${containerName}</c:set>
<c:set var="containerTypes" scope="request" >${containerTypes}</c:set>
