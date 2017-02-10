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

<c:set var="pathPrefix">${cms.requestContext.siteRoot}</c:set>
<c:if test="${fn:startsWith(content.value.ImageFolder.stringValue, '/shared/')}">
    <c:set var="pathPrefix" value="" />
</c:if>
<c:set var="path" value="${pathPrefix}${content.value.ImageFolder}" />
<c:set var="pageSize" value="${cms.element.setting.imagesPerPage.isSet ? cms.element.settings.imagesPerPage : '12' }" />

<c:set var="template"><%--
--%><div class="ap-square square-m-2 ${cms.element.settings.cssClass} comein zoom"><%--
    --%><a class="image-gallery" href="%(src)" title="%(titleAttr)"><%--
        --%><span class="content" style="background-image:url('%(src)');"><%--
            --%><span class="zoom-overlay"><%--
                --%><span class="zoom-icon"><%--
                    --%><i class="fa fa-search"></i><%--
               --%></span><%--
            --%></span><%--
        --%></span><%--
    --%></a><%--
--%></div>
</c:set>

<c:set var="id"><apollo:idgen prefix='imgal' uuid='${cms.element.instanceId}' /></c:set>

<div class="ap-image-gallery ${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : '' }">

    <c:if test="${not cms.element.settings.hidetitle}">
        <div class="headline">
            <h2 ${value.Title.rdfaAttr}>${value.Title}</h2>
        </div>
    </c:if>

    <c:choose>
    <c:when test="${value.ImageFolder.isSet}">
        <apollo:imagegallery
            id="${id}"
            path="${path}"
            count="${pageSize}"
            page="1"
            template="${template}"
            showtitle="${cms.element.setting.showTitle.value}"
            showcopyright="${cms.element.setting.showCopyright.value}"
            autoload="${cms.element.setting.autoload.value}"
        />
    </c:when>
    <c:when test="${cms.isEditMode}">
        <fmt:setLocale value="${cms.workplaceLocale}" />
        <cms:bundle basename="org.opencms.apollo.template.imagegallery.messages">
        <div id="ap-edit-info" class="box-warn animated fadeIn">
            <div class="head">
                 <fmt:message key="apollo.imagegallery.message.nofolder" />
            </div>
            <div class="text">
                 <fmt:message key="apollo.imagegallery.message.nofolder.hint" />
            </div>
        </div>
        </cms:bundle>
    </c:when>
    <c:otherwise>
        <fmt:setLocale value="${cms.locale}" />
        <cms:bundle basename="org.opencms.apollo.template.imagegallery.messages">
        <div>
            <fmt:message key="apollo.imagegallery.message.nofolder" />
        </div>
        </cms:bundle>
    </c:otherwise>
    </c:choose>


</div>

</cms:formatter>
</apollo:init-messages>