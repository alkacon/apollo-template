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

<div class="ap-slider" 
    data-sid="${content.file.structureId}" 
    data-delay="${value.Delay}"
    data-height="${value.ImageHeight}"
    data-navtype="${value.ShowNumbers eq 'true' ? 'bullet' : 'none'}"
    data-navbutton="${value.ShowNavButtons eq 'true' ? 'solo' : 'none'}"
    data-init="false" >

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline"><h2 ${content.rdfa.Title}>${value.Title}</h2></div>
    </c:if>

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
        <div class="slider fullwidthbanner" id="ap-slider-${content.file.structureId}">
            <ul>
                <c:forEach var="image" items="${content.valueList.Image}" varStatus="status">
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
                    <li style="display: none;" 
                        data-masterspeed=" ${value.Delay}"
                        data-transition="fade" 
                        data-slotamount="12" 
                        <c:if test="${image.value.Link.isSet}">data-link="<cms:link>${image.value.Link}</cms:link>" ${(image.value.NewWin.isSet and image.value.NewWin eq 'true')?' data-target="_blank"':''}</c:if>>
                        <apollo:image-simple image="${image}" title="${image.value.SuperTitle.stringValue}" />
                        <c:if test="${image.value.SuperTitle.isSet || image.value.TitleLine1.isSet || image.value.TitleLine2.isSet}">
                            <div class="hidden-xs caption fade" 
                                data-x="${x}"
                                data-y="${y}" 
                                data-easing="easeOut"
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
                        <apollo:image-vars image="${image}" escapecopyright="false">
                            <c:if test="${cms.element.settings.showCopy and not empty imageCopyright}">
                                <div class="caption copyright" data-x="left" data-y="bottom">${imageCopyright}</div>
                            </c:if>
                        </apollo:image-vars>
                    </li>

                </c:forEach>
            </ul>
            <c:if test="${value.ShowPlayButton eq 'true'}">
                <section class="control">
                    <button id="stopButton-${content.file.structureId}" class="u-btn">
                        <i class="fa fa-pause"></i>
                    </button>
                    <button id="resumeButton-${content.file.structureId}" class="u-btn" style="display: none">
                        <i class="fa fa-play"></i>
                    </button>
                </section>
            </c:if>
            <div class="tp-bannertimer tp-top" ${value.ShowTimer ne 'true'?'style="display: none;"':''}></div>

        </div>

    </div>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>