<%@ tag 
    display-name="megamenu"
    body-content="scriptless"
    trimDirectiveWhitespaces="true" 
    description="Shows the standard message boxes when a new element is used." %>

<%@ attribute name="mode" type="java.lang.String" required="true" %>

<%@ variable name-given="containerSuffix" scope="AT_END" declare="true" %>
<%@ variable name-given="containerTypes" scope="AT_END" declare="true" %>
<%@ variable name-given="megamenuFilename" scope="AT_END" declare="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- ######## ------------------------------------ ######## --%>
<%-- ######## Supported values for attribute mode: ######## --%>
<%-- ######## - wrapContainer                      ######## --%>
<%-- ######## - skipTemplatePart                   ######## --%>
<%-- ######## ------------------------------------ ######## --%>

<c:set var="megamenuFilename">mega.menu</c:set>
<c:set var="isMegaMenuRequest">${fn:endsWith(cms.requestContext.uri, megamenuFilename)}</c:set>
<c:set var="containerSuffix">${isMegaMenuRequest ? "-megamenu" : ""}</c:set>
<c:set var="containerTypes">${isMegaMenuRequest ? ",row" : ""}</c:set>

<c:if test="${mode == 'wrapContainer' && !cms.isOnlineProject && isMegaMenuRequest && !param.ajaxreq}"><c:set var="wrapContainer" value="true" /></c:if>
<c:if test="${mode == 'skipTemplatePart' && param.ajaxreq}"><c:set var="skipTemplatePart" value="true" /></c:if>

<c:if test="${wrapContainer}">
    <div id="megamenu-editor">
    <div class="container">
        <c:if test="${cms.isEditMode}"><c:set var="wrapContainer" value="true" />
            <div class="ap-panel  panel panel-default">
                <div class="panel-heading">
                    <h2 class="panel-title">
                        <div class="ap-panel-title">Editing Megamenu for <span class="color-blue">${cms.requestContext.folderUri}</span></div>
                    </h2>
                </div>
            </div>
        </c:if>
      <div class="ap-header">
        <div class="mega-menu">
          <ul class="nav navbar-nav">
           <li class="dropdown">
            <div class="dropdown-menu dropdown-megamenu">
</c:if>

<c:if test="${(empty skipTemplatePart || not skipTemplatePart)}">
  <jsp:doBody/>
</c:if>

<c:if test="${wrapContainer}">
            </div>
           </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</c:if>