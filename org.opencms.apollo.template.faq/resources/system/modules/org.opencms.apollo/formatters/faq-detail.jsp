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
<cms:bundle basename="org.opencms.apollo.template.faq.messages">

<div class="ap-detail-page ap-faq-page">

    <%-- FAQ header --%>
    <c:choose>
    <c:when test="${cms.element.setting.showmarkers.toBoolean}">
        <div class="row">
            <div class="col-xs-12">
                <apollo:headline headline="${content.value.Question}" />
            </div>
            <div class="col-xs-12 col-sm-6">
                <apollo:categorylist categories="${content.readCategories}" showbigicon="true" />
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <apollo:headline headline="${content.value.Question}" />
    </c:otherwise>
    </c:choose>
    <%-- //END FAQ header --%>

    <%-- paragraphs --%>
    <c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
    <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

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