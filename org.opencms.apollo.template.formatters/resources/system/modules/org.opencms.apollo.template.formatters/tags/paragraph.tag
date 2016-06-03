<%@ tag 
    display-name="paragraph"
    body-content="empty"
    trimDirectiveWhitespaces="true" 
    description="Formats a paragraph with optional elements from the given content" %>

<%@ attribute name="setting" type="java.util.Map" required="true" %>
<%@ attribute name="showimage" type="java.lang.String" required="false" %>
<%@ attribute name="imgalign" type="java.lang.String" required="false" %>
<%@ attribute name="paragraph" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<%-- ####### Preset optional attributes ######## --%>
<c:if test="${empty showimage}"><c:set var="showimage" value="true" /></c:if>
<c:if test="${empty imgalign}"><c:set var="imgalin" value="left" /></c:if>


<%-- ####### Render paragraph ######## --%>
<div class="paragraph margin-bottom-20">

	<%-- ####### Show headline if set ######## --%>
	<c:if test="${paragraph.value.Headline.isSet}">
		<div class="headline">
			<h4 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h4>
		</div>
	</c:if>

	<c:choose>
		<%-- ####### Show paragraph without image ######## --%>
		<c:when test="${!showimage}">
			<span ${paragraph.rdfa.Image}></span>
			<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
													
			<c:if test="${paragraph.value.Link.exists}">
				<p>
					<a class="btn ap-btn-sm"
						href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a>
				</p>
			</c:if>
		</c:when>

		<%-- ####### Show paragraph with aligned image ######## --%>
		<c:when test="${imgalign == 'left' or imgalign == 'right'}">

			<c:set var="copyright">${paragraph.value.Image.value.Copyright}</c:set>
			<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/copyright.jsp:fd92c207-89fe-11e5-a24e-0242ac11002b)" %>

			<div class="row">
				<div class="col-md-4 pull-${imgalign}">
				
				<apollo:image-kenburn 
					setting="${cms.element.setting}" 
					image="${paragraph.value.Image}"
					width="400"
					content="${content}" />

				</div>
				<div class="col-md-8">
					<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
					<c:if test="${paragraph.value.Link.exists}">
						<p>
							<a class="btn ap-btn-sm"
								href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a>
						</p>
					</c:if>
				</div>
			</div>
		</c:when>
	</c:choose>

</div>