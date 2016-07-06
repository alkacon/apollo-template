<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}"/>

<c:set var="titlePos"><cms:elementsetting name="titlepos" default="top" /></c:set>

	<div class="margin-bottom-30">
		<div class="job-page">
			<div class="row">
			
				<%-- ####### Title (1st position option) ######## --%>
				<div class="col-xs-12">
				<c:if test="${titlePos == 'top'}">
						<apollo:headline setting="${cms.element.setting}" headline="${content.value.Title}" />
				</c:if>
				</div>
		
				<%-- ####### INTRODUCTION ######## --%>
				<div class="col-xs-12">
					<div class="mb-20">
						<apollo:paragraph setting="${cms.element.setting}" paragraph="${value.Introduction}" imgalign="top"/>
					</div>
				</div>
			
			
			<%-- ####### Title (2nd position option) ######## --%>
			<c:if test="${titlePos == 'bottom'}">
				<div class="col-xs-12 headline-block">
					<apollo:headline setting="${cms.element.setting}" headline="${content.value.Title}" />
				</div>
			</c:if>
				
			</div>   
			
			<%-- ####### TEXT BLOCKS (with optional bootstrap)######## --%>
			<c:choose>
			<c:when test="${cms.element.settings.columns}">
				<c:forEach var="text" items="${content.valueList.Text}" varStatus="status">
					<c:if test="${status.index % 2 == 0}">
						<div class="row">
					</c:if>
						<div class="col-xs-12 col-sm-6">
							<apollo:paragraph setting="${cms.element.setting}" paragraph="${text}" />
						</div>
					<c:if test="${status.index % 2 == 1}">
						</div>
					</c:if>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:forEach var="text" items="${content.valueList.Text}" varStatus="status">
					<apollo:paragraph setting="${cms.element.setting}" paragraph="${text}" />
				</c:forEach>
			</c:otherwise>
			</c:choose>
			
			
			<%-- ####### BOTTOM PARAGRAPH ######## --%>
			<div class="row">
				<div class="col-xs-12">
					<apollo:paragraph setting="${cms.element.setting}" paragraph="${value.BottomText}"/>
				</div>
			</div>
			
			<%-- ####### LINK BUTTON ######## --%>
			<c:if test="${value.Link.isSet}">
				<c:set var="btnStyle" value="${cms.element.settings.btnstyle}" />
				<div class="row">
					<div class="${btnStyle == 'center' ? 'text-center' : ''} col-xs-12">
						<a href="<cms:link>${value.Link.value.URI}</cms:link>" ${value.Link.value.NewWindow.toBoolean ? 'target="_blank"' : ''}>
							<div class="btn ap-btn-${cms.element.settings.buttoncolor} ${btnStyle == 'full' ? 'center-block' : ''}">${value.Link.value.Text}</div>
						</a>
					</div>
				</div>
			</c:if>
			
		</div>                    
	</div>
</cms:formatter>