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
<cms:bundle basename="org.opencms.apollo.template.job.messages">

<div class="ap-detail-page ap-job-page">

    <c:set var="propTitlePos"><cms:property file="search" name="apollo.job.detail.title" /></c:set>
    <c:set var="propColumns"><cms:property file="search" name="apollo.job.detail.columns" /></c:set>
    <c:if test="${empty propColumns}">
        <c:set var="titlePos"><cms:elementsetting name="titlepos" default="top" /></c:set>
    </c:if>

    <%-- First row OPENED --%>
    <div class="row">

        <%-- ####### Title (1st position option) ######## --%>
        <c:if test="${titlePos == 'top' || propTitlePos == 'top' || propTitlePos == 'both'}">
            <div class="col-xs-12 ap-job-headline">
                <h1 ${content.value.Title.rdfaAttr}>${content.value.Title}</h1>
            </div>
        </c:if>

        <%-- ####### INTRODUCTION ######## --%>
        <c:if test="${value.Introduction.isSet}">
            <div class="col-xs-12">
                <div class="ap-job-intro">
                    <apollo:paragraph paragraph="${value.Introduction}" imgalign="top"/>
                </div>
            </div>
        </c:if>

    <%-- ####### Title (2nd position option) ######## --%>
    <c:if test="${titlePos == 'bottom' || propTitlePos == 'center' || propTitlePos == 'both'}">
        <div class="col-xs-12 ap-job-headline">
            <h1 ${content.value.Title.rdfaAttr}>${content.value.Title}</h1>
        </div>
    </c:if>

    <%-- First row CLOSED --%>
    </div>   

    <%-- ####### TEXT BLOCKS (with optional bootstrap)######## --%>
    <c:choose>
    <c:when test="${cms.element.settings.columns || propColumns}">
        <c:forEach var="text" items="${content.valueList.Text}" varStatus="status">
            <c:if test="${status.index % 2 == 0}">
                <%-- Paragraph row OPENED --%>
                <c:out value='<div class="row">' escapeXml="false" />
            </c:if>
                <div class="col-xs-12 col-sm-6">
                    <apollo:paragraph paragraph="${text}" />
                </div>
            <c:if test="${status.index % 2 == 1 or status.last}">
                <%-- Paragraph row CLOSED --%>
                <c:out value='</div>' escapeXml="false" />
            </c:if>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <c:forEach var="text" items="${content.valueList.Text}" varStatus="status">
            <apollo:paragraph paragraph="${text}" />
        </c:forEach>
    </c:otherwise>
    </c:choose>

    <%-- ####### BOTTOM PARAGRAPH ######## --%>
    <c:if test="${value.BottomText.isSet}">
        <div class="row">
            <div class="col-xs-12">
                <apollo:paragraph paragraph="${value.BottomText}"/>
            </div>
        </div>
    </c:if>

    <%-- ####### LINK BUTTON ######## --%>
    <c:if test="${value.Link.isSet}">
        <c:set var="btnStyle" value="${cms.element.settings.btnstyle}" />
        <div class="row">
            <div class="${btnStyle == 'center' ? 'text-center' : ''} col-xs-12">
                <apollo:link link="${value.Link}" cssclass="btn ap-btn-${cms.element.settings.buttoncolor} ${btnStyle == 'full' ? 'center-block' : ''}" />
            </div>
        </div>
    </c:if>

</div>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>