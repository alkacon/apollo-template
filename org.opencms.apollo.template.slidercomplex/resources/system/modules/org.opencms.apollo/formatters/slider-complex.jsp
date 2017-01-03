<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages reload="true">

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.slider.messages">

<div class="ap-complex-slider ${cms.element.setting.wrapperclass}" 
        data-sid="${content.file.structureId}" 
        data-delay="${value.Duration}"
        data-height="${value.Height}"
        data-width="${value.Width}"
        data-init="false" >

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline"><h2 ${content.rdfa.Title}>${value.Title}</h2></div>
    </c:if>

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
                                <div class="caption copyright" data-x="left" data-y="bottom">${imageCopyright}</div>
                            </c:if>
                        </apollo:image-vars>
 
                    </li>
                </c:forEach>
            </ul>
            <div class="tp-bannertimer tp-bottom"></div>
        </div>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>