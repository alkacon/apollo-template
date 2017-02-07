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
<cms:bundle basename="org.opencms.apollo.template.section.messages">

<div class="ap-section image-zoom ${cms.element.settings.wrapperclass}">

    <c:set var="showsubtitle" value="${cms.element.setting.showsubtitle.value != 'false' and (value.Headline.isSet or not empty imageTitle)}"/>
    <c:set var="showtext" value="${cms.element.setting.showtext.value and value.Text.isSet}"/>

    <apollo:image-zoom
        image="${content.value.Image}"
        cssimage="${cms.element.setting.ieffect.value != 'none' ? cms.element.setting.ieffect.value : ''}"
        title="${not empty imageTitle ? imageTitle : value.Headline}"
    />

    <c:if test="${cms.element.setting.showcopyright.value and not empty imageCopyright}">
        <div class="copyright">
            <div class="text">${imageCopyright}</div>
        </div>
    </c:if>

    <c:if test="${showsubtitle or showtext}">
        <div class="image-info text-box">

            <c:if test="${showsubtitle}">
                <h3 class="subtitle ${cms.element.setting.showsubtitle}">
                    <apollo:link link="${value.Link}">
                        ${not empty imageTitle ? imageTitle : value.Headline}
                    </apollo:link>
                </h3>
            </c:if>

            <c:if test="${showtext}">
                <div class="text">
                    ${value.Text}
                </div>
            </c:if>
        </div>
    </c:if>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
