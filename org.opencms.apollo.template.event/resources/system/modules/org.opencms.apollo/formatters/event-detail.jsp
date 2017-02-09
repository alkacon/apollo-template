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
<cms:bundle basename="org.opencms.apollo.template.event.messages">

<div class="ap-detail-page ap-event-page">

    <%-- event header --%>
    <div class="ap-event-header clearfix">

    <c:choose>
    <c:when test="${cms.element.setting.showmarkers.toBoolean}">

        <div class="row">
            <div class="col-xs-12">
                <apollo:headline headline="${content.value.Title}" />
            </div>

            <div class="col-xs-12 col-sm-6">

                <div class="row">
                <div class="col-xs-1 col-sm-2">
                    <i class="detail-icon fa fa-calendar"></i>
                </div>
                <div class="col-xs-11 col-sm-10 detail-date">

                    <h5>
                        <fmt:formatDate
                            value="${cms:convertDate(value.Date)}"
                            dateStyle="SHORT"
                            timeStyle="SHORT"
                            type="both" />
                        <c:if test="${value.EndDate.isSet}">
                            - <fmt:formatDate
                                value="${cms:convertDate(value.EndDate)}"
                                dateStyle="SHORT"
                                timeStyle="SHORT"
                                type="both" />
                        </c:if>
                    </h5>

                </div>
                </div>
                <apollo:categorylist categories="${content.readCategories}" showbigicon="true" />
            </div>

            <c:if test="${value.Location.isSet or value.Address.isSet or value.AddressDetails.isSet}">
                <div class="col-xs-1">
                    <i class="detail-icon fa fa-map-marker"></i>
                </div>
                <div class="col-xs-11 col-sm-5 detail-location">
                    <c:if test="${value.Location.isSet}">
                        <h5 ${content.rdfa.Location}>${value.Location}</h5>
                    </c:if>
                    <c:if test="${value.Address.isSet}">
                        <div ${content.rdfa.Address}>${value.Address}</div>
                    </c:if>
                    <c:if test="${value.AddressDetails.isSet}">
                        <div class="adress">
                            <div class="street"> ${value.AddressDetails.value.StreetAddress}</div>
                            <c:if test="${value.AddressDetails.value.ExtendedAddress.isSet}">
                                <div class="extended"> ${value.AddressDetails.value.ExtendedAddress}</div>
                            </c:if>
                            <div class="ap-contact-city">
                                <span class="code"> ${value.AddressDetails.value.PostalCode}</span>
                                <span class="region"> ${value.AddressDetails.value.Locality}</span>
                            </div>
                            <div class="ap-contact-region">
                                <c:if test="${value.AddressDetails.value.Region.isSet}">
                                    <span class="region"> ${value.AddressDetails.value.Region}</span>
                                </c:if>
                                <c:if test="${value.AddressDetails.value.Country.isSet}">
                                    <span class="country"> ${value.AddressDetails.value.Country}</span>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </c:if>

        </div>

    </c:when>
    <c:otherwise>
        <apollo:headline headline="${content.value.Title}" />
    </c:otherwise>
    </c:choose>

    </div>
    <%-- //END event header --%>

    <%-- paragraphs --%>
    <c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
    <c:forEach
        var="paragraph"
        items="${content.valueList.Paragraph}"
        varStatus="status">

        <apollo:paragraph
            showimage="true"
            imgalign="${imgalign}"
            paragraph="${paragraph}" />

    </c:forEach>
    <%-- //END paragraphs --%>
</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>