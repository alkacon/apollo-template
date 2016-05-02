<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.slider">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">

	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="apollo.carousel.message.new" /></div>
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

			<div class="carousel slide carousel-v1" id="myCarousel-${content.file.structureId}">
				<div class="carousel-inner">
					<c:forEach var="image" items="${content.valueList.Image}" varStatus="status">
						<div class="item<c:if test="${status.first}"> active</c:if>">

							<c:set var="copyright" value="" />
                            <c:choose>
                               	<c:when test="${image.value.Copyright.isSet}">
                  					<c:set var="copyright" value="${image.value.Copyright.stringValue}" />
                  				</c:when>
                            	<c:otherwise>
                            		<c:set var="mainimguri">${image.value.Uri}</c:set> 
                            		<c:if test="${fn:contains(mainimguri, '?')}">
								    	<c:set var="mainimguri">${fn:substringBefore(mainimguri, '?')}</c:set>  
								    </c:if>
                                	<c:set var="copyright"><cms:property name="Copyright" file="${mainimguri}" default="" /></c:set>
                                </c:otherwise>
                            </c:choose>

              				<c:if test="${not empty copyright and not fn:startsWith(copyright, '(c)')}">
              					<c:set var="copyright">${fn:replace(copyright, "&copy;", "")}</c:set>
                            	<c:set var="copyright">(c) ${copyright}</c:set>
                            </c:if>

							<c:if test="${image.value.Link.isSet}">
								<a href="<cms:link>${image.value.Link}</cms:link>" ${(image.value.NewWin.isSet and image.value.NewWin eq 'true')?'target="_blank"':''}>
							</c:if>
							<cms:img alt="${copyright}" title="${copyright}" src="${image.value.Uri}" scaleType="2" scaleColor="transparent" scaleQuality="75" noDim="true" cssclass="img-responsive"/>
							<c:if test="${image.value.SuperTitle.isSet || image.value.TitleLine1.isSet || image.value.TitleLine2.isSet}">
								<div class="carousel-caption" style="background-color: ${bg}; opacity: 0.7; filter: alpha(opacity=70);">
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
							<c:if test="${image.value.Link.isSet}">
								</a>
							</c:if>
						</div>
					</c:forEach>
				</div>
				<div class="carousel-arrow">
					<a data-slide="prev" href="#myCarousel-${content.file.structureId}" class="left carousel-control">
						<i class="fa fa-angle-left"></i>
					</a>
					<a data-slide="next" href="#myCarousel-${content.file.structureId}" class="right carousel-control">
						<i class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>

			<script type="text/javascript">
				function createCarousel() {
					$(".carousel").carousel({
						interval: ${value.Delay}
					});	
				}
			</script>

		</c:otherwise>
	</c:choose>
</div>

</cms:formatter>
</cms:bundle>