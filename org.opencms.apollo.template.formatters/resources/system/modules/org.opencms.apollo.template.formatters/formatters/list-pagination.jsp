<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.list">
	<cms:formatter var="con" val="value" rdfa="rdfa">
	
	<div>${cms.reloadMarker}
		
		<%-- ####### Init messages wrapper ################################## --%>
		<c:set var="textnew"><fmt:message key="apollo.list.message.new" /></c:set>
		<c:set var="textedit"><fmt:message key="apollo.list.message.edit" /></c:set>
		<apollo:init-messages textnew="${textnew}" textedit="${textedit}">
		
			<%-- ####### List body ######## --%>
		
			<apollo:list-body element="${cms.element}" link="${value.Link}" headline="${value.Headline}" types="${value.TypesToCollect}" />
			
			<%-- ####### Javascript for AJAX to fill list body ######## --%>
			
			<c:set var="settings" value="${cms.element.settings}" />
			<c:set var="innerPageFile">%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/list/list-ajax.jsp:2f117c9d-3dc7-11e6-b70e-0242ac11002b)</c:set>
			<c:set var="linkInnerPage" value="${innerPageFile}?contentpath=${cms.element.sitePath}&teaserlength=${settings.teaserlength}&buttoncolor=${settings.buttoncolor}" />
			<c:set var="linkInnerPage" value="${linkInnerPage}&showexpired=${settings.showexpired}" />
			
			<script type="text/javascript">
				var lock = false;
				var init = false;
				
				function reloadInnerList(searchStateParameters) {
					if(!lock){
						lock = true;
						$('.spinner').show();
						$("#entrylist_box-${cms.element.id}").empty();
						$("#pagination_box-${cms.element.id}").empty();
						
						$.get("${linkInnerPage}&initialSearch=" + init + "&".concat(searchStateParameters), 
								function(resultList) {
									$(resultList).filter(".list-entry").appendTo('#entrylist_box-${cms.element.id}');
									$(resultList).filter('#pagination').appendTo('#pagination_box-${cms.element.id}')
									<c:if test="${not cms.element.settings.noFacets}">
										$('#listoption_box-${cms.element.id}').html($(resultList).filter("#listOptions"));
									</c:if>
									if(init && $(resultList).filter(".list-entry").length == 0){
										showEmpty();
									}
									$('.spinner').hide();
									init = false;
									showEditButtons();
									lock = false;
								});
						
						$('html, body').animate( { scrollTop : $("#${cms.element.id}-inner").offset().top - 100 }, 1000 );
					}
				}
				
				function initList() {
					init = true;
					reloadInnerList("");
				}
				
				function showEmpty(){
					$("#editbox-${cms.element.id}").show();
				}
				
				function showEditButtons(){
					if (typeof opencms != 'undefined' && typeof opencms.reinitializeEditButtons === 'function'){
						opencms.reinitializeEditButtons();
					} 
				}
			</script>
		</apollo:init-messages>
			
	</div>
	</cms:formatter>
</cms:bundle>