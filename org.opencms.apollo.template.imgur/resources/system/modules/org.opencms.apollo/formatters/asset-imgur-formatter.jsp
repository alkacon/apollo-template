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
<cms:bundle basename="org.opencms.apollo.template.imgur.messages">

<div class="ap-section ap-image-section ${cms.element.setting.cssclass.value}">

    <c:set var="showlink" value="${cms.element.setting.showlink.value}"/>
    <c:set var="showsubitle" value="${(cms.element.setting.showsubtitle.value != 'false') and (value.Headline.isSet or not empty imageTitle)}"/>
    <c:set var="showtext" value="${cms.element.setting.showtext.value}"/>

    <c:set var="usetitle" value="${cms.element.settings.usetitle}" />

    <apollo:image-animated-imgur
        image="${value.Item}"
        cssclass="
            ${showlink ? 'ap-button-animation ' : ''}
            ${cms.element.setting.ieffect.value != 'none' ? cms.element.setting.ieffect.value : ''}"
    >

        <c:if test="${showlink}">
            <div class="button-box">
                <a href="${value.Item.value.Data}" class="btn btn-xs" target="imgur">
                    <fmt:message key="apollo.imgursection.message.link" />
                </a>
            </div>
        </c:if>

        <div class="copyright">
            <div class="text">Courtesy of Imgur</div>
        </div>

        <c:if test="${showsubitle or showtext}">
            <div class="image-info text-box">

                <c:if test="${showsubitle}">
                    <c:choose>
                        <c:when test="${not usetitle}">
                            <h3 class="subtitle">
                                ${value.Title}
                            </h3>
                        </c:when>
                        <c:otherwise>
                            <h3 class="subtitle">
                                ${value.Item.value.Title}
                            </h3>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <c:if test="${showtext}">
                    <c:choose>
                        <c:when test="${value.Text.isSet}">
                            <div class="text" ${value.Text.rdfaAttr}>
                                ${value.Text}
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text">
                                ${value.Item.value.Description}
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </c:if>

    </apollo:image-animated-imgur>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>