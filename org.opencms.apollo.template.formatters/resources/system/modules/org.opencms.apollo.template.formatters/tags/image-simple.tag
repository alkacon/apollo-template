<%@ tag 
    display-name="image-simple"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formates a simple image from te given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="content" type="org.opencms.jsp.util.CmsJspContentAccessBean" required="true" %>

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

<c:if test="${link.isSet && setting.ilink.value != 'none'}">
	<a class="ap-img-link" href="<cms:link>${link.value.URI}</cms:link>"
			<c:if test="${link.value.Text.isSet}">
			title="${link.value.Text}"
			</c:if>
	>
</c:if>
		
	<div class="ap-img ${setting.istyle}">


			<div class="ap-img-pic">
					<span ${image.rdfa.Image} ${content.imageDnd[image.value.Image.path]}>
							<img
									src="<cms:link>${imageLink}</cms:link>"
									class="img-responsive ${setting.ieffect != 'none' ? setting.ieffect : ''}"
									alt="${imageTitle}${' '}${imageCopyright}"
									title="${imageTitle}${' '}${imageCopyright}"
							/>
					</span>
			</div>
	</div>
	
	<c:if test="${setting.itext.value != 'none'}">
		<div class="ap-img-txt">
		<c:if test="${fn:contains(setting.itext.value, 'title')}">
				<c:choose>
						<c:when	test="${image.value.Title.isSet}">
								<div class="ap-img-title"><span ${image.rdfa.Title}>${image.value.Title}</span></div>
						</c:when>
						<c:when	test="${headline.isSet}">
								<div class="ap-img-title"><span ${headline.rdfaAttr}>${headline}</span></div>
						</c:when>
				</c:choose>
		</c:if>
		<c:if test="${fn:contains(setting.itext.value, 'desc') && image.value.Description.isSet}">
				<div class="ap-img-desc"><span ${image.rdfa.Description}>${image.value.Description}</span></div>
		</c:if>
		</div>
	</c:if>

<c:if test="${link.isSet && setting.ilink.value != 'none'}">
	</a>
</c:if>

</c:if>

</apollo:image-vars>
</cms:bundle>

</c:if>
