<%@ tag display-name="list-body"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Shows a list body to be used with AJAX calls for content."%>

<%@ attribute name="element" type="org.opencms.jsp.util.CmsJspStandardContextBean.CmsContainerElementWrapper" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- ####### Headline ########################################### --%>
		
<c:if test="${element.setting.hidetitle.toBoolean}">
	<div class="headline headline-md"><h2 ${headline.rdfaAttr}><c:out value="${headline}" escapeXml="false" /></h2></div>
</c:if>

<%-- ####### The list (AJAX will insert here) ################### --%>

	<c:set var="innerPageDivId">${element.id}-inner</c:set>
<div id="${innerPageDivId}">
	<div id="listoption_box-${element.id}"></div>
	<div id="entrylist_box-${element.id}"></div>
	<div id="pagination_box-${element.id}"></div>
</div>
<div class="spinner mv-20" style="display: none; position: initial; transform: none;">
	<i class="fa fa-spinner"></i>
</div>

<%-- ###### Simple link from content ############################ --%>

<c:if test="${link.exists}">
	<div class="mv-10">
		<a class="btn ap-btn-${element.setting.buttoncolor.toString} ap-btn-sm" href="<cms:link>${link.value.URI}</cms:link>">${link.value.Text}</a>
	</div>
</c:if>	

<%-- ####### Create and edit new entries if empty result ######## --%>

<c:set var="createType">${fn:substringBefore(types.stringValue, ':')}</c:set>
<div id="editbox-${element.id}" style="display: none;" >
	<cms:edit createType="${createType}" create="true" >
		<div class="alert alert-warning fade in">
			<h3><fmt:message key="apollo.list.message.empty" /></h3>
			<div><fmt:message key="apollo.list.message.newentry" /></div>
		</div>
	</cms:edit>
</div>
