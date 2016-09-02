<%@page buffer="none" session="false"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<cms:formatter var="content" val="value">
	<div>
		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert alert-danger">Please edit the slider.</div>
			</c:when>
			<c:when test="${cms.edited}">
				<div>${cms.enableReload}</div>
				<div class="alert alert-danger">The slider was changed, the page is reloaded.</div>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${value.Position.exists}">
						<fmt:parseNumber var="posX" integerOnly="true" type="number" value="${value.Position.value.Left}" />
						<fmt:parseNumber var="posY" integerOnly="true" type="number" value="${value.Position.value.Top}" />
					</c:when>
					<c:otherwise>
						<c:set var="posX">10</c:set>
						<c:set var="posY">55</c:set>
					</c:otherwise>
				</c:choose>
				<div class="fullwidthbanner-container mb-20" style="overflow: hidden;">
					<div class="slider fullwidthbanner">
						<ul>
							<c:forEach var="image" items="${content.valueList.Image}" varStatus="status">
								<apollo:image-vars image="${image}" escapecopyright="false">
                                    <c:set var="x">${posX}</c:set>
                                    <c:set var="y">${posY}</c:set>
                                    <c:if test="${image.value.Position.exists}">
                                        <c:set var="pos" value="${image.value.Position}" />
                                        <fmt:parseNumber var="x" integerOnly="true" type="number" value="${pos.value.Left}" />
                                        <fmt:parseNumber var="y" integerOnly="true" type="number" value="${pos.value.Top}" />
                                    </c:if>
                                    <c:set var="bg" value="transparent" />
                                    <c:if test="${value.TextBackgroundColor.isSet}">
                                        <c:set var="bg" value="${value.TextBackgroundColor}" />
                                    </c:if>
                                    <li style="display: none;" data-masterspeed=" ${value.Delay}"
                                        data-transition="fade" data-slotamount="12" <c:if test="${image.value.Link.isSet}">data-link="<cms:link>${image.value.Link}</cms:link>" ${(image.value.NewWin.isSet and image.value.NewWin eq 'true')?' data-target="_blank"':''}</c:if>>
                                        <img src="<cms:link>${image.value.Uri}</cms:link>" alt="${image.value.Tooltip}" />
                                        <c:if test="${image.value.SuperTitle.isSet || image.value.TitleLine1.isSet || image.value.TitleLine2.isSet}">
                                            <div class="hidden-xs caption fade" data-x="${x}"
                                                data-y="${y}" data-easing="easeOutBack"
                                                style="background-color: ${bg}; color: ${value.TextColor};">
                                                <c:if test="${image.value.SuperTitle.isSet}">
                                                    <h2 style="color: ${value.TextColor};">${image.value.SuperTitle}</h2>
                                                </c:if>
                                                <c:if test="${image.value.TitleLine1.isSet}">
                                                    <h3 style="color: ${value.TextColor};">${image.value.TitleLine1}</h3>
                                                </c:if>
                                                <c:if test="${image.value.TitleLine2.isSet}">
                                                    <h3 style="color: ${value.TextColor};">${image.value.TitleLine2}</h3>
                                                </c:if>
                                            </div>
                                        </c:if>

                                        <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">
                                            <fmt:parseNumber var="y" integerOnly="true" type="number" value="${value.ImageHeight}" />
                                            <div class="caption copyright" data-x="0" data-y="${y-30}">${imageCopyright}</div>
                                        </c:if>
                                    </li>
                                </apollo:image-vars>
							</c:forEach>
						</ul>
						<c:if test="${value.ShowPlayButton eq 'true'}">
							<section class="control">
								<button id="stopButton" class="u-btn">
									<i class="fa fa-pause"></i>
								</button>
								<button id="resumeButton" class="u-btn" style="display: none">
									<i class="fa fa-play"></i>
								</button>
							</section>
						</c:if>
						<div class="tp-bannertimer tp-top" ${value.ShowTimer ne 'true'?'style="display: none;"':''}></div>

					</div>

				</div>
				<fmt:parseNumber var="height" integerOnly="true" type="number" value="${value.ImageHeight}" />
				<script type="text/javascript">
					function createBanner() {
						$('.fullwidthbanner').revolution({
							delay : ${value.Delay},
							startheight : ${value.ImageHeight},
							navigationType : ${value.ShowNumbers eq 'true'?'"bullet"':'"none"'},
							navigationArrows : ${value.ShowNavButtons eq 'true'?'"solo"':'"none"'}, 
							navigationStyle : "round", // round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom
							navigationHAlign : "right", // Vertical Align top,center,bottom
							navigationVAlign : "bottom", // Horizontal Align left,center,right
							navigationHOffset : 20,
							navigationVOffset : 20,
							soloArrowLeftHalign : "left",
							soloArrowLeftValign : "center",
							soloArrowLeftHOffset : 20,
							soloArrowLeftVOffset : 0,
							soloArrowRightHalign : "right",
							soloArrowRightValign : "center",
							soloArrowRightHOffset : 20,
							soloArrowRightVOffset : 0,
							touchenabled : "on", // Enable Swipe Function : on/off
							onHoverStop : "off", // Stop Banner Timet at Hover on Slide on/off
							stopAtSlide : -1,
							stopAfterLoops : -1,
							fullWidth : "off" // Turns On or Off the Fullwidth Image Centering in FullWidth Modus
						});
						$('#stopButton').on('click', function(e) {
							$('.slider').revpause();
							$('.control button').toggle();
							$(this).hide();
							$('#resumeButton').show();
						});

						// When resume button is clicked...
						$('#resumeButton').on('click', function(e) {
							$('.slider').revresume();
							$(this).hide();
							$('#stopButton').show();
						});
						$('.slider').find('li').show();

					}
				</script>
			</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>