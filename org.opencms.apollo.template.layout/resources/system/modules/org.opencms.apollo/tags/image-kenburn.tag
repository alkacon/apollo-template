<%@ tag
    display-name="image-kenburn"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Formates an image with a Ken Burns effect" %>

<%@ attribute name="image" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" %>
<%@ attribute name="width" type="java.lang.Integer" required="true" %>
<%@ attribute name="link" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>
<%@ attribute name="headline" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="false" %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<c:if test="${image.isSet}">

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.formatters.messages">
<apollo:image-vars image="${image}">

<c:if test="${not empty imageLink}">

<div class="ap-img ${cms.element.settings.istyle}">

    <c:if test="${link.isSet && cms.element.settings.ilink != 'none'}">
        <a href="<cms:link>${link.value.URI}</cms:link>"
            <c:if test="${link.value.Text.isSet}">
            title="${link.value.Text}"
            </c:if>
        >
    </c:if>

    <%-- ####### ImageDnD workaround ##################################### --%>
    <%-- ####### image.value.Image.imageDndAttr doesn't work here ######## --%>
    <%-- ################################################################# --%>

    <c:if test="${not empty image && image.isSet}">
        <c:set var="conValue" value="${image.value.Image.contentValue}" />
        <c:set var="dndData" value="${conValue.document.file.structureId}|${conValue.path}|${conValue.locale}" />
        <c:set var="imageDnd">data-imagednd="${dndData}"</c:set>
    </c:if>

    <%-- ################################################################# --%>

    <%-- ####### Show image (with link button if enabled) ######## --%>
    <div class="thumbnail-kenburn">
        <span ${image.value.Image.rdfaAttr} ${imageDnd}>
            <div class="ap-img-pic ${cms.element.settings.istyle} ${' '} ${cms.element.settings.ieffect != 'none' ? cms.element.settings.ieffect : ''}">
                <c:catch var="exception">
                    <cms:img
                        src="${imageLink}"
                        scaleColor="transparent"
                        width="${width}"
                        scaleType="0"
                        cssclass="img-responsive"
                        alt="${imageTitle}${' '}${imageCopyright}"
                        title="${imageTitle}${' '}${imageCopyright}"
                    />
                </c:catch>

                <c:if test="${exception != null && cms.isEditMode}">
                    <p>Error displaying image: ${imageLink}</p>
                </c:if>
            </div>
        </span>
        <c:if test="${cms.element.settings.ilink == 'image'}">
            <a class="btn-more hover-effect"
                    href="<cms:link>${link.value.URI}</cms:link>"
                    <c:if test="${link.value.Text.isSet}">
                        title="${link.value.Text}"
                    </c:if>>${link.value.Text}</a>
        </c:if>
    </div>

    <%-- ####### Show copyright if enabled ######## --%>
    <c:if test="${fn:contains(cms.element.settings.itext, 'copy') && image.value.Copyright.isSet}">
        <div class="info">
            <p class="copyright"><i>${imageCopyright}</i></p>
        </div>
    </c:if>

    <%-- ####### Show title and/or headline if enabled ######## --%>
    <c:if test="${cms.element.settings.itext != 'none'}">
        <div class="ap-img-txt">
        <c:if test="${fn:contains(cms.element.settings.itext, 'title')}">
            <c:choose>
                <c:when test="${image.value.Title.isSet}">
                    <div class="ap-img-title"><span ${image.value.Title.rdfaAttr}>${image.value.Title}</span></div>
                </c:when>
                <c:when test="${headline.isSet}">
                    <div class="ap-img-title"><span ${headline.rdfaAttr}>${headline}</span></div>
                </c:when>
            </c:choose>
        </c:if>
        <c:if test="${fn:contains(cms.element.settings.itext, 'desc') && image.value.Description.isSet}">
                <div class="ap-img-desc"><span ${image.value.Description.rdfaAttr}>${image.value.Description}</span></div>
        </c:if>
        </div>
    </c:if>

    <c:if test="${link.isSet && cms.element.settings.ilink != 'none'}">
            </a>
    </c:if>

</div>

</c:if>

</apollo:image-vars>
</cms:bundle>

</c:if>
