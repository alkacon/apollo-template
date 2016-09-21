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
<cms:bundle basename="org.opencms.apollo.template.schemas.section">
<cms:formatter var="content" val="value" rdfa="rdfa">

<c:set var="inMemoryMessage"><fmt:message key="apollo.section.message.new" /></c:set>
<apollo:init-messages textnew="${inMemoryMessage}">

<div class="ap-section ${cms.element.setting.cssclass.value}">
    <c:set var="showlink" value="${cms.element.setting.showlink.value}"/>
    <c:set var="showsubitle" value="${cms.element.setting.showsubtitle.value}"/>
    <c:set var="showtext" value="${cms.element.setting.showtext.value and value.Item.isSet}"/>
	
    <apollo:image-animated-imgur
        image="${value.Item}"
        cssclass="
            ${showlink ? 'ap-button-animation ' : ''}
            ${cms.element.setting.ieffect.value != 'none' ? cms.element.setting.ieffect.value : ''}">

        <c:if test="${showlink}">
            <div class="button-box">
				<c:set var="linktext"><fmt:message key="apollo.imgursection.message.link" /></c:set>
				<a href="${value.Item.value.Data}" class="btn btn-xs">${linktext}</a>
            </div>
        </c:if>

        <c:if test="${showsubitle or showtext}">
            <div class="text-box">

                <c:if test="${showsubitle}">
                    <h3 class="subtitle">
                        <a href="${value.Item.value.Data}">
							${value.Item.value.Title}
                        </a>
                    </h3>
                </c:if>

                <c:if test="${showtext}">
                    <div class="text">
                        ${value.Item.value.Description}
                    </div>
                </c:if>
            </div>
        </c:if>

    </apollo:image-animated-imgur>
</div>

</apollo:init-messages>

</cms:formatter>
</cms:bundle>