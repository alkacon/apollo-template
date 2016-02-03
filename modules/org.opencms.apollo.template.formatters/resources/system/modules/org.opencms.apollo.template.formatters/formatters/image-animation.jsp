<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<%@include file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/imagevariables.jsp:6d9929b8-9f5c-11e5-b3e7-0242ac11002b)"%>
		<c:choose>
			<c:when test="${not imgValParent.Image.isSet or not imgValParent.Image.value.Image.isSet}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<div class="thumbnails thumbnail-style thumbnail-kenburn"
						${imgValParent.Image.rdfa.Image}>

						<c:set var="showTextBelow" value="false" />
						<c:if
							test="${(imgValParent.Headline.isSet and cms.element.setting.showheadline.value == 'bottom') 
            or (cms.element.setting.showtext.value == 'true') 
            or (imgValParent.Link.isSet and cms.element.setting.showlink.value == 'button')}">
							<c:set var="showTextBelow" value="true" />
						</c:if>
						<c:if
							test="${imgValParent.Headline.isSet and cms.element.setting.showheadline.value == 'top'}">
							<div class="caption">
								<c:choose>
									<c:when
										test="${imgValParent.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
										<div class="headline">
											<h2>
												<a class="hover-effect"
													href="<cms:link>${imgValParent.Link.value.URI}</cms:link>" ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</a>
											</h2>
										</div>
									</c:when>
									<c:otherwise>
										<div class="headline">
											<h2 ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</h2>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>

						<c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : ''}</c:set>
						<c:if test="${cms.element.setting.cssClass.isSet}">
							<c:set var="cssClass"
								value="${cms.element.setting.cssClass.value}" />
						</c:if>
						<div class="${cssClass} ${showTextBelow ? thumbnail-img: ''}"
							${imgValParent.Image.rdfa.Image} ${content.imageDnd[imgValParent.Image.value.Image.path]}>
							<div class="overflow-hidden">
								<img src="<cms:link>${imgValParent.Image.value.Image}</cms:link>"
									class="img-responsive ${cms.element.setting.cssShape}"
									alt="${imgTitle}${' '}${imgCopyright}"
									title="${imgTitle}${' '}${imgCopyright}" />
							</div>
							<c:if test="${imgValParent.Link.isSet and cms.element.setting.showlink.value == 'image'}">
								<a class="btn-more hover-effect"
									href="<cms:link>${imgValParent.Link}</cms:link>"><fmt:message
										key="apollo.image.frontend.readmore" /></a>
							</c:if>
						</div>

						<c:if test="${showTextBelow}">
							<div class="caption">
								<c:if
									test="${imgValParent.Headline.isSet and fn:startsWith(cms.element.setting.showheadline.value,'bottom')}">
									<c:choose>
										<c:when
											test="${imgValParent.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
											<h2>
												<a class="hover-effect"
													href="<cms:link>${imgValParent.Link.value.URI}</cms:link>" ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</a>
											</h2>
										</c:when>
										<c:when
											test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
											<div class="fa-center">
												<div class="margin-bottom-20"></div>
												<p>
													<strong ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</strong>
												</p>
											</div>
										</c:when>
										<c:otherwise>
											<h2 ${imgValParent.Headline.rdfaAttr}>${imgValParent.Headline}</h2>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:choose>
                                  <c:when
  									test="${imgValParent.Image.value.Description.isSet and cms.element.setting.showtext.value == 'true'}">
  									<p ${imgValParent.Image.rdfa.Description}>${imgValParent.Image.value.Description}</p>
  								</c:when>
                                  <c:when
          							test="${imgValParent.Text.isSet and cms.element.setting.showtext.value == 'true'}">
          							<p ${imgValParent.Text.rdfa}>${imgValParent.Text}</p>
          						</c:when>
                                </c:choose>
								<c:if
									test="${imgValParent.Link.isSet and cms.element.setting.showlink.value == 'button'}">
									<div style="text-align: right; margin-top: 20px;">
										<a class="btn-more hover-effect" style="position: relative;"
											href="<cms:link>${imgValParent.Link.value.URI}</cms:link>"><fmt:message
												key="apollo.image.frontend.readmore" /></a>
									</div>
								</c:if>
							</div>
						</c:if>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</cms:formatter>
</cms:bundle>