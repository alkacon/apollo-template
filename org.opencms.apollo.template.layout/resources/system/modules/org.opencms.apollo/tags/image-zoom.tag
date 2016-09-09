<%@ tag 
    display-name="image-zoom"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Shows an image which enlarges on click." %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${image.isSet}">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">

<%-- ####### ImageDnD workaround ##################################### --%>
<%-- ####### image.value.Image.imageDndAttr doesn't work here ######## --%>
<%-- ################################################################# --%>

<c:if test="${not empty image && image.isSet}">
	<c:set var="conValue" value="${image.value.Image.contentValue}" />
	<c:set var="dndData" value="${conValue.document.file.structureId}|${conValue.path}|${conValue.locale}" />
	<c:set var="imageDnd">data-imagednd="${dndData}"</c:set>
</c:if>

<%-- ################################################################# --%>

<div class="ap-img ${cms.element.settings.istyle}">

	<div class="ap-img-pic">
		
		<%-- ####### If scaled image is used, store path to original for usage ######## --%>
		<a 	data-gallery="true"
			class="zoom"
			data-size="${cms.vfs.property[imageUnscaledLink]['image.size']}"
			href="<cms:link>${imageUnscaledLink}</cms:link>"
			<c:if test="${not empty imageTitleCopyright}">title="${imageTitleCopyright}" data-title="${imageTitleCopyright}"</c:if>
			data-rel="fancybox-button-${cms.element.instanceId}"
			id="fancyboxzoom${cms.element.instanceId}">
			
			<span class="zoom-overlay">
                    <span ${imageDnd}>
                        <img
                            src="<cms:link>${imageLink}</cms:link>"
                            class="img-responsive ${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}"
                            <c:if test="${not empty imageTitleCopyright}">
                                alt="${imageTitleCopyright}"
                                title="${imageTitleCopyright}"
                            </c:if>
                        />
                    </span>
					<%-- ####### zoom icon cancels out shadow and border, only rounded corners remain ######## --%>
                    <span class="zoom-icon ${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}" style="box-shadow: none; border: 0;">
                        <i class="fa fa-search"></i>
                    </span>
                </span>
			
		</a>
		
	</div>
		
	<%-- ####### Show copyright if enabled ######## --%>
	<c:if test="${fn:contains(cms.element.settings.itext, 'copy') && image.value.Copyright.isSet}">
		<div class="info">
			<p class="copyright"><i>${imageCopyright}</i></p>
		</div>
	</c:if>
	
	<c:if test="${cms.element.settings.itext != 'none'}">
			<div class="ap-img-txt">
			<c:if test="${fn:contains(cms.element.settings.itext, 'title')}">
					<c:choose>
							<c:when	test="${image.value.Title.isSet}">
									<div class="ap-img-title"><span ${image.value.Title.rdfaAttr}>${image.value.Title}</span></div>
							</c:when>
							<c:when	test="${headline.isSet}">
									<div class="ap-img-title"><span ${headline.rdfaAttr}>${headline}</span></div>
							</c:when>
					</c:choose>
			</c:if>
			<c:if test="${fn:contains(cms.element.settings.itext, 'desc') && image.value.Description.isSet}">
					<div class="ap-img-desc"><span ${image.value.Description.rdfaAttr}>${image.value.Description}</span></div>
			</c:if>
			</div>
	</c:if>
	
</div>

</c:if>

</apollo:image-vars>
</cms:bundle>

</c:if>
