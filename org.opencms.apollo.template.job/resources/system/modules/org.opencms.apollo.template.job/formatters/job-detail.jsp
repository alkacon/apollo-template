<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>
<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}"/>
<cms:bundle basename="org.opencms.apollo.template.job.messages">

<c:set var="titlePos"><cms:elementsetting name="titlepos" default="top" /></c:set>

	<div class="mb-20">
		<c:set var="inMemoryMessage"><fmt:message key="apollo.job.message.inmemory" /></c:set>
		<apollo:init-messages textnew="${inMemoryMessage}">
			<div class="job-page">
				<div class="row">
				
					<%-- ####### Title (1st position option) ######## --%>
					<div class="col-xs-12">
					<c:if test="${titlePos == 'top'}">
							<apollo:headline headline="${content.value.Title}"  setting="${cms.element.setting}" />
					</c:if>
					</div>
			
					<%-- ####### INTRODUCTION ######## --%>
					<c:if test="${value.Introduction.isSet}">
						<div class="col-xs-12">
							<div class="mb-20">
								<apollo:paragraph paragraph="${value.Introduction}" imgalign="top"/>
							</div>
						</div>
					</c:if>
				
				
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
								<apollo:paragraph paragraph="${text}" />
							</div>
						<c:if test="${status.index % 2 == 1 or status.last}">
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="text" items="${content.valueList.Text}" varStatus="status">
						<apollo:paragraph paragraph="${text}" />
					</c:forEach>
				</c:otherwise>
				</c:choose>
				
				
				<%-- ####### BOTTOM PARAGRAPH ######## --%>
				<c:if test="${value.BottomText.isSet}">
					<div class="row">
						<div class="col-xs-12">
							<apollo:paragraph paragraph="${value.BottomText}"/>
						</div>
					</div>
				</c:if>
				
				<%-- ####### LINK BUTTON ######## --%>
				<c:if test="${value.Link.isSet}">
					<c:set var="btnStyle" value="${cms.element.settings.btnstyle}" />
					<div class="row">
						<div class="${btnStyle == 'center' ? 'text-center' : ''} col-xs-12">
                            <apollo:link link="${value.Link}" linkclass="btn ap-btn-${cms.element.settings.buttoncolor} ${btnStyle == 'full' ? 'center-block' : ''}" />
						</div>
					</div>
				</c:if>
				
			</div>         
		</apollo:init-messages>		
	</div>

</cms:bundle>
</cms:formatter>