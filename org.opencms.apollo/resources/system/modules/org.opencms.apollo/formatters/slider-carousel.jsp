<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.slider">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="ap-carousel mb-30">

	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert alert-danger"><fmt:message key="apollo.carousel.message.new" /></div>
		</c:when>
		<c:otherwise>

			<c:if test="${not cms.element.settings.hidetitle}">
				<div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
			</c:if>

			<c:set var="bg" value="black" />
			<c:if test="${value.TextBackgroundColor.isSet}">
				<c:set var="bg" value="${value.TextBackgroundColor}" />
			</c:if>
			<c:set var="txt">${value.TextColor}</c:set>

			<div class="carousel slide carousel-v1" id="ap-carousel-${content.file.structureId}">
				<div class="carousel-inner">
					<c:forEach var="image" items="${content.valueList.Image}" varStatus="status">
                        <div class="item<c:if test="${status.first}"> active</c:if>">
							<c:if test="${image.value.Link.isSet}">
								<a href="<cms:link>${image.value.Link}</cms:link>" ${(image.value.NewWin.isSet and image.value.NewWin eq 'true')?'target="_blank"':''}>
							</c:if>
                            <apollo:image-simple image="${image}" setting="${cms.element.setting}" onlyimage="true" title="${image.value.SuperTitle.stringValue}" />
                            <apollo:image-vars image="${image}" escapecopyright="false">
                                <c:if test="${image.value.SuperTitle.isSet || image.value.TitleLine1.isSet || image.value.TitleLine2.isSet}">
                                    <div class="carousel-caption <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">carousel-caption-copyright</c:if>" style="background-color: ${bg};">
                                        <c:if test="${image.value.SuperTitle.isSet}">
                                            <h3 style="color: ${txt};" ${image.rdfa.SuperTitle}>${image.value.SuperTitle}</h3>
                                        </c:if>
                                        <c:if test="${image.value.TitleLine1.isSet}">
                                            <p style="color: ${txt};" ${image.rdfa.TitleLine1}>${image.value.TitleLine1}</p>
                                        </c:if>
                                        <c:if test="${image.value.TitleLine2.isSet}">
                                            <p style="color: ${txt};" ${image.rdfa.TitleLine2}>${image.value.TitleLine2}</p>
                                        </c:if>
                                    </div>
                                </c:if>
                                <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">
                                    <div class="carousel-copyright" style="background-color: ${bg}; color: ${txt};">
                                        <span>${imageCopyright}</span>
                                    </div>
                                </c:if>
                             </apollo:image-vars>
							<c:if test="${image.value.Link.isSet}">
								</a>
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class="carousel-arrow">
					<a data-slide="prev" href="#ap-carousel-${content.file.structureId}" class="left carousel-control">
						<i class="fa fa-angle-left"></i>
					</a>
					<a data-slide="next" href="#ap-carousel-${content.file.structureId}" class="right carousel-control">
						<i class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>

			<script type="text/javascript">
				function createCarousel() {
					$("#ap-carousel-${content.file.structureId}").carousel({
						interval: ${value.Delay}
					});	
				}
			</script>

		</c:otherwise>
	</c:choose>
</div>

</cms:formatter>
</cms:bundle>