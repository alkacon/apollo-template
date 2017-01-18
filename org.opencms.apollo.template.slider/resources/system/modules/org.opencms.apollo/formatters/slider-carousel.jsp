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

<%-- Id must not have any "-" character --%>
<c:set var="id" value="carousel_${fn:replace(content.file.structureId, '-', '')}"/>

<div class="ap-carousel">

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline"><h2 ${content.rdfa.Title}>${value.Title}</h2></div>
    </c:if>

    <c:set var="bg" value="black" />
    <c:if test="${value.TextBackgroundColor.isSet}">
        <c:set var="bg" value="${value.TextBackgroundColor}" />
    </c:if>
    <c:set var="txt">${value.TextColor}</c:set>

    <div
        id="${id}"
        class="carousel slide"
        data-ride="carousel"
        data-interval="${value.Delay}">

        <div class="carousel-inner" role="listbox">
            <c:forEach var="image" items="${content.valueList.Image}" varStatus="status">
                <div class="item<c:if test="${status.first}"> active</c:if>">
                    <c:if test="${image.value.Link.isSet}">
                        <c:set var="newWin">${(image.value.NewWin.isSet and image.value.NewWin eq 'true')?'target="_blank"':''}</c:set>
                        <c:out value='<a href="<cms:link>${image.value.Link}</cms:link>" ${newWin}>' escapeXml='false' />
                    </c:if>
                    <apollo:image-simple image="${image}" title="${image.value.SuperTitle.stringValue}" />
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
                        <c:out value='</a>' escapeXml='false' />
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="carousel-arrow">
            <a data-slide="prev" href="#${id}" class="left carousel-control">
                <i class="fa fa-angle-left"></i>
            </a>
            <a data-slide="next" href="#${id}" class="right carousel-control">
                <i class="fa fa-angle-right"></i>
            </a>
        </div>
    </div>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
