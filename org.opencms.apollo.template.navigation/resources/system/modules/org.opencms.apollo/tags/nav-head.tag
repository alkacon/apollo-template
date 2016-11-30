<%@ tag
    display-name="nav-head"
    trimDirectiveWhitespaces="true"
    description="Generates the head navigation." %>

<%@ attribute name="startlevel" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" 
    description="The start level of the navigation."%>

<%@ attribute name="pageUri" type="java.lang.String" required="true" 
    description="The requested page URI."%>

<%@ attribute name="folderUri" type="java.lang.String" required="true" 
    description="The start folder URI, usually from the current request context."%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<apollo:megamenu mode="none" />
<c:set var="MENU_XML" value="${megamenuFilename}" />

<c:set var="pathparts" value="${fn:split(folderUri, '/')}" />
<c:set var="navStartLevel">${startlevel.toInteger}</c:set>
<c:set var="navStartFolder" value="/" />
<c:forEach var="folderName" items="${pathparts}" varStatus="status">
    <c:if test="${status.count <= navStartLevel}">
        <c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
    </c:if>
</c:forEach>

<cms:navigation 
    type="forSite" 
    resource="${navStartFolder}" 
    startLevel="${navStartLevel}" 
    endLevel="${navStartLevel + 3}"
    locale="${cms.locale}"
    var="nav"/>

<div class="collapse navbar-collapse mega-menu navbar-responsive-collapse">
<div class="container">
<ul class="nav navbar-nav">

<c:set var="oldLevel" value="" />
<c:forEach items="${nav.items}" var="elem" varStatus="status">
    <c:set var="currentLevel" value="${elem.navTreeLevel}" />

    <c:choose>
      <c:when test="${empty oldLevel}"></c:when>
      <c:when test="${currentLevel > oldLevel}"><c:out value='<ul class="dropdown-menu">' escapeXml="false" /></c:when>
      <c:when test="${currentLevel == oldLevel}"><c:out value='</li>' escapeXml="false" /></c:when>
      <c:when test="${oldLevel > currentLevel}">
        <c:forEach begin="${currentLevel + 1}" end="${oldLevel}">
            <c:out value='</li></ul>' escapeXml="false" />
        </c:forEach>
      </c:when>
    </c:choose>

    <c:set var="markItem">false</c:set>
    <c:if test="${fn:startsWith(cms.requestContext.uri, elem.resourceName) 
        || (elem.navigationLevel && fn:startsWith(cms.requestContext.uri, elem.parentFolderName))}">
      <c:set var="markItem">true</c:set>
    </c:if>

    <c:set var="parentItem">false</c:set>
    <c:if test="${currentLevel == navStartLevel}">
      <c:set var="parentItem">true</c:set>
    </c:if>

    <c:set var="listClass" value="" />
    <c:if test="${markItem}">
      <c:set var="listClass">class="active"</c:set>
    </c:if>

    <c:set var="nextElemDeeper">false</c:set>
    <c:if test="${not status.last}">
      <c:forEach items="${nav.items}" var="nextelem" varStatus="nextstatus">
        <c:if test="${nextstatus.count eq (status.count + 1) and nextelem.navTreeLevel > currentLevel}">
          <c:set var="nextElemDeeper">true</c:set>
          <c:choose>
            <c:when test="${parentItem}">
              <c:set var="listClass">class="dropdown</c:set>
            </c:when>
            <c:otherwise>
              <c:set var="listClass">class="dropdown-submenu</c:set>
            </c:otherwise>
          </c:choose>
          <c:if test="${markItem or (parentItem and cms.subSitePath != '/' and fn:startsWith(elem.resourceName,cms.subSitePath))}">
             <c:set var="listClass">${listClass} active</c:set>
          </c:if>
          <c:set var="listClass">${listClass}"</c:set>
        </c:if>
      </c:forEach>
    </c:if>
    
    <c:set var="megamenuAttr" value="" />
    <c:if test="${parentItem}">
        <%-- ###### Check for megamenu ######--%>
        
        <c:if test="${elem.navigationLevel}">
            <%-- ###### Path correction needed if navLevel ###### --%>
            <c:set var="menuPath" value="${fn:replace(elem.resourceName, elem.fileName, '')}" />
        </c:if>
        <c:set var="megamenuPath"><cms:link>${menuPath}${MENU_XML}</cms:link></c:set>
        <c:if test="${cms.vfs.existsXml[megamenuPath]}">
            <c:set var="megamenuAttr" value="data-menu='${megamenuPath}'" />
        </c:if>
    </c:if>

    <li ${listClass} ${megamenuAttr}>

    <a href="<cms:link>${elem.resourceName}</cms:link>"
        <c:if test="${parentItem and nextElemDeeper}"> class="dropdown-toggle" data-toggle="dropdown"</c:if>
    >${elem.navText}</a>
 
    <c:set var="oldLevel" value="${currentLevel}" />
</c:forEach>

<c:forEach begin="${navStartLevel + 1}" end="${oldLevel}">
    <c:out value='</li></ul>' escapeXml="false" />
</c:forEach>

<c:if test="${not empty nav.items}"><c:out value='</li>' escapeXml="false" /></c:if>

<li id="searchButtonHeader">
    <i class="search fa fa-search search-btn"></i>
    <div class="search-open">
        <form class="form-inline" name="searchFormHeader" action="${cms.functionDetail['Search page']}" method="post">
            <div class="input-group animated fadeInDown" id="searchContentHeader">
                <input type="text" name="q" class="form-control" placeholder="Search" id="searchWidgetAutoCompleteHeader" />
                <span class="input-group-btn">
                    <button class="btn" type="button" onclick="this.form.submit(); return false;">Go</button>
                </span>
            </div>
        </form>
    </div>
</li>
    
    
</ul><%-- main list--%>
</div><%-- container--%>
</div><%-- collapse --%>
