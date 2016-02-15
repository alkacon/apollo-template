<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<c:set var="showelements">${cms.element.settings.showelements}</c:set>

<div class="${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : "" }${' ' }${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "mb-20" }">

    <c:if test="${cms.element.setting.anchor.isSet}">
        <a id="${cms.element.setting.anchor}" class="anchor"></a>
    </c:if>
    
    <%-- Possible variations: all, textheadline, textimage, headline, text, image  --%>
	<c:if test="${(showelements == 'all' or fn:contains(showelements, 'headline')) and value.Headline.isSet}">
		<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
	</c:if>
    
    <c:set var="imgalign">noimage</c:set>
	<c:if test="${(showelements == 'all' or fn:contains(showelements, 'image')) and value.Image.exists}">
		<c:set var="imgalign">
			<cms:elementsetting name="imgalign" default="left" />
		</c:set>
        <c:set var="copyright">${value.Image.value.Copyright}</c:set>
		<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)" %>
	</c:if>
    
    <c:choose>
		<c:when test="${imgalign == 'left' or imgalign == 'right'}">
			<c:choose>
                <c:when test="${showelements == 'all' or showelements == 'textimage'}">
                    <div class="row">
        				<div class="col-md-4 pull-${imgalign}">
        					<div ${rdfa.Image} class="<%-- thumbnail-kenburn --%>">
        						<div class="overflow-hidden" ${content.imageDnd['Image/Image']}>
        							<cms:img src="${value.Image.value.Image}"
        								scaleColor="transparent" width="400" scaleType="0"
        								cssclass="img-responsive"
        								alt="${value.Image.value.Title}${' '}${copyright}"
        								title="${value.Image.value.Title}${' '}${copyright}" />
                                    <c:if test="${value.Image.value.Description.isSet}">
                                        <div class="caption" ${value.Image.rdfa.Description}>${value.Image.value.Description}</div>                                    
                                    </c:if>
        						</div>
        					</div>
        				</div>
        				<div class="col-md-8" <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
                            <div ${rdfa.Text}>${value.Text}</div>
        					<c:if test="${value.Link.exists}">
                				<p ${rdfa.Link}><a class="btn btn-u u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
                			</c:if>
        				</div>
        			</div>
                </c:when>
                <c:when test="${showelements == 'image'}">
                    <img
						src="<cms:link>${value.Image.value.Image}</cms:link>"
						class="img-responsive"
						${content.imageDnd['Image/Image']} alt="${value.Title} ${copyright}"
						title="<c:out value='${value.Title}' escapeXml='false' /> ${copyright}" />
                    <c:if test="${value.Image.value.Description.isSet}">
                        <div class="caption" ${value.Image.rdfa.Description}>${value.Image.value.Description}</div>                                    
                    </c:if>
                </c:when>
            </c:choose>
		</c:when>
        <c:when test="${imgalign == 'noimage'}">
			<div <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
        		<c:if test="${showelements == 'all' or fn:contains(showelements, 'text')}">
        			<div ${rdfa.Text}>${value.Text}</div>		
        			<c:if test="${value.Link.exists}">
        				<p ${rdfa.Link}><a class="btn btn-u u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
        			</c:if>
        		</c:if>
        	</div>
		</c:when>
	</c:choose>

	
</div>

</cms:formatter>





                            
                            
                            
                            
    