<%@page
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.imgur.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">

<c:set var="inMemoryMessage"><fmt:message key="apollo.section.message.new" /></c:set>
<apollo:init-messages textnew="${inMemoryMessage}">

<div class="ap-section ${cms.element.setting.cssclass.value}">
	<c:set var="usetitle" value="${cms.element.settings.usetitle}" />
    <c:set var="showlink" value="${cms.element.setting.showlink.value}"/>
    <c:set var="showsubitle" value="${cms.element.setting.showsubtitle.value}"/>
    <c:set var="showtext" value="${cms.element.setting.showtext.value}"/>

    <apollo:image-animated-imgur
        image="${value.Item}"
        cssclass="
            ${showlink ? 'ap-button-animation ' : ''}
            ${cms.element.setting.ieffect.value != 'none' ? cms.element.setting.ieffect.value : ''}">

        <c:if test="${showlink}">
            <div class="button-box">
				<a href="${value.Item.value.Data}" class="btn btn-xs" target="imgur"><fmt:message key="apollo.imgursection.message.link" /></a>
            </div>
        </c:if>

        <c:if test="${showsubitle or showtext}">
            <div class="text-box">

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

</apollo:init-messages>

</cms:formatter>
</cms:bundle>
