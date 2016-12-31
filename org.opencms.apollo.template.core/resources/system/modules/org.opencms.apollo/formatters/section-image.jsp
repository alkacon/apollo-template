<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<apollo:init-messages>

<cms:formatter var="content" val="value">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.schemas.section">

<div class="ap-image-section">

    <c:set var="showlinkimage" value="${cms.element.setting.showlink.value == 'image' and value.Link.isSet and value.Link.value.URI.isSet}"/>
    <c:set var="showlinktext" value="${cms.element.setting.showlink.value and value.Link.isSet and value.Link.value.URI.isSet}"/>
    <c:set var="showsubitle" value="${(cms.element.setting.showsubtitle.value != 'false') and (value.Headline.isSet or not empty imageTitle)}"/>
    <c:set var="showtext" value="${cms.element.setting.showtext.value and value.Text.isSet}"/>

    <apollo:link link="${value.Link}" test="${showlinkimage}">
        <apollo:image-animated
            image="${value.Image}"
            cssclass="
                ${showlinktext ? 'ap-button-animation ' : ''}
                ${cms.element.setting.ieffect.value != 'none' ? cms.element.setting.ieffect.value : ''}"
            addcssclass="${cms.element.setting.addcssclass.value != 'none' ? cms.element.setting.addcssclass.value : ''}"
        >
            <c:if test="${showlinktext}">
                <div class="button-box">
                    <apollo:link 
                        link="${value.Link}" 
                        cssclass="btn btn-xs" />
                </div>
            </c:if>

            <c:if test="${cms.element.setting.showcopyright.value and not empty imageCopyright}">
                <div class="copyright">
                    <div class="text">${imageCopyright}</div>
                </div>
            </c:if>

            <c:if test="${showsubitle or showtext}">
                <div class="image-info text-box">

                    <c:if test="${showsubitle}">
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

        </apollo:image-animated>
    </apollo:link>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>