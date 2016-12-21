<%@ tag
    display-name="paragraph"
    body-content="empty"
    trimDirectiveWhitespaces="true"
    description="Formats a paragraph with optional elements from the given content" %>

<%@ attribute name="showimage" type="java.lang.String" required="false" description="Shows an image if 'true' and image is set in content." %>
<%@ attribute name="imgalign" type="java.lang.String" required="false" description="The image can be aligned 'left' or 'right'." %>
<%@ attribute name="headline" type="java.lang.String" required="false" description="The headline of the paragraph." %>
<%@ attribute name="headlinestyle" type="java.lang.String" required="false" description="Class attributes that define the headlines styling." %>
<%@ attribute name="paragraph" type="org.opencms.jsp.util.CmsJspContentAccessValueWrapper" required="true" description="The actual paragraph text." %>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>


<%-- ####### Preset optional attributes ######## --%>
<c:if test="${empty showimage}"><c:set var="showimage" value="true" /></c:if>
<c:if test="${!paragraph.value.Image.isSet}">
    <c:set var="showimage" value="false" />
</c:if>
<c:if test="${empty imgalign}"><c:set var="imgalign" value="left" /></c:if>


<%-- ####### Render paragraph ######## --%>
<div class="ap-paragraph">

    <c:if test="${headline == 'top' or empty headline}">
        <%-- ####### Show headline on top ######## --%>
        <c:if test="${paragraph.value.Headline.isSet}">
            <div class="${not empty headlinestyle ? headlinestyle : 'headline'}">
                <h4 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h4>
            </div>
        </c:if>
    </c:if>

    <c:choose>
        <%-- ####### Show paragraph without image ######## --%>
        <c:when test="${!showimage}">
            <span ${paragraph.rdfa.Image}></span>
            <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>

            <c:if test="${paragraph.value.Link.exists}">
                <p>
                    <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                </p>
            </c:if>
        </c:when>

        <%-- ####### Show paragraph with aligned image ######## --%>
        <c:when test="${imgalign == 'left' or imgalign == 'right'}">

            <c:set var="copyright">${paragraph.value.Image.value.Copyright}</c:set>
                <c:if test="${not empty copyright}">
                <c:set var="copyrightSymbol">(c)</c:set>
                <c:set var="copyright">${fn:replace(copyright, '&copy;', copyrightSymbol)}</c:set>
                <c:if test="${not fn:contains(copyright, copyrightSymbol)}">
                    <c:set var="copyright">${copyrightSymbol}${' '}${copyright}</c:set>
                </c:if>
            </c:if>

            <div class="row">

                <div class="col-md-4 pull-${imgalign}">
                    <apollo:image-animated
                        image="${paragraph.value.Image}"
                        cssclass="ap-kenburns-animation" />
                </div>

                <div class="col-md-8">
                    <c:if test="${headline == 'inline'}">
                        <%-- ####### Show headline inline with text ######## --%>
                        <c:if test="${paragraph.value.Headline.isSet}">
                            <div class="${not empty headlinestyle ? headlinestyle : 'headline'}">
                                <h4 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h4>
                            </div>
                        </c:if>
                    </c:if>
                    <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                    <c:if test="${paragraph.value.Link.exists}">
                        <p>
                            <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                        </p>
                    </c:if>
                </div>

            </div>
        </c:when>

        <%-- ####### Show paragraph with image in top row ######## --%>
        <c:when test="${imgalign == 'top'}">

            <c:set var="copyright">${paragraph.value.Image.value.Copyright}</c:set>
                <c:if test="${not empty copyright}">
                <c:set var="copyrightSymbol">(c)</c:set>
                <c:set var="copyright">${fn:replace(copyright, '&copy;', copyrightSymbol)}</c:set>
                <c:if test="${not fn:contains(copyright, copyrightSymbol)}">
                    <c:set var="copyright">${copyrightSymbol}${' '}${copyright}</c:set>
                </c:if>
            </c:if>

            <div class="row">

                <div class="col-xs-12">
                    <apollo:image-animated
                        image="${paragraph.value.Image}"
                        cssclass="image-ontop" />
                </div>

                <div class="col-xs-12">
                    <div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
                    <c:if test="${paragraph.value.Link.exists}">
                        <p>
                            <apollo:link link="${paragraph.value.Link}" cssclass="btn btn-sm"/>
                        </p>
                    </c:if>
                </div>

            </div>
        </c:when>

    </c:choose>

</div>
