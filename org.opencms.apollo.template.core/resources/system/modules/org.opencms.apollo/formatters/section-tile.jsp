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
<cms:bundle basename="org.opencms.apollo.template.section.messages">

<apollo:image-vars image="${value.Image}">

<c:set var="imageBg" value="" />
<c:if test="${not empty imageUrl}">
    <c:set var="imageBg"> style="background-image:linear-gradient(rgba(0, 0, 0, 0.01),rgba(0, 0, 0, 0.4),rgba(0, 0, 0, 0.4),rgba(0, 0, 0, 0.01)),url('${imageUrl}');"</c:set>
</c:if>

<div class="ap-square ${cms.element.settings.wrapperclass}">
<div class="content ${cms.element.settings.innerwrapperclass}" ${imageBg}>
<div class="table">
<div class="table-cell">

    <c:if test="${value.Headline.isSet}">
        <h2 ${content.rdfa.Headline}>${value.Headline}</h2>
    </c:if>

    <c:if test="${value.Text.isSet}">
        <div <c:if test="${not value.Link.exists}">${content.rdfa.Link}</c:if>>
            <div ${content.rdfa.Text} ${not empty imageUrl ? content.imageDnd[value.Image.value.Image.path] : ''}>
                ${value.Text}
            </div>
            <c:if test="${value.Link.exists}">
                <p ${content.rdfa.Link}>
                    <apollo:link link="${value.Link}" cssclass="btn btn-sm" settitle="false"/>
                </p>
            </c:if>
        </div>
    </c:if>   

</div>
</div>
</div>
</div>

</apollo:image-vars>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>
