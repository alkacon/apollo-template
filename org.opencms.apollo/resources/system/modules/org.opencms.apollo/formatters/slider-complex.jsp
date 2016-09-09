<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.slider">

<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
	<c:if test="${not cms.element.settings.hidetitle}">
		<c:if test="${empty cms.element.parent}"><div class="row"></c:if><div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div><c:if test="${empty cms.element.parent}"></div></c:if>
	</c:if>

<c:set var="textnew"><fmt:message key="apollo.slider.message.new" /></c:set>
<c:set var="textedit"><fmt:message key="apollo.slider.message.edited" /></c:set>
<apollo:init-messages textnew="${textnew}" textedit="${textedit}">

<div class="fullwidthbanner-container" style="overflow: hidden;"><!--=== Slider ===-->

	<div class="slider fullwidthbanner" id="ap-slider-${content.file.structureId}">
		<ul>
			<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
				<li style="display: none;" data-transition="${item.value.Effect}" data-slotamount="${item.value.Slots}" data-masterspeed="${item.value.Delay}"<c:if test="${item.value.Link.isSet}"> data-link="<cms:link>${item.value.Link}</cms:link>"</c:if>>

					<!-- Main image of slide ${status.count} -->
					<img  src="<cms:link>${item.value.Image}</cms:link>" alt="" />

					<c:forEach var="caption" items="${item.valueList.Caption}" varStatus="statusCaption">
						<div class="${caption.value.Class}" data-x="${caption.value.PosX}" data-y="${caption.value.PosY}" data-start="${caption.value.Start}" data-speed="${caption.value.Speed}" data-easing="${caption.value.Easing}"<c:if test="${caption.value.End.isSet}"> data-end="${caption.value.End}"</c:if><c:if test="${caption.value.EndEasing.isSet}"> data-endeasing="${caption.value.EndEasing}"</c:if><c:if test="${caption.value.End.isSet or caption.value.EndEasing.isSet}"> data-endspeed="${caption.value.Speed}"</c:if>>
							<c:if test="${caption.value.Image.isSet}"><img src="<cms:link>${caption.value.Image}</cms:link>" alt="" /></c:if>
							<c:if test="${caption.value.Text.isSet}">${caption.value.Text}</c:if>
						</div>
					</c:forEach>

                    <apollo:image-vars image="${item}" escapecopyright="false">
                        <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">
                            <fmt:parseNumber var="y" integerOnly="true" type="number" value="${value.Height}" />
                            <div class="caption copyright" data-x="0" data-y="${y-22}">${imageCopyright}</div>
                        </c:if>
                    </apollo:image-vars>

				</li>
			</c:forEach>
		</ul>
	<div class="tp-bannertimer tp-bottom"></div>
	</div>

	<script type="text/javascript">
		function createBanner() {
			$('#ap-slider-${content.file.structureId}').revolution(
	                {
	                    delay:${value.Duration},
	                    startheight:${value.Height},
	                    startwidth:${value.Width},

	                    hideThumbs:10,

	                    thumbWidth:100,                         <%-- Thumb With and Height and Amount (only if navigation Tyope set to thumb !) --%>
	                    thumbHeight:50,
	                    thumbAmount:5,

	                    navigationType:"bullet",                <%-- bullet, thumb, none --%>
	                    navigationArrows:"solo",                <%-- nexttobullets, solo (old name verticalcentered), none --%>

	                    navigationStyle:"round",                <%-- round,square,navbar,round-old,square-old,navbar-old, or any from the list in the docu (choose between 50+ different item), custom --%>

	                    navigationHAlign:"center",              <%-- Vertical Align top,center,bottom --%>
	                    navigationVAlign:"bottom",              <%-- Horizontal Align left,center,right --%>
	                    navigationHOffset:0,
	                    navigationVOffset:20,

	                    soloArrowLeftHalign:"left",
	                    soloArrowLeftValign:"center",
	                    soloArrowLeftHOffset:20,
	                    soloArrowLeftVOffset:0,

	                    soloArrowRightHalign:"right",
	                    soloArrowRightValign:"center",
	                    soloArrowRightHOffset:20,
	                    soloArrowRightVOffset:0,

	                    touchenabled:"on",                       <%-- Enable Swipe Function : on/off --%>
	                    onHoverStop:"off",                       <%-- Stop Banner Timet at Hover on Slide on/off --%>

	                    stopAtSlide:-1,
	                    stopAfterLoops:-1,

	                    shadow:1,                                <%-- 1 = no Shadow, 1,2,3 = 3 Different Types of Shadows  (No Shadow in Fullwidth Version !) --%>
	                    fullWidth:"on"                           <%-- Turns On or Off the Fullwidth Image Centering in FullWidth Modus --%>
	                });
			$('#ap-slider-${content.file.structureId}').find('li').show();

		}
	</script>

<!--=== End Slider ===--></div>

</apollo:init-messages>

</div>
</cms:formatter>
</cms:bundle>