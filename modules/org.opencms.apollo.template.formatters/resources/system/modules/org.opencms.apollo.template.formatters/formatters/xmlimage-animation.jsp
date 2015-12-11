<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
	<cms:formatter var="content" val="value" rdfa="rdfa">
		<%@include
			file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/image/xpath.jsp:6d9929b8-9f5c-11e5-b3e7-0242ac11002b)"%>
		<c:choose>
			<c:when test="${not value[xpath_image].isSet}">
				<div class="alert">
					<fmt:message key="no.image" />
				</div>
			</c:when>
			<c:otherwise>
				<div>
					<%@include
						file="%(link.strong:/system/modules/org.opencms.apollo.template.formatters/elements/image/variables.jsp:e5da6ee0-a000-11e5-b3e7-0242ac11002b)"%>

					<div class="thumbnails thumbnail-style thumbnail-kenburn"
						${value_start.Image.rdfa.Image}>

						<c:set var="showTextBelow" value="false" />
						<c:if
							test="${(value.Headline.isSet and cms.element.setting.showheadline.value == 'bottom') 
            or (cms.element.setting.showtext.value == 'true') 
            or (value.Link.isSet and cms.element.setting.showlink.value == 'button')}">
							<c:set var="showTextBelow" value="true" />
						</c:if>
						<c:if
							test="${value.Headline.isSet and cms.element.setting.showheadline.value == 'top'}">
							<div class="caption">
								<c:choose>
									<c:when
										test="${value.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
										<div class="headline">
											<h2>
												<a class="hover-effect"
													href="<cms:link>${value.Link}</cms:link>" ${rdfa.headline}>${value.Headline}</a>
											</h2>
										</div>
									</c:when>
									<c:otherwise>
										<div class="headline">
											<h2 ${rdfa.Headline}>${value.Headline}</h2>
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
							${value_start.Image.rdfa.Image} ${content.imageDnd[xpath_image]}>
							<div class="overflow-hidden">
								<img src="<cms:link>${value_start.Image.value.Image}</cms:link>"
									class="img-responsive ${cms.element.setting.cssShape}"
									alt="${title} ${copyright}"
									title="<c:out value='${title}  ${copyright}' escapeXml='false' />" />
							</div>
							<c:if
								test="${value.Link.isSet and cms.element.setting.showlink.value == 'image'}">
								<a class="btn-more hover-effect"
									href="<cms:link>${value.Link}</cms:link>"><fmt:message
										key="apollo.image.frontend.readmore" /></a>
							</c:if>
						</div>

						<c:if test="${showTextBelow}">
							<div class="caption">
								<c:if
									test="${value.Headline.isSet and fn:startsWith(cms.element.setting.showheadline.value,'bottom')}">
									<c:choose>
										<c:when
											test="${value.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
											<h2>
												<a class="hover-effect"
													href="<cms:link>${value.Link}</cms:link>" ${rdfa.Headline}>${value.Headline}</a>
											</h2>
										</c:when>
										<c:when
											test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
											<div class="fa-center">
												<div class="margin-bottom-20"></div>
												<p>
													<strong ${rdfa.Headline}>${value.Headline}</strong>
												</p>
											</div>
										</c:when>
										<c:otherwise>
											<h2 ${rdfa.Headline}>${value.Headline}</h2>
										</c:otherwise>
									</c:choose>
								</c:if>
								<c:if
									test="${value_start.Image.value.Description.isSet and cms.element.setting.showtext.value == 'true'}">
									<p ${value_start.Image.rdfa.Description}>${value_start.Image.value.Description}</p>
								</c:if>
								<c:if
									test="${value.Link.isSet and cms.element.setting.showlink.value == 'button'}">
									<div style="text-align: right; margin-top: 20px;">
										<a class="btn-more hover-effect" style="position: relative;"
											href="<cms:link>${value.Link}</cms:link>"><fmt:message
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