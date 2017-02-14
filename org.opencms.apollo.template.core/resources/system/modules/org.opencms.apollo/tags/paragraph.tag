<%@ tag
    display-name="paragraph"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Displays a paragraph with optional elements." %>

<%@ attribute name="showimage" type="java.lang.String" required="false"
    description="Shows an image if 'true' and image is set in content.
    Default is 'true' if not provided." %>

<%@ attribute name="imgalign" type="java.lang.String" required="false"
    description="The image can be aligned 'left' or 'right'.
    Default is 'left' if not provided." %>

<%@ attribute name="imagecss" type="java.lang.String" required="false"
    description="CSS classes to attach to the image, for animation effects." %>

<%@ attribute name="headline" type="java.lang.String" required="false"
    description="If not set or 'top', the headline is placed on top of the content.
    If set to 'inline', then the headline is shown inline with the text.
    The 'inline' option has originally been created for the FAQ entries." %>

<%@ attribute name="headlinestyle" type="java.lang.String" required="false"
    description="Class attributes that define the headlines styling." %>

<%@ attribute name="paragraph" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true"
    description="The actual paragraph text." %>


<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<%-- ####### Preset optional attributes ######## --%>
<c:if test="${empty imgalign}"><c:set var="imgalign" value="left" /></c:if>

<c:set var="hasHeadline" value="${paragraph.value.Headline.isSet}" />
<c:set var="hasText" value="${paragraph.value.Text.isSet}" />
<c:set var="hasImage" value="${((empty showimage) or (showimage == 'true')) and paragraph.value.Image.isSet and paragraph.value.Image.value.Image.isSet}" />
<c:set var="hasLink" value="${paragraph.value.Link.isSet and paragraph.value.Link.value.URI.isSet}"/>
<c:set var="imagecss" value="${empty imagecss ? 'ap-kenburns-animation' : (imagecss != 'none' ? imagecss : '')}" />

<%-- ####### Render paragraph ######## --%>
<div class="ap-paragraph">

    <c:if test="${hasHeadline and ((headline == 'top') or (empty headline) or (!hasImage and !hasImage and !hasLink))}">
        <%-- ####### Show headline on top ######## --%>
        <div class="${not empty headlinestyle ? headlinestyle : 'headline'}">
            <h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3>
        </div>
    </c:if>

    <c:choose>
        <%-- ####### Show paragraph without image ######## --%>
        <c:when test="${!hasImage}">
            <c:if test="${hasText}">
                <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
            </c:if>

            <c:if test="${hasLink}">
                <p>
                    <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                </p>
            </c:if>
        </c:when>

        <%-- ####### Show paragraph with aligned image ######## --%>
        <c:when test="${((imgalign == 'left') or (imgalign == 'right')) and (hasText or hasLink or (hasHeadline and (headline == 'inline')))}">

            <div class="row">

                <div class="col-md-4 pull-${imgalign}">
                    <apollo:image-animated
                        image="${paragraph.value.Image}"
                        cssclass="${imagecss}" />
                </div>

                <div class="col-md-8">
                    <c:if test="${hasHeadline and (headline == 'inline')}">
                        <%-- ####### Show headline inline with text ######## --%>
                        <c:if test="${paragraph.value.Headline.isSet}">
                            <div class="${not empty headlinestyle ? headlinestyle : 'headline'}">
                                <h4 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h4>
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${hasText}">
                        <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                    </c:if>
                    <c:if test="${hasLink}">
                        <p>
                            <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                        </p>
                    </c:if>
                </div>

            </div>
        </c:when>

        <%-- ####### Show paragraph with image in top row ######## --%>
        <c:when test="${(imgalign == 'top') or (hasImage and not (hasText or hasLink))}">

            <div class="row">

                <div class="col-xs-12">
                    <apollo:image-animated
                        image="${paragraph.value.Image}"
                        cssclass="${(hasText or hasLink) ? 'image-ontop ' : ''}${imagecss}" />
                </div>

                <c:if test="${hasText or hasLink}">
                    <div class="col-xs-12">
                        <c:if test="${hasText}">
                            <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                        </c:if>
                        <c:if test="${hasLink}">
                            <p>
                                <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                            </p>
                        </c:if>
                    </div>
                </c:if>

            </div>
        </c:when>

    </c:choose>

</div>
