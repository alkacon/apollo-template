<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="apollo" tagdir="/WEB-INF/tags/apollo" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.apollo.template.faq.messages">
<cms:formatter var="content" val="value">

<c:set var="textnew"><fmt:message key="apollo.faq.message.new" /></c:set>
<apollo:init-messages textnew="${textnew}">

<div class="ap-detail-page ap-faq-page">

    <%-- FAQ header --%>
    <div class="row">
        <div class="col-xs-12">
            <apollo:headline headline="${content.value.Question}" />
        </div>

        <div class="col-xs-12 col-sm-6">
            <apollo:categorylist categories="${content.readCategories}" showbigicon="true" />
        </div>

    </div>
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

</apollo:init-messages>
</cms:formatter>
</cms:bundle> 