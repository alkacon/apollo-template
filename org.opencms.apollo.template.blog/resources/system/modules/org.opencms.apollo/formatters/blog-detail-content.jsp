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
<cms:bundle basename="org.opencms.apollo.template.blog.messages">

<c:choose>
<c:when test="${not empty content.valueList.Paragraph['1']}">

<div class="ap-detail-page ap-blog-page ap-blog-content">

    <c:set var="imgalign" value="${cms.element.setting.imgalign}" />
    <c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">

        <c:if test="${not status.first}">
            <apollo:paragraph 
                showimage="true"
                imgalign="${imgalign}"
                paragraph="${paragraph}" />

        </c:if>

    </c:forEach>
    <%-- //END paragraphs --%> 

    <c:set var="editblogpage">${cms.subSitePath}blog/post-a-new-blog-entry/</c:set>
    <c:if test="${content.isEditable and cms.vfs.existsResource[editblogpage]}">
        <a href="<cms:link>${editblogpage}</cms:link>?fileId=${content.id}">
            <button type="button" class="btn btn-default">Edit this blog entry</button>
        </a>
    </c:if>

</div>

</c:when>
<c:otherwise>
<div>
<c:if test="${cms.isEditMode}">
<div class="ap-container-element">
<cms:bundle basename="org.opencms.apollo.template.core.messages">
<div class="head"><fmt:message key="apollo.core.paragraph.no2nd" /></div>
</cms:bundle>
</div>
</c:if>
</div>
</c:otherwise>
</c:choose>

</cms:bundle>
</cms:formatter>

</apollo:init-messages>