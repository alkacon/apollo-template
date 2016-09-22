<%@ tag display-name="list-body"
  trimDirectiveWhitespaces="true" 
  body-content="empty"
  description="Shows a list body to be used with AJAX calls for content."%>

<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="types" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="count" type="java.lang.Integer" required="false" %>
<%@ attribute name="dynamic" type="java.lang.Boolean" required="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="element" value="${cms.element}" />
<c:set var="count">${empty count ? 4 : count}</c:set>
<c:set var="approxElemHeight">150</c:set>

<%-- ####### Headline ########################################### --%>
		
<c:if test="${!element.setting.hidetitle.toBoolean}">
	<div class="headline headline-md"><h2 ${headline.rdfaAttr}><c:out value="${headline}" escapeXml="false" /></h2></div>
</c:if>

<%-- ####### The list (AJAX will insert here) ################### --%>

<c:set var="ajaxlink"><cms:link>/system/modules/org.opencms.apollo/elements/list/list-ajax.jsp</cms:link></c:set>
<div class="ap-list-content pagination-${element.settings.buttoncolor} mb-20" id="ap-list-content-${element.id}"
								data-id="${element.id}" 
								data-ajax="${ajaxlink}"
								data-teaser="${element.settings.teaserlength}" 
								data-path="${element.sitePath}" 
								data-color="${element.settings.buttoncolor}" 
								data-showdate="${element.settings.showdate}"
								data-expired="${element.settings.showexpired}" 
								data-sitepath="${cms.requestContext.folderUri}" 
								data-dynamic="${dynamic ? 'true' : 'false'}"
								data-minheight="${count * approxElemHeight}"
								data-locale="${cms.locale}">
							
	<div class="entrylist_box" style="min-height: ${count * approxElemHeight}px;">
		<div class="col-xs-12">
			<div class="spinner animated mv-20" style="display: none; transform: none;">
				<div class="spinnerInnerBox"><i class="fa fa-spinner"></i></div>
			</div>
		</div>
	</div>
	<div class="pagination_box" style="min-height: 50px;"></div>
  
	<%-- ####### Create and edit new entries if empty result ######## --%>
	
	<c:set var="createType">${fn:substringBefore(types.stringValue, ':')}</c:set>
	<div class="editbox" style="display: none;" >
		<cms:edit createType="${createType}" create="true" >
			<div class="alert alert-warning fade in">
				<h3><fmt:message key="apollo.list.message.empty" /></h3>
				<div><fmt:message key="apollo.list.message.newentry" /></div>
			</div>
		</cms:edit>
	</div>
</div>


